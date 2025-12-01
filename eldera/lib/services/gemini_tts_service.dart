import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';

/// Service class for handling Gemini TTS with Kore voice
class GeminiTtsService {
  static final GeminiTtsService _instance = GeminiTtsService._internal();
  factory GeminiTtsService() => _instance;
  GeminiTtsService._internal();

  String? _apiKey;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isInitialized = false;
  bool _isPlaying = false;
  Directory? _cacheDir;

  static const String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models';
  static const String _model = 'gemini-2.5-flash-preview-tts';

  /// Initialize the Gemini TTS service
  Future<void> initialize(String apiKey) async {
    try {
      _apiKey = apiKey;
      _isInitialized = true;
      _cacheDir = await _ensureCacheDir();
      debugPrint('Gemini TTS Service initialized successfully with Kore voice');
    } catch (e) {
      debugPrint('Failed to initialize Gemini TTS Service: $e');
      throw Exception('Failed to initialize Gemini TTS Service: $e');
    }
  }

  /// Check if the service is initialized
  bool get isInitialized => _isInitialized;

  /// Check if audio is currently playing
  bool get isPlaying => _isPlaying;

  /// Generate speech using Gemini TTS with Kore voice (with caching)
  Future<void> speak(String text) async {
    if (!_isInitialized || _apiKey == null) {
      throw Exception('Gemini TTS Service not initialized');
    }

    if (text.isEmpty) {
      debugPrint('Empty text provided to speak');
      return;
    }

    try {
      final filePath = await generate(text);
      await _playAudio(filePath);
      debugPrint('Played speech from cache/file with Kore voice');
    } catch (e) {
      debugPrint('Error generating speech with Gemini TTS: $e');
      throw Exception('Failed to generate speech: $e');
    }
  }

  /// Prefetch and cache audio for given text without playing
  Future<void> prefetch(String text) async {
    if (!_isInitialized || _apiKey == null || text.isEmpty) return;
    try {
      await generate(text);
    } catch (_) {}
  }

  /// Generate audio file for text; returns cached or newly created file path
  Future<String> generate(String text) async {
    if (!_isInitialized || _apiKey == null) {
      throw Exception('Gemini TTS Service not initialized');
    }
    if (text.isEmpty) {
      throw Exception('Empty text provided');
    }

    final cacheDir = _cacheDir ?? await _ensureCacheDir();
    final slug = _slugify(text);
    final audioFile = File('${cacheDir.path}/$slug.wav');
    if (await audioFile.exists()) {
      return audioFile.path;
    }

    final url = '$_baseUrl/$_model:generateContent?key=${_apiKey!}';
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'contents': [
        {
          'parts': [
            {'text': text}
          ]
        }
      ],
      'generationConfig': {'responseMimeType': 'audio/wav'},
      'audioConfig': {
        'voiceConfig': {
          'prebuiltVoiceConfig': {'voiceName': 'Kore'}
        }
      }
    });

    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode != 200) {
      throw Exception('HTTP Error: ${response.statusCode} - ${response.body}');
    }
    final responseData = jsonDecode(response.body);
    if (responseData['candidates'] == null ||
        responseData['candidates'].isEmpty) {
      throw Exception('No candidates received from Gemini TTS');
    }
    final candidate = responseData['candidates'][0];
    final parts = candidate['content']?['parts'];
    if (parts == null || parts.isEmpty) {
      throw Exception('No content parts received from Gemini TTS');
    }
    final inline = parts[0]['inlineData'];
    if (inline == null || inline['data'] == null) {
      throw Exception('No audio data received from Gemini TTS');
    }
    final audioData = base64Decode(inline['data'] as String);
    await audioFile.writeAsBytes(audioData);
    return audioFile.path;
  }

  Future<Directory> _ensureCacheDir() async {
    final tempDir = await getTemporaryDirectory();
    final dir = Directory('${tempDir.path}/tts_cache');
    if (!(await dir.exists())) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  String _slugify(String text) {
    final b64 = base64Url.encode(utf8.encode(text));
    // Shorten for filesystem limits
    final short = b64.replaceAll('=', '');
    return short.length > 32 ? short.substring(0, 32) : short;
  }

  /// Convert L16 PCM audio data to WAV format
  Uint8List _convertL16ToWav(
    Uint8List inputData, {
    int sampleRate = 24000,
    int numChannels = 1,
    int bitsPerSample = 16,
  }) {
    final blockAlign = numChannels * bitsPerSample ~/ 8;
    final byteRate = sampleRate * blockAlign;
    final dataSize = inputData.length;
    final fileSize = 36 + dataSize;

    final header = ByteData(44);

    // RIFF header
    header.setUint8(0, 0x52); // 'R'
    header.setUint8(1, 0x49); // 'I'
    header.setUint8(2, 0x46); // 'F'
    header.setUint8(3, 0x46); // 'F'
    header.setUint32(4, fileSize, Endian.little);

    // WAVE header
    header.setUint8(8, 0x57); // 'W'
    header.setUint8(9, 0x41); // 'A'
    header.setUint8(10, 0x56); // 'V'
    header.setUint8(11, 0x45); // 'E'

    // fmt chunk
    header.setUint8(12, 0x66); // 'f'
    header.setUint8(13, 0x6D); // 'm'
    header.setUint8(14, 0x74); // 't'
    header.setUint8(15, 0x20); // ' '
    header.setUint32(16, 16, Endian.little); // fmt chunk size
    header.setUint16(20, 1, Endian.little); // audio format (PCM)
    header.setUint16(22, numChannels, Endian.little);
    header.setUint32(24, sampleRate, Endian.little);
    header.setUint32(28, byteRate, Endian.little);
    header.setUint16(32, blockAlign, Endian.little);
    header.setUint16(34, bitsPerSample, Endian.little);

    // data chunk
    header.setUint8(36, 0x64); // 'd'
    header.setUint8(37, 0x61); // 'a'
    header.setUint8(38, 0x74); // 't'
    header.setUint8(39, 0x61); // 'a'
    header.setUint32(40, dataSize, Endian.little);

    // Combine header and audio data
    final result = Uint8List(44 + dataSize);
    result.setRange(0, 44, header.buffer.asUint8List());
    result.setRange(44, 44 + dataSize, inputData);

    return result;
  }

  /// Play audio file
  Future<void> _playAudio(String filePath) async {
    try {
      _isPlaying = true;
      await _audioPlayer.play(DeviceFileSource(filePath));

      // Listen for completion
      _audioPlayer.onPlayerComplete.listen((_) {
        _isPlaying = false;
        debugPrint('Audio playback completed');
      });
    } catch (e) {
      _isPlaying = false;
      debugPrint('Error playing audio: $e');
      throw Exception('Failed to play audio: $e');
    }
  }

  /// Stop current speech
  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
      _isPlaying = false;
      debugPrint('Speech stopped');
    } catch (e) {
      debugPrint('Error stopping speech: $e');
    }
  }

  /// Pause current speech
  Future<void> pause() async {
    try {
      await _audioPlayer.pause();
      debugPrint('Speech paused');
    } catch (e) {
      debugPrint('Error pausing speech: $e');
    }
  }

  /// Resume paused speech
  Future<void> resume() async {
    try {
      await _audioPlayer.resume();
      debugPrint('Speech resumed');
    } catch (e) {
      debugPrint('Error resuming speech: $e');
    }
  }

  /// Set speech rate (not applicable for Gemini TTS, but kept for compatibility)
  Future<void> setSpeechRate(double rate) async {
    debugPrint('Speech rate setting not supported by Gemini TTS');
  }

  /// Set speech pitch (not applicable for Gemini TTS, but kept for compatibility)
  Future<void> setPitch(double pitch) async {
    debugPrint('Pitch setting not supported by Gemini TTS');
  }

  /// Set speech volume (not applicable for Gemini TTS, but kept for compatibility)
  Future<void> setVolume(double volume) async {
    debugPrint('Volume setting not supported by Gemini TTS');
  }

  /// Get available voices (returns Kore voice info)
  Future<List<Map<String, String>>> getVoices() async {
    return [
      {
        'name': 'Kore',
        'locale': 'en-US',
        'quality': 'high',
        'provider': 'Gemini TTS'
      }
    ];
  }

  /// Set voice (always uses Kore voice)
  Future<void> setVoice(Map<String, String> voice) async {
    debugPrint('Voice is fixed to Kore in Gemini TTS service');
  }

  /// Dispose resources
  void dispose() {
    _audioPlayer.dispose();
    _isInitialized = false;
    debugPrint('Gemini TTS Service disposed');
  }
}
