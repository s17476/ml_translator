import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:ml_translator/ml_translator.dart';
// import 'package:ml_translator/src/translation_language.dart';

class TranslatorUtils {
  static TranslationLanguage? _sourceLanguage;
  static TranslationLanguage? _targetLanguage;
  static OnDeviceTranslator? _translator;

  static Future<bool> initTranslator(
    TranslationLanguage sourceLanguage,
    TranslationLanguage targetLanguage,
  ) async {
    final shouldInitSource =
        _sourceLanguage == null || _sourceLanguage != sourceLanguage;

    if (shouldInitSource) {
      final isInitialized = await _initLanguage(sourceLanguage);

      if (!isInitialized) {
        _sourceLanguage == null;
        return false;
      }

      _sourceLanguage = sourceLanguage;
    }

    final shouldInitTarget =
        _targetLanguage == null || _targetLanguage != targetLanguage;

    if (shouldInitTarget) {
      await deleteLanguage(_targetLanguage);

      final isInitialized = await _initLanguage(targetLanguage);

      if (!isInitialized) {
        _targetLanguage == null;
        return false;
      }

      _targetLanguage = targetLanguage;
    }

    if (_translator == null || shouldInitTarget || shouldInitSource) {
      _translator = OnDeviceTranslator(
        sourceLanguage: sourceLanguage.toTranslateLanguage(),
        targetLanguage: targetLanguage.toTranslateLanguage(),
      );
    }

    return true;
  }

  static Future<String> translate(
    String string,
  ) async {
    final result = await _translator!.translateText(string);

    return result;
  }

  static Future<bool> _initLanguage(TranslationLanguage language) async {
    print('XXXXX download start');
    final modelManager = OnDeviceTranslatorModelManager();

    final isDownloaded = await modelManager.isModelDownloaded(language.code);

    if (!isDownloaded) {
      //TODO dodać obsługę false
      try {
        await modelManager.downloadModel(language.code);
      } catch (_) {
        return false;
      }
    }
    print('XXXXX download finish');
    return true;
  }

  static Future<bool> deleteLanguage(TranslationLanguage? language) async {
    if (language != null) {
      final modelManager = OnDeviceTranslatorModelManager();

      try {
        await modelManager.deleteModel(language.code);
      } catch (_) {
        return false;
      }
    }

    return true;
  }
}
