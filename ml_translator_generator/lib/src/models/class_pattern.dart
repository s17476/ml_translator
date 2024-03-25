import 'package:source_gen/source_gen.dart';

import 'package:ml_translator/ml_translator_gen.dart';
import 'package:ml_translator_generator/src/model_visitor.dart';

void createClassPattern(
  StringBuffer buffer,
  ModelVisitor visitor,
  ConstantReader annotation,
  List<String> translations,
) {
  // $translations map start
  //
  //This map stores custom translations provided by the developer in [Val] annotations.
  //Constructor fields for which custom values have been provided are not translated by the language model.
  buffer.writeln('const _\$translations = <String, String>{');

  final languageCodes = TranslationLanguage.values.map((e) => e.code);

  for (var element in visitor.elements) {
    for (var code in languageCodes) {
      final annotation = element.metadata[0].computeConstantValue();

      final translation = annotation?.getField(code)?.toStringValue();

      if (translation != null) {
        buffer.writeln(
          '\'${element.displayName}_$code\': \'$translation\',',
        );
      }
    }
  }

  buffer.writeln('  };\n');
  // translations map stop

  // class
  buffer.writeln(
    'class _${visitor.className} implements ${visitor.className}, MlTranslation {',
  );

  // constructor start
  buffer.writeln('  const _${visitor.className}({');

  for (var field in translations) {
    if (field == 'sourceLanguage') {
      buffer.writeln(
        '  this.$field = \'${annotation.read(field).stringValue}\',',
      );
    } else {
      buffer.writeln(
        '  this.\$$field = \'${annotation.read(field).stringValue}\',',
      );
    }
  }

  buffer.writeln(
    '  this.\$attribution = \'THIS SERVICE MAY CONTAIN TRANSLATIONS POWERED BY GOOGLE. GOOGLE DISCLAIMS ALL WARRANTIES RELATED TO THE TRANSLATIONS, EXPRESS OR IMPLIED, INCLUDING ANY WARRANTIES OF ACCURACY, RELIABILITY, AND ANY IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.\',',
  );

  buffer.writeln('this.\$translations = _\$translations,');

  // constructor fields
  for (var element in visitor.elements) {
    final annotation = element.metadata[0].computeConstantValue();

    if (annotation == null || annotation.type.toString() != 'Val') {
      throw Exception(
        'Every field has to be annotated with @Val(\'Field value\')',
      );
    }

    final value = annotation.getField('val')?.toStringValue();

    if (value!.isEmpty) {
      throw Exception(
        '${element.displayName} - Field value can not be empty',
      );
    }

    buffer.writeln(
      '  this.${element.displayName} = \'$value\',',
    );
  }

  // constructor end
  buffer.writeln('  });\n');

  // fields
  for (var field in [...translations, 'attribution']) {
    buffer.writeln('\n@override');

    if (field == 'sourceLanguage') {
      buffer.writeln('final String $field;');
    } else {
      buffer.writeln('final String \$$field;');
    }
  }

  buffer.writeln('\n@override');
  buffer.writeln('final Map<String, String>? \$translations;');

  for (var element in visitor.elements) {
    buffer.writeln('\n@override');
    buffer.writeln(
      'final String ${element.displayName};',
    );
  }

  // translateTo
  buffer.writeln('\n@override');
  buffer.writeln(
    'Future<${visitor.className}> translateTo(TranslationLanguage targetLanguage) async {',
  );
  buffer.writeln(
    ' const translate = TranslatorUtils.translate;\n',
  );

  buffer.writeln(
    ' if (targetLanguage.code == sourceLanguage) return this;\n',
  );

  buffer.writeln(
    ' return _${visitor.className}(',
  );

  for (var field in [...translations, 'attribution']) {
    if (field == 'sourceLanguage') {
      buffer.writeln('sourceLanguage: targetLanguage.code,');
    } else {
      buffer.writeln(
        '\$$field: await translate(\$$field),',
      );
    }
  }

  for (var element in visitor.elements) {
    buffer.writeln(
      '${element.displayName}: _\$translations[\'${element.displayName}_\${targetLanguage.code}\'] ?? await translate(${element.displayName}),',
    );
  }

  buffer.writeln(
    ');',
  );

  // translateTo end
  buffer.writeln('}');

  // toJson start
  buffer.writeln(
    '''
@override
Map<String, dynamic> toJson() => {
  ''',
  );

  for (var field in [...translations, 'attribution']) {
    if (field == 'sourceLanguage') {
      buffer.writeln('\'sourceLanguage\': sourceLanguage,');
    } else {
      buffer.writeln('\'\\\$$field\': \$$field,');
    }
  }

  buffer.writeln('\'\\\$translations\': \$translations,');

  for (var element in visitor.elements) {
    buffer.writeln(
      '\'${element.displayName}\': ${element.displayName},',
    );
  }

  // toJson end
  buffer.writeln('};\n');

  // fromJson start
  buffer.writeln(
    '''
@override
_${visitor.className} fromJson(Map<String, dynamic> json) => _${visitor.className}(
  ''',
  );

  for (var field in [...translations, 'attribution']) {
    if (field == 'sourceLanguage') {
      buffer.writeln('sourceLanguage: json[\'sourceLanguage\'] as String,');
    } else {
      buffer.writeln('\$$field: json[\'\\\$$field\'] as String,');
    }
  }

  buffer.writeln(
    '\$translations: (json[\'\\\$translations\'] as Map).cast<String, String>(),',
  );

  for (var element in visitor.elements) {
    buffer.writeln(
      '${element.displayName}: json[\'${element.displayName}\'] as String,',
    );
  }

  // fromJson end
  buffer.writeln(');\n');

  // == operator start
  buffer.writeln('''
@override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _${visitor.className}
''');

  for (var field in [...translations, 'attribution']) {
    if (field == 'sourceLanguage') {
      buffer.writeln(
        '&& (identical(other.sourceLanguage, sourceLanguage) || other.sourceLanguage == sourceLanguage)',
      );
    } else {
      buffer.writeln(
          '&& (identical(other.\$$field, \$$field) || other.\$$field == \$$field)');
    }
  }

  buffer.writeln(
    '&& (mapEquals(other.\$translations, \$translations) || other.\$translations == \$translations)',
  );

  for (var element in visitor.elements) {
    buffer.writeln(
      '&& (identical(other.${element.displayName}, ${element.displayName}) || other.${element.displayName} == ${element.displayName})',
    );
  }

  buffer.writeln(');');

  // == operator end
  buffer.writeln('}');

  // hashCode start
  buffer.writeln('''
@override
  int get hashCode => Object.hashAll([
''');

  for (var field in [...translations, 'attribution']) {
    if (field == 'sourceLanguage') {
      buffer.writeln('sourceLanguage,');
    } else {
      buffer.writeln('\$$field,');
    }
  }

  buffer.writeln(
    '\$translations,',
  );

  for (var element in visitor.elements) {
    buffer.writeln('${element.displayName},');
  }

  // hashCode end
  buffer.writeln(']);');

  // class end
  buffer.writeln('}');
}
