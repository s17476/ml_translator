import 'package:flutter/material.dart';

class TranslatorLoadingWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.grey.shade300,
      fontSize: 24,
    );

    final label = showError
        ? error
        : isDownloading
            ? downloading
            : isTranslating
                ? translating
                : done;

    final iconData = showError
        ? Icons.error_outline
        : isDownloading
            ? Icons.download
            : isTranslating
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
                    Text(
                      attribution,
                      style:
                          TextStyle(color: Colors.grey.shade300, fontSize: 18),
                      textAlign: TextAlign.justify,
                    ),
                    Icon(
                      iconData,
                      color: Colors.grey.shade100,
                      size: 80,
                    ),
                    Text(
                      label,
                      style: textStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Image.asset('packages/ml_translator/images/white-google.png'),
              SizedBox(
                height: 150,
                child: (showError || (!isDownloading && !isTranslating))
                    ? Center(
                        child: ElevatedButton(
                          onPressed: confirm,
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
