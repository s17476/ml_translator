import 'package:ml_translator_generator/src/model_visitor.dart';

void createTranslatedText(StringBuffer buffer, ModelVisitor visitor) {
  buffer.write(
    '''
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
    final suffix = '\${widget.imageType.toString()}-short.png';
    final assetPath = '\$prefix\${_getDirectoryName()}\$suffix';

    final image = await _loadUiImage(assetPath);

    setState(() {
      _image = image;
    });
  }

  void _translate() async {
    var isInitialized = TranslatorUtils.isInitialized;

    if (!isInitialized) {
      const source = (${visitor.className}() as _${visitor.className});
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

''',
  );
}
