import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/RegisterLogin.dart';
import '../screens/page_header.dart';

import '../Util/bottom_bar.dart';
import '../Util/colors.dart';
import '../Util/text_style.dart';
import 'location.dart';
import 'speech.dart';
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:translator/translator.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
// class RecordingScreen extends StatefulWidget {
//   const RecordingScreen({Key? key}) : super(key: key);

//   @override
//   State<RecordingScreen> createState() => _RecordingScreenState();
// }

// class _RecordingScreenState extends State<RecordingScreen> {
//   String text = 'Speeeech...';
//   static final TextStyle headerStyle = TextStyle(
//     color: KColor.mainBlueColor,
//     fontSize: 30,
//     fontWeight: FontWeight.bold,
//     fontFamily: 'Lateef',
//   );
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         bottomNavigationBar: BottomBar(),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Column(
//               children: [
//                 PageHeader(),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'اضغط',
//                       style: headerStyle,
//                     ),
//                     Icon(
//                       Icons.mic,
//                       color: KColor.mainBlueColor,
//                       size: 40,
//                     ),
//                     Text('لبدء التسجيل', style: headerStyle),
//                   ],
//                 ),
//               ],
//             ),
//             Text(text),
//             SizedBox(
//               height: 30,
//             ),
//             AvatarGlow(
//               glowColor: Color(0xff21A7CC),
//               endRadius: 140,
//               duration: Duration(seconds: 2),
//               repeat: true,
//               showTwoGlows: true,
//               curve: Curves.easeOutQuad,
//               child: GestureDetector(
//                 child: GestureDetector(
// onTap: !_hasSpeech || speech.isListening
//       ? null
//       : startListening,
//                   child: Image(
//                     width: 140.0,
//                     image: AssetImage('images/record.png'),
//                   ),
//                 ),
//                 onTap: () {
//                   toggleRecording();
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future toggleRecording() => SpeechApi.toggleRecording(

//       onResult: (text) => setState(
//             () {
//               this.text = text;
//             },
//           ));
// }

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  String _currentLocaleId = "";
  static final TextStyle headerStyle = TextStyle(
    color: KColor.mainBlueColor,
    fontSize: 30,
    fontWeight: FontWeight.bold,
    fontFamily: 'Lateef',
  );
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();
  String translatedText = '';
  final text = 'الم الظهر والرأس ووجع في المعدة والبطن';

  @override
  void initState() {
    super.initState();
    //  print(text);
    // print(response);
    translate();
  }

  void translate() async {
    dynamic response = await text.translate(from: 'ar', to: 'en');

    // setState(() {
    //   translatedText = response.toString();
    // });
    // final onDeviceTranslator = OnDeviceTranslator(
    //     sourceLanguage: TranslateLanguage.arabic,
    //     targetLanguage: TranslateLanguage.english);
    // final String response = await onDeviceTranslator.translateText(text);
    print(response.toString());
  }

  Future<void> initSpeechState() async {
    bool hasSpeech = await speech.initialize(
        onError: errorListener, onStatus: statusListener);
    if (hasSpeech) {
      _localeNames = await speech.locales();

      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale!.localeId;
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                PageHeader(),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'اضغط',
                        style: headerStyle,
                      ),
                      Icon(
                        Icons.mic,
                        color: KColor.mainBlueColor,
                        size: 40,
                      ),
                      Text('لبدء التسجيل', style: headerStyle),
                    ],
                  ),
                  onPressed: _hasSpeech ? null : initSpeechState,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    DropdownButton(
                      onChanged: (selectedVal) => _switchLang(selectedVal),
                      value: _currentLocaleId,
                      items: _localeNames
                          .map(
                            (localeName) => DropdownMenuItem(
                          value: localeName.localeId,
                          child: Text(localeName.name),
                        ),
                      )
                          .toList(),
                    ),
                  ],
                ),
              ],
            ),
            Text(lastWords),
            Text(translatedText),
            AvatarGlow(
              glowColor: Color(0xff21A7CC),
              endRadius: 140,
              duration: Duration(seconds: 2),
              repeat: true,
              showTwoGlows: true,
              curve: Curves.easeOutQuad,
              child: GestureDetector(
                child: GestureDetector(
                  onTap:
                  !_hasSpeech || speech.isListening ? null : startListening,
                  child: Image(
                    width: 140.0,
                    image: AssetImage('images/record.png'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startListening() {
    // initSpeechState();
    lastWords = "";
    lastError = "";

    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 10),
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        partialResults: true);
    //translate();
    setState(() {});
  }

  void stopListening() {
    speech.stop();
    setState(() {
      level = 0.0;
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      lastWords = "${result.recognizedWords} - ${result.finalResult}";
    });
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    //print("sound level $level: $minSoundLevel - $maxSoundLevel ");
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    print("Received error status: $error, listening: ${speech.isListening}");
    setState(() {
      lastError = "${error.errorMsg} - ${error.permanent}";
    });
  }

  void statusListener(String status) {
    print(
        "Received listener status: $status, listening: ${speech.isListening}");
    setState(() {
      lastStatus = "$status";
    });
  }

  _switchLang(selectedVal) {
    setState(() {
      _currentLocaleId = selectedVal;
    });
    print(selectedVal);
  }
}
