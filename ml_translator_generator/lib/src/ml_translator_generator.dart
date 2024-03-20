import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:ml_translator/ml_translator_gen.dart';
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

    // Loading widget translations
    final translations = [
      'sourceLanguage',
      'downloading',
      'translating',
      'done',
      'error'
    ];

    _createClassPattern(buffer, visitor, annotation, translations);

    _createMixin(buffer, visitor);

    _createTranslatorWidget(buffer);

    _createTranslatorState(buffer, visitor, annotation, translations);

    print(buffer.toString());

    return buffer.toString();
  }

  void _createMixin(StringBuffer buffer, ModelVisitor visitor) {
    buffer.writeln('\nmixin _\$${visitor.className} {');

    for (var element in visitor.elements) {
      buffer.writeln(
        'String get ${element.displayName} => throw Exception();',
      );
    }

    buffer.writeln('}');
  }

  void _createClassPattern(
    StringBuffer buffer,
    ModelVisitor visitor,
    ConstantReader annotation,
    List<String> translations,
  ) {
    // translations map start
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

//TODO - fix or it can't be used
    // buffer.writeln(
    //   '&& (identical(other.\$translations, \$translations) || other.\$translations == \$translations)',
    // );

    for (var element in visitor.elements) {
      buffer.writeln(
        '&& (identical(other.${element.displayName}, ${element.displayName}) || other.${element.displayName} == ${element.displayName})',
      );
    }

    // == operator end
    buffer.writeln(');');
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

    // buffer.writeln(
    //   '\$translations,',
    // );

    for (var element in visitor.elements) {
      buffer.writeln('${element.displayName},');
    }

    // hashCode end
    buffer.writeln(']);');

    // class end
    buffer.writeln('}');
  }

  _createTranslatorWidget(StringBuffer buffer) {
    buffer.write('''
class Translator extends StatefulWidget {
  const Translator({
    super.key,
    required this.builder,
    this.cleanLanguageModels = false,
  });

  final Widget Function(BuildContext context) builder;
  final bool cleanLanguageModels;

  static Future<void> init() => TranslatorUtils.initDb();

  static TranslatorState of(BuildContext context) {
    try {
      return context
          .dependOnInheritedWidgetOfExactType<_InheritedTranslator>()!
          .state;
    } catch (_) {
      throw Exception('Please provide Translator context');
    }
  }

  @override
  State<Translator> createState() => TranslatorState();
}''');
  }

  _createTranslatorState(
    StringBuffer buffer,
    ModelVisitor visitor,
    ConstantReader annotation,
    List<String> translations,
  ) {
    buffer.write('''
class TranslatorState extends State<Translator> {
  late ${visitor.className} _translation;
  bool _isDownloading = false;
  bool _isTranslating = false;
  bool _showError = false;
  bool _showInfo = false;

  Locale get locale => Locale((_translation as _${visitor.className}).sourceLanguage);

  List<Locale> get supportedLocales =>
      TranslationLanguage.values.map((lang) => Locale(lang.code)).toList();

  List<LocalizationsDelegate<dynamic>> get localizationsDelegates => [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];
  
  ''');

    for (var field in [...translations, 'attribution']) {
      if (field != 'sourceLanguage') {
        buffer.writeln(
          'String get _\$$field => (_translation as _${visitor.className}).\$$field;',
        );
      }
    }

    buffer.writeln();

    // getters
    for (var element in visitor.elements) {
      final annotation = element.metadata[0].computeConstantValue();

      final val = annotation?.getField('val')?.toStringValue();
      final description = annotation?.getField('description')?.toStringValue();

      final variablesCount = val!.split('%s').length - 1;

      if (variablesCount > 0) {
        buffer.writeln(
          'String get _${element.displayName} => _translation.${element.displayName};\n',
        );

        if (description != null && description.isNotEmpty) {
          buffer.writeln('  /// $description\n///');
        }
        buffer.writeln('  /// **$val**');

        String vars = '';
        String replacements = '';
        for (var i = 0; i < variablesCount; i++) {
          vars += 'String s$i, ';
          replacements += '.replaceFirst(\'%s\', s$i)';
        }

        buffer.writeln(
          'String ${element.displayName}($vars) => _${element.displayName}$replacements;\n',
        );
      } else {
        if (description != null && description.isNotEmpty) {
          buffer.writeln('  /// $description\n///');
        }
        buffer.writeln('  /// **$val**');

        buffer.writeln(
          'String get ${element.displayName} => _translation.${element.displayName};\n',
        );
      }
    }

    buffer.write('''
Future<void> translateTo(TranslationLanguage targetLanguage) async {
    setState(() {
      _isDownloading = true;
      _isTranslating = true;
      _showError = false;
      _showInfo = true;
    });

    const source = (${visitor.className}() as _${visitor.className});

    final sourceLanguage = source.sourceLanguage;

    final isInitialized = await TranslatorUtils.initLanguageModels(
      TranslationLanguage.values.firstWhere(
        (element) => element.code == sourceLanguage,
      ),
      targetLanguage,
    );

    setState(() {
      _isDownloading = false;

      if (!isInitialized) {
        _isTranslating = false;
        _showError = true;
      }
    });

    if (isInitialized) {
      final result = await source.translateTo(targetLanguage);

      TranslatorUtils.saveTranslation<_${visitor.className}>(result as _${visitor.className});

      setState(() {
        _translation = result;
        _isTranslating = false;
      });
    }

    if (widget.cleanLanguageModels) {
      TranslatorUtils.deleteLanguage(targetLanguage);
    }
  }
''');

    buffer.write('''
void _confirmTranslation() {
    setState(() {
      _isDownloading = false;
      _isTranslating = false;
      _showError = false;
      _showInfo = false;
    });
  }
''');

    buffer.write('''
@override
  void initState() {
    final (translation, translationLanguage) = TranslatorUtils.initTranslation<_${visitor.className}>(
      const ${visitor.className}() as _${visitor.className},
    );

    _translation = translation;

    if (translationLanguage != null) {
      translateTo(translationLanguage);
    }

    super.initState();
  }

  @override
  void dispose() {
    TranslatorUtils.closeDb();
    super.dispose();
  }
''');

    buffer.write('''
@override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          TextDirection.ltr, // ustawic text direction na podstawie języka
      child: Stack(
        children: [
          _InheritedTranslator(
            state: this,
            child: Builder(
              builder: (context) => widget.builder(context),
            ),
          ),
          if (_showInfo)
            TranslatorLoadingWidget(
              isDownloading: _isDownloading,
              isTranslating: _isTranslating,
              showError: _showError,
              downloading: _\$downloading,
              translating: _\$translating,
              done: _\$done,
              error: _\$error,
              attribution: _\$attribution,
              confirm: _confirmTranslation,
            )
        ],
      ),
    );
  }
''');

    buffer.writeln('}');

    buffer.write('''
class _InheritedTranslator extends InheritedWidget {
  final TranslatorState state;

  const _InheritedTranslator({
    required this.state,
    required super.child,
  });

  @override
  bool updateShouldNotify(_InheritedTranslator oldWidget) => oldWidget != this;
}
''');
  }
}
