// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// TranslatorGenerator
// **************************************************************************

class _Example implements Example, MlTranslation {
  const _Example({
    this.sourceLanguage = 'en',
    this.$downloading = 'Downloading language model',
    this.$translating = 'Translating',
    this.$done = 'Done',
    this.$error = 'Error',
    this.$attribution =
        'THIS SERVICE MAY CONTAIN TRANSLATIONS POWERED BY GOOGLE. GOOGLE DISCLAIMS ALL WARRANTIES RELATED TO THE TRANSLATIONS, EXPRESS OR IMPLIED, INCLUDING ANY WARRANTIES OF ACCURACY, RELIABILITY, AND ANY IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.',
    this.title = 'My best app',
    this.bodyText = 'This is some text',
    this.secondText = 'This is second line of text',
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
  final String secondText;

  @override
  Future<Example> translateTo(TranslationLanguage targetLanguage) async {
    const translate = TranslatorUtils.translate;

    if (targetLanguage.code == sourceLanguage) return this;

    return _Example(
      sourceLanguage: targetLanguage.code,
      $downloading: await translate($downloading),
      $translating: await translate($translating),
      $done: await translate($done),
      $error: await translate($error),
      $attribution: await translate($attribution),
      title: await translate(title),
      bodyText: await translate(bodyText),
      secondText: await translate(secondText),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'sourceLanguage': sourceLanguage,
        'downloading': $downloading,
        'translating': $translating,
        'done': $done,
        'error': $error,
        'attribution': $attribution,
        'title': title,
        'bodyText': bodyText,
        'secondText': secondText,
      };

  @override
  _Example fromJson(Map<String, dynamic> json) => _Example(
        sourceLanguage: json['sourceLanguage'] as String,
        $downloading: json['\$downloading'] as String,
        $translating: json['\$translating'] as String,
        $done: json['\$done'] as String,
        $error: json['\$error'] as String,
        $attribution: json['\$attribution'] as String,
        title: json['title'] as String,
        bodyText: json['bodyText'] as String,
        secondText: json['secondText'] as String,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Example &&
            (identical(other.sourceLanguage, sourceLanguage) ||
                other.sourceLanguage == sourceLanguage) &&
            (identical(other.$downloading, $downloading) ||
                other.$downloading == $downloading) &&
            (identical(other.$translating, $translating) ||
                other.$translating == $translating) &&
            (identical(other.$done, $done) || other.$done == $done) &&
            (identical(other.$error, $error) || other.$error == $error) &&
            (identical(other.$attribution, $attribution) ||
                other.$attribution == $attribution) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.bodyText, bodyText) ||
                other.bodyText == bodyText) &&
            (identical(other.secondText, secondText) ||
                other.secondText == secondText));
  }

  @override
  int get hashCode => Object.hashAll([
        sourceLanguage,
        $downloading,
        $translating,
        $done,
        $error,
        $attribution,
        title,
        bodyText,
        secondText,
      ]);
}

mixin _$Example {
  String get title => throw Exception();
  String get bodyText => throw Exception();
  String get secondText => throw Exception();
}

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

class TranslatorState extends State<Translator> {
  late Example _translation;
  bool _isDownloading = false;
  bool _isTranslating = false;
  bool _showError = false;
  bool _showInfo = false;

  Locale get locale => Locale((_translation as _Example).sourceLanguage);

  String get $downloading => (_translation as _Example).$downloading;
  String get $translating => (_translation as _Example).$translating;
  String get $done => (_translation as _Example).$done;
  String get $error => (_translation as _Example).$error;
  String get $attribution => (_translation as _Example).$attribution;

  /// My awesome title
  ///
  /// **My best app**
  String get title => _translation.title;

  /// **This is some text**
  String get bodyText => _translation.bodyText;

  /// **This is second line of text**
  String get secondText => _translation.secondText;

  Future<void> translateTo(TranslationLanguage targetLanguage) async {
    setState(() {
      _isDownloading = true;
      _isTranslating = true;
      _showError = false;
      _showInfo = true;
    });

    const source = (Example() as _Example);

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
          TranslationLanguage.polish,
        );
      },
    );

    super.initState();
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
