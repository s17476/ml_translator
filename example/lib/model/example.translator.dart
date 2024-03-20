// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// TranslatorGenerator
// **************************************************************************

const _$translations = <String, String>{
  'title_pl': 'Mój customowy własny opis',
  'polish_pl': 'polski',
  'spanish_pl': 'hiszp.',
};

class _MyTranslation implements MyTranslation, MlTranslation {
  const _MyTranslation({
    this.sourceLanguage = 'en',
    this.$downloading = 'Downloading language model',
    this.$translating = 'Translating',
    this.$done = 'Done',
    this.$error = 'Error',
    this.$attribution =
        'THIS SERVICE MAY CONTAIN TRANSLATIONS POWERED BY GOOGLE. GOOGLE DISCLAIMS ALL WARRANTIES RELATED TO THE TRANSLATIONS, EXPRESS OR IMPLIED, INCLUDING ANY WARRANTIES OF ACCURACY, RELIABILITY, AND ANY IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.',
    this.$translations = _$translations,
    this.title = 'My best app',
    this.bodyText = 'This text was translated by Google Translator',
    this.chinese = 'chinese',
    this.danish = 'danish',
    this.english = 'english',
    this.french = 'french',
    this.german = 'german',
    this.greek = 'greek',
    this.italian = 'italian',
    this.japanese = 'japanese',
    this.kannada = 'kannada',
    this.korean = 'korean',
    this.polish = 'polish',
    this.spanish = 'spanish',
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
  final Map<String, String>? $translations;

  @override
  final String title;

  @override
  final String bodyText;

  @override
  final String chinese;

  @override
  final String danish;

  @override
  final String english;

  @override
  final String french;

  @override
  final String german;

  @override
  final String greek;

  @override
  final String italian;

  @override
  final String japanese;

  @override
  final String kannada;

  @override
  final String korean;

  @override
  final String polish;

  @override
  final String spanish;

  @override
  Future<MyTranslation> translateTo(TranslationLanguage targetLanguage) async {
    const translate = TranslatorUtils.translate;

    if (targetLanguage.code == sourceLanguage) return this;

    return _MyTranslation(
      sourceLanguage: targetLanguage.code,
      $downloading: await translate($downloading),
      $translating: await translate($translating),
      $done: await translate($done),
      $error: await translate($error),
      $attribution: await translate($attribution),
      title: _$translations['title_${targetLanguage.code}'] ??
          await translate(title),
      bodyText: _$translations['bodyText_${targetLanguage.code}'] ??
          await translate(bodyText),
      chinese: _$translations['chinese_${targetLanguage.code}'] ??
          await translate(chinese),
      danish: _$translations['danish_${targetLanguage.code}'] ??
          await translate(danish),
      english: _$translations['english_${targetLanguage.code}'] ??
          await translate(english),
      french: _$translations['french_${targetLanguage.code}'] ??
          await translate(french),
      german: _$translations['german_${targetLanguage.code}'] ??
          await translate(german),
      greek: _$translations['greek_${targetLanguage.code}'] ??
          await translate(greek),
      italian: _$translations['italian_${targetLanguage.code}'] ??
          await translate(italian),
      japanese: _$translations['japanese_${targetLanguage.code}'] ??
          await translate(japanese),
      kannada: _$translations['kannada_${targetLanguage.code}'] ??
          await translate(kannada),
      korean: _$translations['korean_${targetLanguage.code}'] ??
          await translate(korean),
      polish: _$translations['polish_${targetLanguage.code}'] ??
          await translate(polish),
      spanish: _$translations['spanish_${targetLanguage.code}'] ??
          await translate(spanish),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'sourceLanguage': sourceLanguage,
        '\$downloading': $downloading,
        '\$translating': $translating,
        '\$done': $done,
        '\$error': $error,
        '\$attribution': $attribution,
        '\$translations': $translations,
        'title': title,
        'bodyText': bodyText,
        'chinese': chinese,
        'danish': danish,
        'english': english,
        'french': french,
        'german': german,
        'greek': greek,
        'italian': italian,
        'japanese': japanese,
        'kannada': kannada,
        'korean': korean,
        'polish': polish,
        'spanish': spanish,
      };

  @override
  _MyTranslation fromJson(Map<String, dynamic> json) => _MyTranslation(
        sourceLanguage: json['sourceLanguage'] as String,
        $downloading: json['\$downloading'] as String,
        $translating: json['\$translating'] as String,
        $done: json['\$done'] as String,
        $error: json['\$error'] as String,
        $attribution: json['\$attribution'] as String,
        $translations: (json['\$translations'] as Map).cast<String, String>(),
        title: json['title'] as String,
        bodyText: json['bodyText'] as String,
        chinese: json['chinese'] as String,
        danish: json['danish'] as String,
        english: json['english'] as String,
        french: json['french'] as String,
        german: json['german'] as String,
        greek: json['greek'] as String,
        italian: json['italian'] as String,
        japanese: json['japanese'] as String,
        kannada: json['kannada'] as String,
        korean: json['korean'] as String,
        polish: json['polish'] as String,
        spanish: json['spanish'] as String,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MyTranslation &&
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
            (identical(other.chinese, chinese) || other.chinese == chinese) &&
            (identical(other.danish, danish) || other.danish == danish) &&
            (identical(other.english, english) || other.english == english) &&
            (identical(other.french, french) || other.french == french) &&
            (identical(other.german, german) || other.german == german) &&
            (identical(other.greek, greek) || other.greek == greek) &&
            (identical(other.italian, italian) || other.italian == italian) &&
            (identical(other.japanese, japanese) ||
                other.japanese == japanese) &&
            (identical(other.kannada, kannada) || other.kannada == kannada) &&
            (identical(other.korean, korean) || other.korean == korean) &&
            (identical(other.polish, polish) || other.polish == polish) &&
            (identical(other.spanish, spanish) || other.spanish == spanish));
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
        chinese,
        danish,
        english,
        french,
        german,
        greek,
        italian,
        japanese,
        kannada,
        korean,
        polish,
        spanish,
      ]);
}

mixin _$MyTranslation {
  String get title => throw Exception();
  String get bodyText => throw Exception();
  String get chinese => throw Exception();
  String get danish => throw Exception();
  String get english => throw Exception();
  String get french => throw Exception();
  String get german => throw Exception();
  String get greek => throw Exception();
  String get italian => throw Exception();
  String get japanese => throw Exception();
  String get kannada => throw Exception();
  String get korean => throw Exception();
  String get polish => throw Exception();
  String get spanish => throw Exception();
}

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
}

class TranslatorState extends State<Translator> {
  late MyTranslation _translation;
  bool _isDownloading = false;
  bool _isTranslating = false;
  bool _showError = false;
  bool _showInfo = false;

  Locale get locale => Locale((_translation as _MyTranslation).sourceLanguage);

  List<Locale> get supportedLocales =>
      TranslationLanguage.values.map((lang) => Locale(lang.code)).toList();

  List<LocalizationsDelegate<dynamic>> get localizationsDelegates => [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];

  String get _$downloading => (_translation as _MyTranslation).$downloading;
  String get _$translating => (_translation as _MyTranslation).$translating;
  String get _$done => (_translation as _MyTranslation).$done;
  String get _$error => (_translation as _MyTranslation).$error;
  String get _$attribution => (_translation as _MyTranslation).$attribution;

  /// My awesome title
  ///
  /// **My best app**
  String get title => _translation.title;

  /// **This text was translated by Google Translator**
  String get bodyText => _translation.bodyText;

  /// **chinese**
  String get chinese => _translation.chinese;

  /// **danish**
  String get danish => _translation.danish;

  /// **english**
  String get english => _translation.english;

  /// **french**
  String get french => _translation.french;

  /// **german**
  String get german => _translation.german;

  /// **greek**
  String get greek => _translation.greek;

  /// **italian**
  String get italian => _translation.italian;

  /// **japanese**
  String get japanese => _translation.japanese;

  /// **kannada**
  String get kannada => _translation.kannada;

  /// **korean**
  String get korean => _translation.korean;

  /// **polish**
  String get polish => _translation.polish;

  /// **spanish**
  String get spanish => _translation.spanish;

  Future<void> translateTo(TranslationLanguage targetLanguage) async {
    setState(() {
      _isDownloading = true;
      _isTranslating = true;
      _showError = false;
      _showInfo = true;
    });

    const source = (MyTranslation() as _MyTranslation);

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

      TranslatorUtils.saveTranslation<_MyTranslation>(result as _MyTranslation);

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
    final (translation, translationLanguage) =
        TranslatorUtils.initTranslation<_MyTranslation>(
      const MyTranslation() as _MyTranslation,
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
              downloading: _$downloading,
              translating: _$translating,
              done: _$done,
              error: _$error,
              attribution: _$attribution,
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
