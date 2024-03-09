import 'package:flutter/material.dart';
import 'package:ml_translator/ml_translator.dart';
import 'package:ml_translator/ml_translator_widgets.dart';

part 'example.translator.dart';

@MlTranslator(baseLanguage: 'da')
class Example with _$Example {
  const factory Example({
    @Val('My best app') String title,
    @Val('This is some text') String bodyText,
  }) = _Example;
}

class _Example implements Example, MlTranslation {
  const _Example({
    // ignore: unused_element
    this.sourceLanguage = 'en',
    // ignore: unused_element
    this.$downloading = 'Downloading language model',
    // ignore: unused_element
    this.$translating = 'Translating',
    // ignore: unused_element
    this.$done = 'Done',
    // ignore: unused_element
    this.$error = 'Error',
    // ignore: unused_element
    this.$attribution =
        'THIS SERVICE MAY CONTAIN TRANSLATIONS POWERED BY GOOGLE. GOOGLE DISCLAIMS ALL WARRANTIES RELATED TO THE TRANSLATIONS, EXPRESS OR IMPLIED, INCLUDING ANY WARRANTIES OF ACCURACY, RELIABILITY, AND ANY IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.',
    this.title = 'My best app',
    this.bodyText = 'This is some text',
  });

  @override
  final String sourceLanguage;

  @override
  final String $downloading;

  @override
  final String $translating;

  @override
  final String $done;

  @override
  final String $error;

  @override
  final String $attribution;

  @override
  final String title;

  @override
  final String bodyText;

  @override
  Future<Example> translateTo(TranslationLanguage targetLanguage) async {
    const translate = TranslatorUtils.translate;

    if (targetLanguage == sourceLanguage) {
      return this;
    }

    return _Example(
      sourceLanguage: targetLanguage,
      $downloading: await translate($downloading),
      $translating: await translate($translating),
      $done: await translate($done),
      $error: await translate($error),
      $attribution: await translate($attribution),
      title: await translate(title),
      bodyText: await translate(bodyText),
    );
  }
}

mixin _$Example {
  String get title => throw Exception();
  String get bodyText => throw Exception();
}

// Translator Widget

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
}

class TranslatorState<T extends MlTranslation> extends State<Translator> {
  late Example _translation;
  bool _isDownloading = false;
  bool _isTranslating = false;
  bool _showError = false;
  bool _showInfo = false;

  Locale get locale => Locale((_translation as _Example).sourceLanguage.code);

  String get $downloading => (_translation as _Example).$downloading;
  String get $translating => (_translation as _Example).$translating;
  String get $done => (_translation as _Example).$done;
  String get $error => (_translation as _Example).$error;
  String get $attribution => (_translation as _Example).$attribution;

  String get title => _translation.title;

  String get bodyText => _translation.bodyText;

  Future<void> translateTo(TranslationLanguage targetLanguage) async {
    setState(() {
      _isDownloading = true;
      _isTranslating = true;
      _showError = false;
      _showInfo = true;
    });

    final example = (_translation as _Example);

    final sourceLanguage = example.sourceLanguage;

    final isInitialized =
        await TranslatorUtils.initTranslator(sourceLanguage, targetLanguage);

    setState(() {
      _isDownloading = false;

      if (!isInitialized) {
        _isTranslating = false;
        _showError = true;
      }
    });

    if (isInitialized) {
      final result = await example.translateTo(targetLanguage);

      setState(() {
        _translation = result;
        _isTranslating = false;
      });
    }

    if (widget.cleanLanguageModels) {
      TranslatorUtils.deleteLanguage(targetLanguage);
    }
  }

  void _confirmTranslation() {
    setState(() {
      _isDownloading = false;
      _isTranslating = false;
      _showError = false;
      _showInfo = false;
    });
  }

  @override
  void initState() {
    _translation = const Example();

    Future.delayed(
      const Duration(seconds: 2),
      () async {
        await translateTo(
          TranslationLanguage.chinese,
        );
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose - usunąć modele językowe
    super.dispose();
  }

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
              downloading: $downloading,
              translating: $translating,
              done: $done,
              error: $error,
              attribution: $attribution,
              confirm: _confirmTranslation,
            )
        ],
      ),
    );
  }
}

class _InheritedTranslator extends InheritedWidget {
  final TranslatorState state;

  const _InheritedTranslator({
    required this.state,
    required super.child,
  });

  @override
  bool updateShouldNotify(_InheritedTranslator oldWidget) => oldWidget != this;
}
