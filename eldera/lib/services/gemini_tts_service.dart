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

  static const String _baseUrl = 'https://generativelanguage.googleapis.com/v1beta/models';
  static const String _model = 'gemini-2.5-flash-preview-tts';

  /// Initialize the Gemini TTS service
  Future<void> initialize(String apiKey) async {
    try {
      _apiKey = apiKey;
      _isInitialized = true;
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

  /// Generate speech using Gemini TTS with Kore voice
  Future<void> speak(String text) async {
    if (!_isInitialized || _apiKey == null) {
      throw Exception('Gemini TTS Service not initialized');
    }

    if (text.isEmpty) {
      debugPrint('Empty text provided to speak');
      return;
    }

    try {
      debugPrint('Generating speech with Gemini TTS using Kore voice: $text');
      
      final url = '$_baseUrl/$_model:generateContent';
      final headers = {
        'Content-Type': 'application/json',
        'x-goog-api-key': _apiKey!,
      };

      final body = jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': text}
            ]
          }
        ],
        'generationConfig': {
          'responseModalities': ['AUDIO'],
          'speechConfig': {
            'voiceConfig': {
              'prebuiltVoiceConfig': {
                'voiceName': 'Kore'
              }
            }
          }
        }
      });

      debugPrint('Making request to Gemini TTS API...');
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        
        if (responseData['candidates'] != null && 
            responseData['candidates'].isNotEmpty) {
          final candidate = responseData['candidates'][0];
          
          if (candidate['content'] != null && 
              candidate['content']['parts'] != null &&
              candidate['content']['parts'].isNotEmpty) {
            final part = candidate['content']['parts'][0];
            
            if (part['inlineData'] != null && part['inlineData']['data'] != null) {
              // Decode base64 audio data
              final base64Data = part['inlineData']['data'] as String;
              final audioData = base64Decode(base64Data);
              
              // Convert L16 PCM to WAV format
              final wavData = _convertL16ToWav(audioData);
              
              // Save audio to temporary file
              final tempDir = await getTemporaryDirectory();
              final audioFile = File('${tempDir.path}/gemini_tts_${DateTime.now().millisecondsSinceEpoch}.wav');
              await audioFile.writeAsBytes(wavData);
              
              // Play the audio
              await _playAudio(audioFile.path);
              
              debugPrint('Successfully generated and played speech with Kore voice');
            } else {
              throw Exception('No audio data received from Gemini TTS');
            }
          } else {
            throw Exception('No content parts received from Gemini TTS');
          }
        } else {
          throw Exception('No candidates received from Gemini TTS');
        }
      } else {
        debugPrint('HTTP Error: ${response.statusCode} - ${response.body}');
        throw Exception('HTTP Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      debugPrint('Error generating speech with Gemini TTS: $e');
      throw Exception('Failed to generate speech: $e');
    }
  }

  /// Convert L16 PCM audio data to WAV format
  Uint8List _convertL16ToWav(Uint8List inputData, {
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
    header.setUint8(8, 0x57);  // 'W'
    header.setUint8(9, 0x41);  // 'A'
    header.setUint8(10, 0x56); // 'V'
    header.setUint8(11, 0x45); // 'E'
    
    // fmt chunk
    header.setUint8(12, 0x66); // 'f'
    header.setUint8(13, 0x6D); // 'm'
    header.setUint8(14, 0x74); // 't'
    header.setUint8(15, 0x20); // ' '
    header.setUint32(16, 16, Endian.little); // fmt chunk size
    header.setUint16(20, 1, Endian.little);  // audio format (PCM)
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