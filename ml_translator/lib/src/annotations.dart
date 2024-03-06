import 'package:ml_translator/src/translation_language.dart';

class MlTranslator {
  final TranslationLanguage baseLanguage;
  final String downloading;
  final String translating;
  final String done;
  final String error;

  const MlTranslator({
    required this.baseLanguage,
    this.downloading = 'Downloading language model',
    this.translating = 'Translating',
    this.done = 'Done',
    this.error = 'Error',
  });
}

class Val {
  final String val;
  final String? en;
  final String? pl;
  final String? dk;

  const Val(
    this.val, {
    this.en,
    this.pl,
    this.dk,
  });
}
