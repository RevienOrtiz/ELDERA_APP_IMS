import 'package:flutter_tts/flutter_tts.dart';

class LocalTtsService {
  static final LocalTtsService _instance = LocalTtsService._internal();
  factory LocalTtsService() => _instance;
  LocalTtsService._internal();

  final FlutterTts _tts = FlutterTts();
  bool _isInitialized = false;
  bool _isSpeaking = false;

  Future<void> initialize() async {
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.47);
    await _tts.setPitch(1.05);

    try {
      final engines = await _tts.getEngines;
      if (engines is List && engines.contains('com.google.android.tts')) {
        await _tts.setEngine('com.google.android.tts');
      }

      final voices = await _tts.getVoices;
      if (voices is List) {
        Map<String, String>? selected;
        for (final v in voices) {
          if (v is Map) {
            final name = (v['name']?.toString() ?? '').toLowerCase();
            final locale = (v['locale']?.toString() ?? '').toLowerCase();
            final isEn = locale.startsWith('en');
            final isFemale = name.contains('female') ||
                name.contains('fema') ||
                name.contains('en-us-x');
            if (isEn && isFemale) {
              selected = {
                'name': v['name'].toString(),
                'locale': v['locale'].toString(),
              };
              break;
            }
          }
        }
        selected ??= voices
            .cast<Map>()
            .where((m) =>
                (m['locale']?.toString() ?? '').toLowerCase().startsWith('en'))
            .map((m) => {
                  'name': m['name'].toString(),
                  'locale': m['locale'].toString(),
                })
            .firstOrNull;
        if (selected != null) {
          await _tts.setVoice(selected);
        }
      }
    } catch (_) {}

    _isInitialized = true;
    _tts.setCompletionHandler(() {
      _isSpeaking = false;
    });
  }

  bool get isInitialized => _isInitialized;

  Future<void> speak(String text) async {
    if (!_isInitialized) {
      await initialize();
    }
    if (text.isEmpty) return;
    _isSpeaking = true;
    await _tts.speak(text);
  }

  Future<void> stop() async {
    await _tts.stop();
    _isSpeaking = false;
  }

  void dispose() {
    _tts.stop();
  }
}
