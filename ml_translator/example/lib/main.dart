import 'package:example/model/example.dart';
import 'package:example/widgets/translate_text_field.dart';
import 'package:ml_translator/ml_translator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Translator.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Translator(
      builder: (context, state) {
        return MaterialApp(
          title: state.title,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
            ),
          ),
          locale: state.locale,
          supportedLocales: state.supportedLocales,
          localizationsDelegates: state.localizationsDelegates,
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final buttons = [
      (TranslationLanguage.chinese, Translator.of(context).chinese),
      (TranslationLanguage.danish, Translator.of(context).danish),
      (TranslationLanguage.english, Translator.of(context).english),
      (TranslationLanguage.french, Translator.of(context).french),
      (TranslationLanguage.german, Translator.of(context).german),
      (TranslationLanguage.greek, Translator.of(context).greek),
      (TranslationLanguage.italian, Translator.of(context).italian),
      (TranslationLanguage.japanese, Translator.of(context).japanese),
      (TranslationLanguage.kannada, Translator.of(context).kannada),
      (TranslationLanguage.korean, Translator.of(context).korean),
      (TranslationLanguage.polish, Translator.of(context).polish),
      (TranslationLanguage.spanish, Translator.of(context).spanish),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(Translator.of(context).title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const TranslateTextField(),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: Center(
                        child: Text(
                          Translator.of(context).bodyText,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.4,
              child: GridView.count(
                padding: const EdgeInsets.all(8),
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 9 / 4,
                children: buttons
                    .map(
                      (e) => ElevatedButton(
                        onPressed: () =>
                            Translator.of(context).translateTo(e.$1),
                        child: Text(e.$2),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
