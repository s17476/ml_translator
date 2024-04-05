enum TranslationLanguage {
  afrikaans('af'),
  albanian('sq'),
  arabic('ar'),
  belarusian('be'),
  bengali('bn'),
  bulgarian('bg'),
  catalan('ca'),
  chinese('zh'),
  croatian('hr'),
  czech('cs'),
  danish('da'),
  dutch('nl'),
  english('en'),
  esperanto('eo'),
  estonian('et'),
  finnish('fi'),
  french('fr'),
  galician('gl'),
  georgian('ka'),
  german('de'),
  greek('el'),
  gujarati('gu'),
  haitian('ht'),
  hebrew('he'),
  hindi('hi'),
  hungarian('hu'),
  icelandic('is'),
  indonesian('id'),
  irish('ga'),
  italian('it'),
  japanese('ja'),
  kannada('kn'),
  korean('ko'),
  latvian('lv'),
  lithuanian('lt'),
  macedonian('mk'),
  malay('ms'),
  maltese('mt'),
  marathi('mr'),
  norwegian('no'),
  persian('fa'),
  polish('pl'),
  portuguese('pt'),
  romanian('ro'),
  russian('ru'),
  slovak('sk'),
  slovenian('sl'),
  spanish('es'),
  swahili('sw'),
  swedish('sv'),
  tagalog('tl'),
  tamil('ta'),
  telugu('te'),
  thai('th'),
  turkish('tr'),
  ukrainian('uk'),
  urdu('ur'),
  vietnamese('vi'),
  welsh('cy');

  final String code;

  const TranslationLanguage(this.code);

  String toJson() => name;

  static TranslationLanguage? fromCode(String code) =>
      values.where((element) => element.code == code).firstOrNull;

  static TranslationLanguage fromJson(String json) => values.byName(json);
}
