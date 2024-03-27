import 'package:flutter/material.dart';
import 'package:ml_translator/render_objects/translated_text_widget.dart';
import 'package:ml_translator/widgets/translated_text.dart';

class TranslateTextField extends StatefulWidget {
  const TranslateTextField({super.key});

  @override
  State<TranslateTextField> createState() => _TranslateTextFieldState();
}

class _TranslateTextFieldState extends State<TranslateTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = 'Hello, world! d s ds d s d sd  sd s d  d s  s d ds d s';
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
          SizedBox(height: 16),
          TextField(
            controller: _controller,
          ),
        ],
      ),
    );
  }
}
