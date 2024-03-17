import '../ml_translator_gen.dart';

abstract class MlTranslation {
  const MlTranslation();

  String get sourceLanguage;

  String get $downloading;

  String get $translating;

  String get $error;

  String get $done;

  String get $attribution;

  Map<String, String>? get $translations;

  Future<Object> translateTo(TranslationLanguage targetLanguage);

  Map<String, dynamic> toJson();

  MlTranslation fromJson(Map<String, dynamic> json);
}
