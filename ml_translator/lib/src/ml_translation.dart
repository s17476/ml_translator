import 'package:ml_translator/ml_translator.dart';

abstract class MlTranslation {
  const MlTranslation();

  TranslationLanguage get sourceLanguage;

  String get $downloading;

  String get $translating;

  String get $error;

  String get $done;

  String get $attribution;

  Future<void> translateTo(TranslationLanguage targetLanguage);
}
