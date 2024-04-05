import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/semantics.dart';
import 'package:ml_translator/ml_translator.dart';

class TranslatedTextWidget extends LeafRenderObjectWidget {
  const TranslatedTextWidget({
    super.key,
    required this.text,
    required this.image,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final ui.Image image;

  @override
  RenderObject createRenderObject(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle? effectiveTextStyle = style;

    if (style == null || style!.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(style);
    }

    return TranslatedTextRenderObject(
      text: text,
      style: effectiveTextStyle!,
      textDirection: Directionality.of(context),
      uiImage: image,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    TranslatedTextRenderObject renderObject,
  ) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle? effectiveTextStyle = style;
    if (style == null || style!.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(style);
    }

    renderObject.text = text;
    renderObject.style = effectiveTextStyle!;
    renderObject.textDirection = Directionality.of(context);
    renderObject.image = image;
  }
}

class TranslatedTextRenderObject extends RenderBox {
  TranslatedTextRenderObject({
    required String text,
    required TextStyle style,
    required TextDirection textDirection,
    required ui.Image uiImage,
  }) {
    _style = style;
    _text = text;
    _textDirection = textDirection;

    _textPainter = TextPainter(
      text: textTextSpan,
      textDirection: _textDirection,
    );

    _image = uiImage;
  }

  late String _text;
  late TextStyle? _style;
  late TextDirection? _textDirection;

  late TextPainter _textPainter;

  late ui.Image _image;

  String get text => _text;
  set text(String val) {
    if (val == _text) {
      return;
    }

    _text = val;
    _textPainter.text = textTextSpan;
    markNeedsLayout();
    markNeedsSemanticsUpdate();
  }

  TextStyle? get style => _style;
  set style(TextStyle? val) {
    if (val == _style) {
      return;
    }

    _style = val;
    _textPainter.text = textTextSpan;
    markNeedsLayout();
  }

  ui.Image get image => _image;
  set image(ui.Image val) {
    if (val == _image) {
      return;
    }

    _image = val;
    markNeedsLayout();
  }

  TextDirection get textDirection => _textDirection ?? TextDirection.ltr;
  set textDirection(TextDirection val) {
    if (val == _textDirection) {
      return;
    }

    _textDirection = val;
    _textPainter.textDirection = _textDirection;
  }

  TextSpan get textTextSpan => TextSpan(text: _text, style: _style);

  late bool _googleFitsOnLastLine;
  late double _lineHeight;
  late double _lastLineWidth;
  late double _longestLineWidth;
  late double _googleWidth;
  late int _numTranslatedLines;

  double get _scaleFactor {
    final pixelRatio = PlatformDispatcher.instance.views.first.devicePixelRatio;

    if (pixelRatio <= 1.0) {
      return 1;
    } else if (pixelRatio <= 2.0) {
      return 1 / 2;
    } else {
      return 1 / 3;
    }
  }

  @override
  void performLayout() {
    final unconstrainedSize = _layout(constraints.maxWidth);

    size = constraints.constrain(unconstrainedSize);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (_textPainter.text?.toPlainText() == '') {
      return;
    }

    _textPainter.paint(context.canvas, offset);

    late Offset googleOffset;

    if (_googleFitsOnLastLine) {
      googleOffset = Offset(
        (offset.dx + (size.width - _googleWidth)) / _scaleFactor,
        (offset.dy + (_lineHeight * (_numTranslatedLines - 1))) / _scaleFactor,
      );
    } else {
      googleOffset = Offset(
        (offset.dx + (size.width - _googleWidth)) / _scaleFactor,
        (offset.dy + (_lineHeight * _numTranslatedLines)) / _scaleFactor,
      );
    }

    context.canvas.save();

    context.canvas.scale(_scaleFactor, _scaleFactor);

    context.canvas.drawImage(image, googleOffset, Paint());

    context.canvas.restore();
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);

    config.isSemanticBoundary = true;
    config.label = _text;
    config.textDirection = _textDirection;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    _layout(double.infinity);
    return _longestLineWidth;
  }

  @override
  double computeMinIntrinsicHeight(double width) =>
      computeMaxIntrinsicHeight(width);

  @override
  double computeMaxIntrinsicHeight(double width) {
    final computedSize = _layout(width);
    return computedSize.height;
  }

  @override
  bool hitTestSelf(Offset position) => true;

  Size _layout(double maxWidth) {
    _textPainter.layout(maxWidth: maxWidth);

    final textLines = _textPainter.computeLineMetrics();

    if (textLines.isEmpty) return const Size(0, 0);

    _longestLineWidth = 0;
    for (final line in textLines) {
      _longestLineWidth = max(_longestLineWidth, line.width);
    }
    _lastLineWidth = textLines.last.width;
    _lineHeight = textLines.last.height;
    _numTranslatedLines = textLines.length;

    final sizeOfText = Size(_longestLineWidth, _textPainter.height);

    _googleWidth = image.width.toDouble() * _scaleFactor;

    final lastLineWithGoogleWidth = _lastLineWidth + (_googleWidth * 1.1);
    if (textLines.length == 1) {
      _googleFitsOnLastLine = lastLineWithGoogleWidth < maxWidth;
    } else {
      _googleFitsOnLastLine =
          lastLineWithGoogleWidth < min(_longestLineWidth, maxWidth);
    }

    late Size computedSize;
    if (!_googleFitsOnLastLine) {
      computedSize = Size(
        sizeOfText.width,
        sizeOfText.height + (image.height * _scaleFactor),
      );
    } else {
      if (textLines.length == 1) {
        computedSize = Size(lastLineWithGoogleWidth, sizeOfText.height);
      } else {
        computedSize = Size(_longestLineWidth, sizeOfText.height);
      }
    }

    return computedSize;
  }
}
