// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// TranslatorGenerator
// **************************************************************************

const _$translations = <String, String>{
  'title_pl': 'Mój customowy tytuł',
  'polish_pl': 'polski',
  'spanish_pl': 'hiszp',
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
    this.bodyText = 'This text was translated by Google Translator.',
    this.rockin = 'rock\'n',
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
  final String rockin;

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
      rockin: _$translations['rockin_${targetLanguage.code}'] ??
          await translate(rockin),
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
        'rockin': rockin,
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
        rockin: json['rockin'] as String,
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
            (mapEquals(other.$translations, $translations) ||
                other.$translations == $translations) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.bodyText, bodyText) ||
                other.bodyText == bodyText) &&
            (identical(other.rockin, rockin) || other.rockin == rockin) &&
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
        $translations,
        title,
        bodyText,
        rockin,
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
  String get rockin => throw Exception();
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
    this.detectDeviceLanguage = true,
  });

  final Widget Function(
    BuildContext context,
    TranslatorState state,
  ) builder;
  final bool cleanLanguageModels;
  final bool detectDeviceLanguage;

  /// This part should be initialized in `main()` function
  /// ```
  /// void main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///
  ///   await Translator.init();
  ///
  ///   runApp(const MyApp());
  /// }
  /// ```
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
  bool _showDialog = false;
  bool _imagesPrecached = false;

  Locale get locale => Locale((_translation as _MyTranslation).sourceLanguage);

  List<Locale> get supportedLocales =>
      TranslationLanguage.values.map((lang) => Locale(lang.code)).toList();

  List<LocalizationsDelegate<dynamic>> get localizationsDelegates => [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];

  bool get isTranslated {
    const source = MyTranslation() as _MyTranslation;
    final current = _translation as _MyTranslation;

    return source.sourceLanguage != current.sourceLanguage;
  }

  String get _$downloading => (_translation as _MyTranslation).$downloading;
  String get _$translating => (_translation as _MyTranslation).$translating;
  String get _$done => (_translation as _MyTranslation).$done;
  String get _$error => (_translation as _MyTranslation).$error;
  String get _$attribution => (_translation as _MyTranslation).$attribution;

  /// My awesome title
  ///
  /// **My best app**
  String get title => _translation.title;

  /// **This text was translated by Google Translator.**
  String get bodyText => _translation.bodyText;

  /// **rock'n**
  String get rockin => _translation.rockin;

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

  @override
  void initState() {
    final (translation, translationLanguage) =
        TranslatorUtils.initTranslation<_MyTranslation>(
      const MyTranslation() as _MyTranslation,
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
              downloading: _$downloading,
              translating: _$translating,
              done: _$done,
              error: _$error,
              attribution: _$attribution,
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

class TranslatedText extends StatefulWidget {
  const TranslatedText({
    super.key,
    required this.text,
    this.style,
    this.imageType = ImageType.color,
    this.shimmerBaseColor = Colors.black,
    this.shimmerHighlightColor = Colors.white,
    this.shimmerPeriod = const Duration(milliseconds: 1500),
  });

  final String text;
  final TextStyle? style;

  /// Attribution image type.
  final ImageType imageType;

  final Color shimmerBaseColor;
  final Color shimmerHighlightColor;

  /// Loading shimmer duration.
  final Duration shimmerPeriod;

  @override
  State<TranslatedText> createState() => _TranslatedTextState();
}

class _TranslatedTextState extends State<TranslatedText> {
  UiImage? _image;
  TranslatorState? _translator;
  String? _lastLangCode;
  String? _translatedText;
  bool _isTranslating = false;

  late DateTime _timestamp;

  String _getDirectoryName() {
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);

    var dirName = '';

    if (devicePixelRatio <= 1.0) {
      dirName = '';
    } else if (devicePixelRatio <= 2.0) {
      dirName = '2.0x/';
    } else {
      dirName = '3.0x/';
    }

    return dirName;
  }

  Future<UiImage> _loadUiImage(String asset) async {
    var data = await rootBundle.load(asset);
    var codec = await getCodec(data.buffer.asUint8List());
    var frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }

  Future<void> _load() async {
    const prefix = 'packages/ml_translator/images/';
    final suffix = '${widget.imageType.toString()}-short.png';
    final assetPath = '$prefix${_getDirectoryName()}$suffix';

    final image = await _loadUiImage(assetPath);

    setState(() {
      _image = image;
    });
  }

  void _translate() async {
    var isInitialized = TranslatorUtils.isInitialized;

    if (!isInitialized) {
      const source = (MyTranslation() as _MyTranslation);
      final sourceLanguage =
          TranslationLanguage.fromCode(source.sourceLanguage);

      final targetCode = _translator!.locale.languageCode;
      final targetLanguage = TranslationLanguage.fromCode(targetCode);

      if (sourceLanguage != null && targetLanguage != null) {
        isInitialized = await TranslatorUtils.initLanguageModels(
          sourceLanguage,
          targetLanguage,
        );
      }
    }

    if (isInitialized) {
      _translatedText = await TranslatorUtils.translate(widget.text);
    }

    if (mounted) {
      _lastLangCode = Translator.of(context).locale.languageCode;
    }

    setState(() {
      _isTranslating = false;
    });
  }

  @override
  void initState() {
    _timestamp = DateTime.now();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _translator ??= Translator.of(context);

    if (_translator!.isTranslated &&
        _lastLangCode != _translator!.locale.languageCode &&
        !_isTranslating) {
      _isTranslating = true;

      _translate();
    } else if (!_translator!.isTranslated) {
      _translatedText = null;
      _lastLangCode = null;
    }

    if (_image == null) {
      _load();
    }

    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant TranslatedText oldWidget) {
    if (oldWidget.imageType != widget.imageType) {
      _load();
    }
    if (oldWidget.text != widget.text || oldWidget.style != widget.style) {
      _timestamp = DateTime.now();

      final currentTimestamp = _timestamp;

      setState(() {
        _isTranslating = true;
      });

      // debounce
      Future.delayed(Durations.long4, () {
        if (_timestamp == currentTimestamp &&
            mounted &&
            Translator.of(context).isTranslated) {
          _translate();
        }
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    late Widget child;

    if (_image == null || _translatedText == null) {
      child = Text(widget.text, style: widget.style);
    } else {
      child = TranslatedTextWidget(
        text: _translatedText!,
        style: widget.style,
        image: _image!,
      );
    }

    if (_isTranslating) {
      return Shimmer.fromColors(
        baseColor: widget.shimmerBaseColor,
        highlightColor: widget.shimmerHighlightColor,
        period: widget.shimmerPeriod,
        enabled: _isTranslating,
        child: child,
      );
    }

    return child;
  }
}
