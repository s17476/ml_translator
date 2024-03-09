library ml_translator_generator;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/ml_translator_generator.dart';

Builder translatorBuilder(BuilderOptions options) {
  return PartBuilder(
    [TranslatorGenerator()],
    '.translator.dart',
    options: options,
  );
}
