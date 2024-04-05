import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../ml_translator_gen.dart';

class TranslatorUtils {
  static const kMlTranslator = 'ml_translator';

  static const kSource = 'source';
  static const kSourceLanguage = 'source_language';

  static const kTarget = 'target';
  static const kTargetLanguage = 'target_language';

  static const kAutoDetectionDialog = 'auto_detection_dialog';

  static TranslationLanguage? _sourceLanguage;
  static TranslationLanguage? _targetLanguage;
  static OnDeviceTranslator? _translator;
  static Box? box;

  static bool showTranslationDialog = false;

  static bool get isInitialized => _translator != null;

  static Future<void> initDb() async {
    await Hive.initFlutter();

    box = await Hive.openBox(kMlTranslator);

    final detectionDialogShown = box!.get(kAutoDetectionDialog);

    if (detectionDialogShown == null || !detectionDialogShown) {
      showTranslationDialog = true;

      box!.put(kAutoDetectionDialog, false);
    }
  }

  static Future<void> closeDb() async => await box!.close();

  static (T, TranslationLanguage?) initTranslation<T extends MlTranslation>(
    T translation,
  ) {
    if (box == null || !box!.isOpen) {
      throw Exception('''
Translator has not been initialized.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Translator.init();

  runApp(const MyApp());
}

''');
    }

    final source = (box!.get(kSource) as Map?)?.cast<String, dynamic>();

    // Save translation source to db if it is first run.
    if (source == null) {
      box!
        ..put(kSource, translation.toJson())
        ..put(kSourceLanguage, translation.sourceLanguage);

      return (translation, null);
    }

    MlTranslation? sourceTranslation;

    try {
      sourceTranslation = translation.fromJson(source);
    } catch (_) {
      sourceTranslation = null;
    }

    // Translation source has been changed
    if (sourceTranslation != translation) {
      // Target language name
      final targetLanguage = box!.get(kTargetLanguage) as String?;

      box!
        ..put(kSource, translation.toJson())
        ..put(kSourceLanguage, translation.sourceLanguage);

      if (targetLanguage != null) {
        TranslationLanguage? translationLanguage;

        try {
          translationLanguage = TranslationLanguage.fromJson(targetLanguage);
        } catch (_) {
          translationLanguage = null;
        }

        return (translation, translationLanguage);
      }
    } else {
      final target = (box!.get(kTarget) as Map?)?.cast<String, dynamic>();

      if (target != null) {
        final targetTranslation = translation.fromJson(target) as T;

        return (targetTranslation, null);
      }
    }

    return (translation, null);
  }

  static Future<bool> initLanguageModels(
    TranslationLanguage sourceLanguage,
    TranslationLanguage targetLanguage,
  ) async {
    final shouldInitSource =
        _sourceLanguage == null || _sourceLanguage != sourceLanguage;

    if (shouldInitSource) {
      final isInitialized = await _initSourceLanguage(sourceLanguage);

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

      final isInitialized = await _initTargetLanguage(targetLanguage);

      if (!isInitialized) {
        _targetLanguage == null;
        return false;
      }

      _targetLanguage = targetLanguage;
    }

    if (_translator == null || shouldInitTarget || shouldInitSource) {
      _translator = OnDeviceTranslator(
        sourceLanguage: toTranslateLanguage(sourceLanguage),
        targetLanguage: toTranslateLanguage(targetLanguage),
      );
    }

    return true;
  }

  static Future<String> translate(String string) async {
    if (!string.contains('%s')) {
      return await _translator!.translateText(string);
    }

    final replaced = string.replaceAll('%s', 'xxxx');

    final result = await _translator!.translateText(replaced);

    return result
        .replaceAll('xxxx', '%s')
        .replaceAll('XXXX', '%s')
        .replaceAll('Xxxx', '%s');
  }

  static Future<String> translateForWidget(String string) async {
    if (!string.contains('%s')) {
      return await _translator!.translateText(string);
    }

    final replaced = string.replaceAll('%s', 'xxxx');

    final result = await _translator!.translateText(replaced);

    return result
        .replaceAll('xxxx', '%s')
        .replaceAll('XXXX', '%s')
        .replaceAll('Xxxx', '%s');
  }

  static Future<bool> _initSourceLanguage(TranslationLanguage language) async {
    final modelManager = OnDeviceTranslatorModelManager();

    final isDownloaded = await modelManager.isModelDownloaded(language.code);

    if (!isDownloaded) {
      try {
        await modelManager.downloadModel(language.code);
      } catch (_) {
        return false;
      }
    }

    return true;
  }

  static Future<bool> _initTargetLanguage(TranslationLanguage language) async {
    final modelManager = OnDeviceTranslatorModelManager();

    final targetLanguage = box!.get(kTargetLanguage) as String?;

    if (targetLanguage != null) {
      final translationLanguage = TranslationLanguage.fromJson(targetLanguage);

      if (language != translationLanguage) {
        box!.delete(kTargetLanguage);

        await modelManager.deleteModel(translationLanguage.code);
      }
    }

    final isDownloaded = await modelManager.isModelDownloaded(language.code);

    if (!isDownloaded) {
      try {
        await modelManager.downloadModel(language.code);
      } catch (_) {
        return false;
      }
    }

    box!.put(kTargetLanguage, language.toJson());

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

  static TranslateLanguage toTranslateLanguage(
    TranslationLanguage translationLanguage,
  ) =>
      TranslateLanguage.values.byName(translationLanguage.name);

  static void saveTranslation<T extends MlTranslation>(T translation) =>
      box!.put(kTarget, translation.toJson());

  static bool isCurrentLanguage(TranslationLanguage targetLanguage) {
    final current = box!.get(kTargetLanguage) as String?;

    if (current == null) return false;

    final currentLanguage = TranslationLanguage.fromJson(current);

    return currentLanguage == targetLanguage;
  }

  static void setDialogShown() async =>
      await box!.put(kAutoDetectionDialog, true);
}
