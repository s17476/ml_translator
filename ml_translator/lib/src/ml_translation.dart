import '../ml_translator_gen.dart';

abstract class MlTranslation {
  const MlTranslation();

  String get sourceLanguage;

  String get $downloading;

  String get $translating;

  String get $error;

  String get $done;

  String get $attribution;

  Future<void> translateTo(TranslationLanguage targetLanguage);
}
