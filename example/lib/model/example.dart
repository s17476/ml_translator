import 'dart:async';

import 'package:ml_translator/ml_translator.dart';

part 'example.translator.dart';

@MlTranslator(sourceLanguage: 'en')
class MyStrings with _$MyStrings {
  const factory MyStrings({
    @Val(
      'My best app',
      description: 'My awesome title',
      pl: 'Mój customowy tytuł',
    )
    String title,
    @Val('This text was translated by Google Translator.') String bodyText,
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
    @Val('spanish', pl: 'hiszp') String spanish,
  }) = _MyStrings;
}
