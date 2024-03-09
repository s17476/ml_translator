import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:ml_translator/ml_translator.dart';
import 'model_visitor.dart';

import 'package:source_gen/source_gen.dart';

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

    // class
    buffer.writeln('mixin _\$${visitor.className} {');

    // fields
    for (int i = 0; i < visitor.fields.length; i++) {
      buffer.writeln(
        'final ${visitor.fields.values.elementAt(i)} ${visitor.fields.keys.elementAt(i)};',
      );
    }

    // constructor
    buffer.writeln('const _\$${visitor.className}({');

    for (int i = 0; i < visitor.fields.length; i++) {
      buffer.writeln(
        'required this.${visitor.fields.keys.elementAt(i)},',
      );
    }

    buffer.writeln('});');

    buffer.writeln('}');

    print(buffer.toString());

    return buffer.toString();
  }
}
