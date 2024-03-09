import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:ml_translator/ml_translator.dart';
import 'model_visitor.dart';

import 'package:source_gen/source_gen.dart';

const kUnusedElement = '// ignore: unused_element';

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
    buffer.writeln(
      'class _${visitor.className} implements Example, MlTranslation {',
    );

    // // constructor
    buffer.writeln('  const _${visitor.className}({');

    // annotation.read('sourceLanguage');

    buffer.writeln('  $kUnusedElement');
    buffer.writeln(
      '  this.sourceLanguage = \'${annotation.read('baseLanguage').stringValue}\',',
    );
    buffer.writeln('  $kUnusedElement');
    buffer.writeln(
      '  this.downloading = \'${annotation.read('downloading').stringValue}\',',
    );
    buffer.writeln('  $kUnusedElement');
    buffer.writeln(
      '  this.translating = \'${annotation.read('translating').stringValue}\',',
    );
    buffer.writeln('  $kUnusedElement');
    buffer.writeln(
      '  this.done = \'${annotation.read('done').stringValue}\',',
    );
    buffer.writeln('  $kUnusedElement');
    buffer.writeln(
      '  this.error = \'${annotation.read('error').stringValue}\',',
    );
    buffer.writeln(
      '  this.attribution = \'THIS SERVICE MAY CONTAIN TRANSLATIONS POWERED BY GOOGLE. GOOGLE DISCLAIMS ALL WARRANTIES RELATED TO THE TRANSLATIONS, EXPRESS OR IMPLIED, INCLUDING ANY WARRANTIES OF ACCURACY, RELIABILITY, AND ANY IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.\',',
    );

    // pola konstruktora

    buffer.writeAll(objects)

    for (int i = 0; i < visitor.fields.length; i++) {
      buffer.writeln(
        'required this.${visitor.fields.keys.elementAt(i)},',
      );
    }

    buffer.writeln('  });');

    buffer.writeln('}');

    print(buffer.toString());

    return buffer.toString();
  }
}
