import 'dart:async';

import 'package:ml_translator/ml_translator.dart';

part 'example.translator.dart';

@MlTranslator(sourceLanguage: 'en')
class MyTranslation with _$MyTranslation {
  const factory MyTranslation({
    @Val(
      'My best app',
      description: 'My awesome title',
      pl: 'Mój customowy własny opis',
    )
    String title,
    @Val('This text was translated by Google Translator') String bodyText,
    @Val('chinese') String chinese,
    @Val('danish') String danish,
    @Val('english') String english,
    @Val('french') String french,
    @Val('german') String german,
    @Val('greek') String greek,
    @Val('italian') String italian,
    @Val('japanese') String japanese,
    @Val('kannada') String kannada,
    @Val('korean') String korean,
    @Val('polish', pl: 'polski') String polish,
    @Val('spanish', pl: 'hiszp.') String spanish,
  }) = _MyTranslation;
}

// const _$translations = <String, String>{
//   'title_pl': 'Mój customowy własny opis',
//   'bodyText_pl': 'Ble ble',
// };

// class _MyTranslation implements MyTranslation, MlTranslation {
//   const _MyTranslation({
//     this.sourceLanguage = 'en',
//     this.$downloading = 'Downloading language model',
//     this.$translating = 'Translating',
//     this.$done = 'Done',
//     this.$error = 'Error',
//     this.$attribution =
//         'THIS SERVICE MAY CONTAIN TRANSLATIONS POWERED BY GOOGLE. GOOGLE DISCLAIMS ALL WARRANTIES RELATED TO THE TRANSLATIONS, EXPRESS OR IMPLIED, INCLUDING ANY WARRANTIES OF ACCURACY, RELIABILITY, AND ANY IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.',
//     this.$translations = _$translations,
//     this.title = 'My best app',
//     this.bodyText = 'This is some text',
//     this.bodyTextWithVar = 'This is some %s text',
//     this.secondText = 'This is %s line of text. %s, %s.',
//   });

//   @override
//   final String sourceLanguage;

//   @override
//   final String $downloading;

//   @override
//   final String $translating;

//   @override
//   final String $done;

//   @override
//   final String $error;

//   @override
//   final String $attribution;

//   @override
//   final Map<String, String>? $translations;

//   @override
//   final String title;

//   @override
//   final String bodyText;

//   @override
//   final String bodyTextWithVar;

//   @override
//   final String secondText;

//   @override
//   Future<MyTranslation> translateTo(TranslationLanguage targetLanguage) async {
//     const translate = TranslatorUtils.translate;

//     if (targetLanguage.code == sourceLanguage) return this;

//     return _MyTranslation(
//       sourceLanguage: targetLanguage.code,
//       $downloading: await translate($downloading),
//       $translating: await translate($translating),
//       $done: await translate($done),
//       $error: await translate($error),
//       $attribution: await translate($attribution),
//       title: _$translations['title_${targetLanguage.code}'] ??
//           await translate(title),
//       bodyText: _$translations['bodyText_${targetLanguage.code}'] ??
//           await translate(bodyText),
//       bodyTextWithVar:
//           _$translations['bodyTextWithVar_${targetLanguage.code}'] ??
//               await translate(bodyTextWithVar),
//       secondText: _$translations['secondText_${targetLanguage.code}'] ??
//           await translate(secondText),
//     );
//   }

//   @override
//   Map<String, dynamic> toJson() => {
//         'sourceLanguage': sourceLanguage,
//         '\$downloading': $downloading,
//         '\$translating': $translating,
//         '\$done': $done,
//         '\$error': $error,
//         '\$attribution': $attribution,
//         '\$translations': $translations,
//         'title': title,
//         'bodyText': bodyText,
//         'bodyTextWithVar': bodyTextWithVar,
//         'secondText': secondText,
//       };

//   @override
//   _MyTranslation fromJson(Map<String, dynamic> json) => _MyTranslation(
//         sourceLanguage: json['sourceLanguage'] as String,
//         $downloading: json['\$downloading'] as String,
//         $translating: json['\$translating'] as String,
//         $done: json['\$done'] as String,
//         $error: json['\$error'] as String,
//         $attribution: json['\$attribution'] as String,
//         $translations: json['\$translations'] as Map<String, String>,
//         title: json['title'] as String,
//         bodyText: json['bodyText'] as String,
//         bodyTextWithVar: json['bodyTextWithVar'] as String,
//         secondText: json['secondText'] as String,
//       );

//   @override
//   bool operator ==(Object other) {
//     return identical(this, other) ||
//         (other.runtimeType == runtimeType &&
//             other is _MyTranslation &&
//             (identical(other.sourceLanguage, sourceLanguage) ||
//                 other.sourceLanguage == sourceLanguage) &&
//             (identical(other.$downloading, $downloading) ||
//                 other.$downloading == $downloading) &&
//             (identical(other.$translating, $translating) ||
//                 other.$translating == $translating) &&
//             (identical(other.$done, $done) || other.$done == $done) &&
//             (identical(other.$error, $error) || other.$error == $error) &&
//             (identical(other.$attribution, $attribution) ||
//                 other.$attribution == $attribution) &&
//             (identical(other.title, title) || other.title == title) &&
//             (identical(other.bodyText, bodyText) ||
//                 other.bodyText == bodyText) &&
//             (identical(other.bodyTextWithVar, bodyTextWithVar) ||
//                 other.bodyTextWithVar == bodyTextWithVar) &&
//             (identical(other.secondText, secondText) ||
//                 other.secondText == secondText));
//   }

//   @override
//   int get hashCode => Object.hashAll([
//         sourceLanguage,
//         $downloading,
//         $translating,
//         $done,
//         $error,
//         $attribution,
//         title,
//         bodyText,
//         bodyTextWithVar,
//         secondText,
//       ]);
// }

// mixin _$MyTranslation {
//   String get title => throw Exception();
//   String get bodyText => throw Exception();
//   String get bodyTextWithVar => throw Exception();
//   String get secondText => throw Exception();
// }

// class Translator extends StatefulWidget {
//   const Translator({
//     super.key,
//     required this.builder,
//     this.cleanLanguageModels = true,
//   });

//   static String? directory;

//   final Builder builder;
//   final bool cleanLanguageModels;

//   static TranslatorState of(BuildContext context) {
//     try {
//       return context
//           .dependOnInheritedWidgetOfExactType<_InheritedTranslator>()!
//           .state;
//     } catch (_) {
//       throw Exception('Please provide Translator context');
//     }
//   }

//   @override
//   State<Translator> createState() => TranslatorState();
// }

// class TranslatorState extends State<Translator> {
//   late MyTranslation _translation;
//   bool _isDownloading = false;
//   bool _isTranslating = false;
//   bool _showError = false;
//   bool _showInfo = false;

//   Locale get locale => Locale((_translation as _MyTranslation).sourceLanguage);

//   String get _$downloading => (_translation as _MyTranslation).$downloading;
//   String get _$translating => (_translation as _MyTranslation).$translating;
//   String get _$done => (_translation as _MyTranslation).$done;
//   String get _$error => (_translation as _MyTranslation).$error;
//   String get _$attribution => (_translation as _MyTranslation).$attribution;

//   /// My awesome title
//   ///
//   /// **My best app**
//   String get title => _translation.title;

//   /// **This is some text**
//   String get bodyText => _translation.bodyText;

//   String get _bodyTextWithVar => _translation.bodyTextWithVar;

//   /// My descriptionix
//   ///
//   /// **This is some %s text**
//   String bodyTextWithVar(
//     String s0,
//   ) =>
//       _bodyTextWithVar.replaceFirst('%s', s0);

//   String get _secondText => _translation.secondText;

//   /// Mój opis
//   ///
//   /// **This is %s line of text. %s, %s.**
//   String secondText(
//     String s0,
//     String s1,
//     String s2,
//   ) =>
//       _secondText
//           .replaceFirst('%s', s0)
//           .replaceFirst('%s', s1)
//           .replaceFirst('%s', s2);

//   Future<void> translateTo(TranslationLanguage targetLanguage) async {
//     setState(() {
//       _isDownloading = true;
//       _isTranslating = true;
//       _showError = false;
//       _showInfo = true;
//     });

//     const source = (MyTranslation() as _MyTranslation);

//     final sourceLanguage = source.sourceLanguage;

//     final isInitialized = await TranslatorUtils.initLanguageModels(
//       TranslationLanguage.values.firstWhere(
//         (element) => element.code == sourceLanguage,
//       ),
//       targetLanguage,
//     );

//     setState(() {
//       _isDownloading = false;

//       if (!isInitialized) {
//         _isTranslating = false;
//         _showError = true;
//       }
//     });

//     if (isInitialized) {
//       final result = await source.translateTo(targetLanguage);

//       setState(() {
//         _translation = result;
//         _isTranslating = false;
//       });
//     }

//     if (widget.cleanLanguageModels) {
//       TranslatorUtils.deleteLanguage(targetLanguage);
//     }
//   }

//   void _confirmTranslation() {
//     setState(() {
//       _isDownloading = false;
//       _isTranslating = false;
//       _showError = false;
//       _showInfo = false;
//     });
//   }

//   @override
//   void initState() {
//     if (Translator.directory == null) {
//       throw Exception('''
// Translator.directory has to be initialized. Ex.
// ```
// final directory = await getApplicationDocumentsDirectory();
// Translator.directory = directory.path;
// ```
// ''');
//     }

//     Future(() async {
//       final translation =
//           await TranslatorUtils.init(const MyTranslation() as MlTranslation)
//               as MyTranslation;

//       setState(() {
//         _translation = translation;
//       });
//     });

//     Future.delayed(
//       const Duration(seconds: 2),
//       () async {
//         await translateTo(
//           TranslationLanguage.polish,
//         );
//       },
//     );

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection:
//           TextDirection.ltr, // ustawic text direction na podstawie języka
//       child: Stack(
//         children: [
//           _InheritedTranslator(
//             state: this,
//             child: widget.builder,
//           ),
//           if (_showInfo)
//             TranslatorLoadingWidget(
//               isDownloading: _isDownloading,
//               isTranslating: _isTranslating,
//               showError: _showError,
//               downloading: _$downloading,
//               translating: _$translating,
//               done: _$done,
//               error: _$error,
//               attribution: _$attribution,
//               confirm: _confirmTranslation,
//             )
//         ],
//       ),
//     );
//   }
// }

// class _InheritedTranslator extends InheritedWidget {
//   final TranslatorState state;

//   const _InheritedTranslator({
//     required this.state,
//     required super.child,
//   });

//   @override
//   bool updateShouldNotify(_InheritedTranslator oldWidget) => oldWidget != this;
// }
