import 'package:ml_translator/ml_translator.dart';

class TranslatedText extends StatefulWidget {
  // TODO W translatorze dodac getter, który zwraca bool isTranslated. Dodac ten widgtet do translatora.
  // Jeśli nie tłumaczony to pokazac zwykły tekst. Inaczej przetłumaczyć i pokazać shimmer w czasie tłuaczenia.
  const TranslatedText({
    super.key,
    required this.text,
    this.style,
    this.imageType = ImageType.color,
  });

  final String text;
  final TextStyle? style;
  final ImageType imageType;

  @override
  State<TranslatedText> createState() => _TranslatedTextState();
}

class _TranslatedTextState extends State<TranslatedText> {
  UiImage? _image;

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

  @override
  void didChangeDependencies() {
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
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (_image == null) {
      return Text(widget.text, style: widget.style);
    }
    return TranslatedTextWidget(
      text: widget.text,
      style: widget.style,
      image: _image!,
    );
  }
}
