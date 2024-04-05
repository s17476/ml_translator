import 'package:source_gen/source_gen.dart';

import 'package:ml_translator_generator/src/model_visitor.dart';

createTranslatorState(
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
  bool _showDialog = false;
  bool _imagesPrecached = false;

  Locale get locale => Locale((_translation as _${visitor.className}).sourceLanguage);

  List<Locale> get supportedLocales =>
      TranslationLanguage.values.map((lang) => Locale(lang.code)).toList();

  List<LocalizationsDelegate<dynamic>> get localizationsDelegates => [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];

  bool get isTranslated {
    const source = ${visitor.className}() as _${visitor.className};
    final current = _translation as _${visitor.className};

    return source.sourceLanguage != current.sourceLanguage;
  }
  
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
  void _confirmDialog(TranslationLanguage language) {
    setState(() {
      _showDialog = false;
    });

    translateTo(language);
  }

  void _cancelDialog() {
    setState(() {
      _showDialog = false;
    });
  }
''');

  buffer.write('''
  @override
  void didChangeDependencies() {
    if (!_imagesPrecached) {
      Future(() async {
        await precacheImage(
          const AssetImage('packages/ml_translator/images/white-google.png'),
          context,
        );

        setState(() {
          _imagesPrecached = true;
        });
      });
    }
    super.didChangeDependencies();
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
    } else if (widget.detectDeviceLanguage) {
      final languageAndLocale = Platform.localeName.split('_');

      if (languageAndLocale.isNotEmpty) {
        final deviceLanguageCode = languageAndLocale[0];

        final targetLanguage = TranslationLanguage.fromCode(deviceLanguageCode);

        if (targetLanguage != null) {
          final isCurrent = TranslatorUtils.isCurrentLanguage(targetLanguage);

          if (!isCurrent) {
            if (TranslatorUtils.showTranslationDialog) {
              TranslatorUtils.setDialogShown();

              _showDialog = true;
            }
          }
        }
      }
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
              builder: (context) => widget.builder(context, this),
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
            ),
          if (_showDialog)
            TranslatorDialog(
              confirm: _confirmDialog,
              cancel: _cancelDialog,
            ),
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
