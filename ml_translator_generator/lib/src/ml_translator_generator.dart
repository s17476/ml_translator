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
    // class
    buffer.writeln(
      'class _${visitor.className} implements Example, MlTranslation {',
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

    // pola konstruktora

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
        buffer.writeln('\$$field: await translate(\$$field),');
      }
    }

    for (var element in visitor.elements) {
      buffer.writeln(
        '${element.displayName}: await translate(${element.displayName}),',
      );
    }

    buffer.writeln(
      ');',
    );

    // translateTo end
    buffer.writeln('}');

    // class end
    buffer.writeln('}');
  }

  _createTranslatorWidget(StringBuffer buffer) {
    buffer.write('''
class Translator extends StatefulWidget {
  const Translator({
    super.key,
    required this.builder,
    this.cleanLanguageModels = true,
  });

  final Builder builder;
  final bool cleanLanguageModels;

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
class TranslatorState<T extends MlTranslation> extends State<Translator> {
  late ${visitor.className} _translation;
  bool _isDownloading = false;
  bool _isTranslating = false;
  bool _showError = false;
  bool _showInfo = false;

  Locale get locale => Locale((_translation as _${visitor.className}).sourceLanguage);
  
  ''');

    for (var field in [...translations, 'attribution']) {
      if (field != 'sourceLanguage') {
        buffer.writeln(
          'String get \$$field => (_translation as _Example).\$$field;',
        );
      }
    }

    buffer.writeln();

    // getters
    for (var element in visitor.elements) {
      final annotation = element.metadata[0].computeConstantValue();

      final description = annotation?.getField('description')?.toStringValue();

      if (description != null && description.isNotEmpty) {
        buffer.writeln('  /// $description');
      }

      buffer.writeln(
        'String get ${element.displayName} => _translation.${element.displayName};\n',
      );
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

    final isInitialized = await TranslatorUtils.initTranslator(
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
    _translation = const ${visitor.className}();

    Future.delayed(
      const Duration(seconds: 2),
      () async {
        await translateTo(
          TranslationLanguage.polish,
        );
      },
    );

    super.initState();
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
            child: widget.builder,
          ),
          if (_showInfo)
            TranslatorLoadingWidget(
              isDownloading: _isDownloading,
              isTranslating: _isTranslating,
              showError: _showError,
              downloading: \$downloading,
              translating: \$translating,
              done: \$done,
              error: \$error,
              attribution: \$attribution,
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
