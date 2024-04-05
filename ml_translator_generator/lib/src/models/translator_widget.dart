createTranslatorWidget(StringBuffer buffer) {
  buffer.write('''
class Translator extends StatefulWidget {
  const Translator({
    super.key,
    required this.builder,
    this.cleanLanguageModels = false,
    this.detectDeviceLanguage = true,
  });

  final Widget Function(
    BuildContext context,
    TranslatorState state,
  ) builder;
  final bool cleanLanguageModels;
  final bool detectDeviceLanguage;

  /// This part should be initialized in `main()` function
  /// ```
  /// void main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  /// 
  ///   await Translator.init();
  /// 
  ///   runApp(const MyApp());
  /// }
  /// ```
  static Future<void> init() => TranslatorUtils.initDb();

  static TranslatorState of(BuildContext context) {
    try {
      return context
          .dependOnInheritedWidgetOfExactType<_InheritedTranslator>()!
          .state;
    } catch (_) {
      throw Exception('Please provide Translator context');
    }
  }

  @override
  State<Translator> createState() => TranslatorState();
}''');
}
