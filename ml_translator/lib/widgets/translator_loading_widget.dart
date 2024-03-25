import 'dart:math';

import 'package:flutter/material.dart';

class TranslatorLoadingWidget extends StatefulWidget {
  const TranslatorLoadingWidget({
    super.key,
    required this.isDownloading,
    required this.isTranslating,
    required this.showError,
    required this.downloading,
    required this.translating,
    required this.done,
    required this.error,
    required this.attribution,
    required this.confirm,
  });

  final bool isDownloading;
  final bool isTranslating;
  final bool showError;

  final String downloading;
  final String translating;
  final String done;
  final String error;
  final String attribution;

  final VoidCallback confirm;

  @override
  State<TranslatorLoadingWidget> createState() =>
      _TranslatorLoadingWidgetState();
}

class _TranslatorLoadingWidgetState extends State<TranslatorLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotateY;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    _rotateY = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant TranslatorLoadingWidget oldWidget) {
    if (widget.showError || !widget.isTranslating) {
      _animationController.animateTo(0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.grey.shade300,
      fontSize: 24,
    );

    final label = widget.showError
        ? widget.error
        : widget.isDownloading
            ? widget.downloading
            : widget.isTranslating
                ? widget.translating
                : widget.done;

    final iconData = widget.showError
        ? Icons.error_outline
        : widget.isDownloading
            ? Icons.download
            : widget.isTranslating
                ? Icons.translate
                : Icons.done;

    return Scaffold(
      backgroundColor: Colors.black87,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        widget.attribution.toUpperCase(),
                        style: TextStyle(
                          color: Colors.grey.shade300,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform(
                          transform: Matrix4.rotationY(_rotateY.value * 2 * pi),
                          alignment: Alignment.center,
                          child: child,
                        );
                      },
                      child: Icon(
                        iconData,
                        color: widget.isTranslating
                            ? Colors.grey.shade300
                            : Colors.greenAccent.shade700,
                        size: 80,
                      ),
                    ),
                    Text(
                      label,
                      style: textStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                height: 30,
                child: Image.asset(
                  'packages/ml_translator/images/white-google.png',
                ),
              ),
              SizedBox(
                height: 150,
                child: (widget.showError ||
                        (!widget.isDownloading && !widget.isTranslating))
                    ? Center(
                        child: ElevatedButton(
                          onPressed: widget.confirm,
                          child: const Text('OK'),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
