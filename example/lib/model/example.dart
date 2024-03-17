import 'package:ml_translator/ml_translator.dart';

part 'example.translator.dart';

@MlTranslator(sourceLanguage: 'en')
class Example with _$Example {
  const factory Example({
    @Val(
      'My best app',
      description: 'My awesome title',
      pl: 'Mój customowy własny opis',
    )
    String title,
    @Val('This is some text', pl: 'Ble ble') String bodyText,
    @Val('This is some %s text', description: 'My descriptionix')
    String bodyTextWithVar,
    @Val(
      'This is %s line of text. %s, %s.',
      description: 'Mój opis',
    )
    String secondText,
  }) = _Example;
}
