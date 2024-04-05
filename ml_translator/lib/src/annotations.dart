class MlTranslator {
  /// The language in which the default text of the application was entered.
  /// The preferred default language is English.
  /// English also provides the best quality translations.
  final String sourceLanguage;

  /// Overwrite default text on the translation screen for:
  /// \"***Downloading language model***\"
  final String downloading;

  /// Overwrite default text on the translation screen for:
  /// \"***Translating***\"
  final String translating;

  /// Overwrite default text on the translation screen for:
  /// \"***Done***\"
  final String done;

  /// Overwrite default text on the translation screen for:
  /// \"***Error***\"
  final String error;

  const MlTranslator({
    this.sourceLanguage = 'en',
    this.downloading = 'Downloading language model',
    this.translating = 'Translating',
    this.done = 'Done',
    this.error = 'Error',
  });
}

const mlTranslator = MlTranslator();

class Val {
  /// The value of this field for the default language.
  final String val;

  /// Optional description of this field.
  /// The text entered here will appear in the tooltips.
  final String? description;
  final String? af;
  final String? sq;
  final String? ar;
  final String? be;
  final String? bn;
  final String? bg;
  final String? ca;
  final String? zh;
  final String? hr;
  final String? cs;
  final String? da;
  final String? nl;
  final String? en;
  final String? eo;
  final String? et;
  final String? fi;
  final String? fr;
  final String? gl;
  final String? ka;
  final String? de;
  final String? el;
  final String? gu;
  final String? ht;
  final String? he;
  final String? hi;
  final String? hu;
  final String? isl;
  final String? id;
  final String? ga;
  final String? it;
  final String? ja;
  final String? kn;
  final String? ko;
  final String? lv;
  final String? lt;
  final String? mk;
  final String? ms;
  final String? mt;
  final String? mr;
  final String? no;
  final String? fa;
  final String? pl;
  final String? pt;
  final String? ro;
  final String? ru;
  final String? sk;
  final String? sl;
  final String? es;
  final String? sw;
  final String? sv;
  final String? tl;
  final String? ta;
  final String? te;
  final String? th;
  final String? tr;
  final String? uk;
  final String? ur;
  final String? vi;
  final String? cy;

  const Val(
    this.val, {
    this.description,
    this.af,
    this.sq,
    this.ar,
    this.be,
    this.bn,
    this.bg,
    this.ca,
    this.zh,
    this.hr,
    this.cs,
    this.da,
    this.nl,
    this.en,
    this.eo,
    this.et,
    this.fi,
    this.fr,
    this.gl,
    this.ka,
    this.de,
    this.el,
    this.gu,
    this.ht,
    this.he,
    this.hi,
    this.hu,
    this.isl,
    this.id,
    this.ga,
    this.it,
    this.ja,
    this.kn,
    this.ko,
    this.lv,
    this.lt,
    this.mk,
    this.ms,
    this.mt,
    this.mr,
    this.no,
    this.fa,
    this.pl,
    this.pt,
    this.ro,
    this.ru,
    this.sk,
    this.sl,
    this.es,
    this.sw,
    this.sv,
    this.tl,
    this.ta,
    this.te,
    this.th,
    this.tr,
    this.uk,
    this.ur,
    this.vi,
    this.cy,
  });
}
