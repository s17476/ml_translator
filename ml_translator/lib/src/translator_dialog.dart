import 'package:ml_translator/ml_translator.dart';

class TranslatorDialog extends StatelessWidget {
  const TranslatorDialog({
    super.key,
    required this.cancel,
    required this.confirm,
  });

  final VoidCallback cancel;
  final Function(TranslationLanguage) confirm;

  @override
  Widget build(BuildContext context) {
    final code = Platform.localeName.split('_')[0];

    final language = TranslationLanguage.fromCode(code);

    return Scaffold(
      backgroundColor: Colors.black87,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(),
                    Text(
                      'Do you want to change the language to ${language?.toJson()}?',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
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
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: cancel,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade800,
                          foregroundColor: Colors.grey.shade200,
                        ),
                        child: const Icon(Icons.clear),
                      ),
                      ElevatedButton(
                        onPressed: () => confirm(language!),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade800,
                          foregroundColor: Colors.grey.shade200,
                        ),
                        child: const Icon(Icons.done),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
