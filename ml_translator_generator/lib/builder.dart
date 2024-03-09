library ml_translator_generator;

import 'package:build/build.dart';
import 'src/ml_translator_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder translatorBuilder(BuilderOptions options) => PartBuilder(
      [TranslatorGenerator()],
      '.translator.dart',
      options: options,
    );
