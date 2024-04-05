import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:ml_translator/ml_translator_gen.dart';
import 'package:ml_translator_generator/src/models/class_pattern.dart';
import 'package:ml_translator_generator/src/models/mixin.dart';
import 'package:ml_translator_generator/src/models/translated_text.dart';
import 'package:ml_translator_generator/src/models/translator_state.dart';
import 'package:ml_translator_generator/src/models/translator_widget.dart';

import 'model_visitor.dart';

class TranslatorGenerator extends GeneratorForAnnotation<MlTranslator> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final visitor = ModelVisitor();

    element.visitChildren(visitor);

    final buffer = StringBuffer();

    // Loading widget translations
    final translations = [
      'sourceLanguage',
      'downloading',
      'translating',
      'done',
      'error'
    ];

    createClassPattern(buffer, visitor, annotation, translations);

    createMixin(buffer, visitor);

    createTranslatorWidget(buffer);

    createTranslatorState(buffer, visitor, annotation, translations);

    createTranslatedText(buffer, visitor);

    return buffer.toString();
  }
}
