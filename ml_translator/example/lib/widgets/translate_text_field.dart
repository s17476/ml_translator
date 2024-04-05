import 'package:example/model/example.dart';
import 'package:flutter/material.dart';

class TranslateTextField extends StatefulWidget {
  const TranslateTextField({super.key});

  @override
  State<TranslateTextField> createState() => _TranslateTextFieldState();
}

class _TranslateTextFieldState extends State<TranslateTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = 'Hello, world!';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListenableBuilder(
            listenable: _controller,
            builder: (context, _) {
              return Container(
                padding: const EdgeInsets.all(8),
                color: Colors.grey.shade200,
                child: TranslatedText(text: _controller.text),
              );
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
          ),
        ],
      ),
    );
  }
}
