
Welcome to a very early version of MlTranslator. Translation generator and live translator for over 70 languages.

## Motivation

As developers, we want to make our applications available to the largest possible audience and ensure comfortable use by supporting many languages, but manual translation takes a lot of time. Especially during application development, when we need to add new phrases to files appropriate for each language. And even then, we are limited to the languages offered by the API we use.

Under the hood, MlTranslator uses the google_mlkit_translation package and its language models for machine translation. [google_mlkit_translation](https://pub.dev/packages/google_mlkit_translation).

Of course, these translations are not perfect, and therefore it is possible to provide your own translations for phrases that cause problems for the translator.

### Benefits
- automatic translations into over 70 languages
- text translations on the fly - e.g. from API or messages, etc.
- automatic device language detection
- out of the box saving the selected language
- ability to reach a wider audience
- time saving

## How does it work

<p>
  <img width="33%" alt="Example Language detection" src="https://raw.githubusercontent.com/s17476/ml_translator/master/res/Screenshot%202024-04-04%20at%2018.36.35.png"/>
  <img width="31%" alt="Example Translation" src="https://raw.githubusercontent.com/s17476/ml_translator/master/res/Record_2024-04-04-18-24-42%20(1).gif"/>
  <img width="31%" alt="Example App Open" src="https://raw.githubusercontent.com/s17476/ml_translator/master/res/Record_2024-04-04-18-28-02.gif" />
</p>

### Device language detection
By default, MlTranslator will try to detect the device language and if it is on the supported list, it will show a dialog asking whether to translate with the application.

### App translation
If the user decides to translate, information about downloading the language model and translation will be displayed. MlTranslator will save the selected language, so you don't need your own implementation of this setting.

To translate the application into another language - chinese in this case, simply call:
```dart
Translator.of(context).translateTo(TranslationLanguage.chinese);
```

### Translations on the fly
Use the `Translatedtext` widget and pass the text you want to translate to it.

### Attribution
Since MlTranslator uses Google Translate under the hood, attribution is required according to the rules available [here](https://developers.google.com/ml-kit/language/translation/translation-terms). For this reason, the device language detection dialog, the model download dialog, and the TranslatedText widget are not customizable.

### Supported languages
MLTranslator can translate between the following [languages](https://developers.google.com/ml-kit/language/translation/translation-language-support).

## Getting started

```console
flutter pub add ml_translator
flutter pub add dev:build_runner
flutter pub add dev:ml_translator_generator
```

This installs three packages:

- [build_runner](https://pub.dev/packages/build_runner) - to run code-generator
- ml_translator_generator - the code generator
- ml_translator - a package containing annotations and utils for generated code.

## Requirements and platforms setup
MlTranslator has the same requirements and platform setup as [google_mlkit_translation](https://pub.dev/packages/google_mlkit_translation).

### iOS

- Minimum iOS Deployment Target: 12.0
- Xcode 13.2.1 or newer
- Swift 5
- ML Kit does not support 32-bit architectures (i386 and armv7). ML Kit does support 64-bit architectures (x86_64 and arm64). Check this [list](https://developer.apple.com/support/required-device-capabilities/) to see if your device has the required device capabilities. More info [here](https://developers.google.com/ml-kit/migration/ios).

Since ML Kit does not support 32-bit architectures (i386 and armv7), you need to exclude armv7 architectures in Xcode in order to run `flutter build ios` or `flutter build ipa`. More info [here](https://developers.google.com/ml-kit/migration/ios).

Go to Project > Runner > Building Settings > Excluded Architectures > Any SDK > armv7

<p>
  <img src="https://raw.githubusercontent.com/flutter-ml/google_ml_kit_flutter/master/resources/build_settings_01.png">
</p>

Your Podfile should look like this:

```ruby
platform :ios, '12.0'  # or newer version

...

# add this line:
$iOSVersion = '12.0'  # or newer version

post_install do |installer|
  # add these lines:
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=*]"] = "armv7"
    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = $iOSVersion
  end
  
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    
    # add these lines:
    target.build_configurations.each do |config|
      if Gem::Version.new($iOSVersion) > Gem::Version.new(config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'])
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = $iOSVersion
      end
    end
    
  end
end
```

Notice that the minimum `IPHONEOS_DEPLOYMENT_TARGET` is 12.0, you can set it to something newer but not older.

### Android

- minSdkVersion: 21
- targetSdkVersion: 33
- compileSdkVersion: 33

## Usage

### Create translation model

Consider creating a model in English. This will give you the best translation results into other languages. Also, if you use `TranslatedText` widget to translate, e.g. data from the REST API, it will make things easier because it is easiest to find materials in English.

```dart
// import this package
import 'package:ml_translator/ml_translator.dart';

// declare the part '*.translator.dart'; - this is where the generated classes and widgets will be saved
part 'my_class.translator.dart';

// annotate your class and declare language
@MlTranslator(sourceLanguage: 'en')
class MyClass with _$MyClass {
  const factory MyClass({
    // use @Val('Original text') to annotate every single constructor field
    @Val(
      'My best app',
      // description field is optional and will be shown in the tooltip in your IDE
      description: 'My awesome title',
      // fields marked with a language code, e.g. pl, da, etc., are used to define your own translations
      // and if they are not null, their value will be used as the translation
      pl: 'Mój customowy tytuł',
    )
    String title,
    @Val('This text was translated by Google Translator.') String bodyText,
    @Val('italian') String italian,
    @Val('japanese') String japanese,
    @Val('korean') String korean,
    @Val('polish', pl: 'polski') String polish,
    @Val('spanish', pl: 'hiszp') String spanish,
  }) = _MyClass;
}
```

### Run the generator

To run the generator once, execute this command in your project folder
```
dart run build_runner build --delete-conflicting-outputs
```

To let the build_runner observe your project and generate new code whenever you save changes to annotated classes, run:
```
dart run build_runner watch --delete-conflicting-outputs
```
**Remember that if you update the translation model, you must run code generation again.**

### Initialize the translator
To use the **Translator**, import the translation model
```dart
import 'package:my_package/my_class.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Translator.init();

  runApp(const MyApp());
}
```

### Use generated Translator widget
Wrap MaterialApp with generated Translator. Use Translator widget **only once** in your app!
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Translator(
      builder: (context, state) {
        return MaterialApp(
          // state gives access to translations
          title: state.title,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
            ),
          ),
          // provide the MaterialApp parameters necessary for the translator
          locale: state.locale,
          supportedLocales: state.supportedLocales,
          localizationsDelegates: state.localizationsDelegates,
          //
          home: const MyHomePage(),
        );
      },
    );
  }
}
```

### Use translations
You can access the translations via `Translator.of(context)`:
```dart
child: Text(
  Translator.of(context).bodyText,
),
```

To inject value into string declare constructor field:
```dart
@Val('You have %s items in the cart') String itemsInCart,
```
So it can be reached as following:
```dart
child: Text(
  Translator.of(context).itemsInCart('5'),
),
```

## Changing the language
To translate the app into another language - german in this case, simply call:
```dart
Translator.of(context).translateTo(TranslationLanguage.german);
```
This will download the language model and translate the application. The translations and the selected language will be saved and used during subsequent launches of the application - **the translation dialogue will not appear**.

If you update the translation model, e.g. in a new version or during development, the first time you run it after the update, a dialog will appear informing about the application's translation, with the difference that this time no data download will be required. The previously saved language model will be used.

## Automatic device language detection
By default, MlTranslator will try to detect the language of the device and if it is one of the supported languages, it will propose a translation by showing a dialogue.

If you want to disable this behavior, set `detectDeviceLanguage: false` in the Translator widget config as shown below:
```dart
 @override
  Widget build(BuildContext context) {
    return Translator(
      detectDeviceLanguage: false,
      builder: (context, state) {
        return MaterialApp(
          //...
        );
      },
    );
  }
```

## On the fly translation
Easily translate text entered by the user or downloaded from the API.
```dart
TranslatedText(
  text: _controller.text,
  style: const TextStyle(fontSize: 16),
  // attribution image type [color, greyscale, white]
  imageType: ImageType.greyscale,
  // translation indicator params
  shimmerPeriod: const Duration(milliseconds: 1500),
  shimmerBaseColor: Colors.yellow,
  shimmerHighlightColor: Colors.blue,
)
```

## Further plans
- adding the ability to customize dialogues
- adding an element from which to select the language - perhaps ModalBottomSheet
- unit tests of the generator
