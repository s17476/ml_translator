// import 'package:flutter/material.dart';

// import 'package:ml_translator/ml_translator.dart';

// class Translator<T extends Translation> extends StatefulWidget {
//   const Translator({
//     super.key,
//     required this.translation,
//     required this.child,
//   });

//   final T translation;

//   final Widget child;

//   static TranslatorState of(BuildContext context) {
//     final state = context.findAncestorStateOfType<TranslatorState>();
//     if (state != null) {
//       return state;
//     } else {
//       throw Exception('Please provide Translator context');
//     }
//   }

//   @override
//   State<Translator> createState() => TranslatorState();
// }

// class TranslatorState<T extends Translation> extends State<Translator> {
//   late T translation;

//   @override
//   void initState() {
//     translation = widget.translation as T;

//     Future.delayed(
//       const Duration(seconds: 2),
//       () => translation.translateTo(TranslationLanguage.danish),
//     );

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Builder(builder: (context) {
//       return widget.child;
//     });
//   }
// }
