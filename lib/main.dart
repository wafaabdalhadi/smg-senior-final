// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/screens/ClinicDates.dart';
// import 'package:flutter_application_1/screens/DoctorRegister.dart';
// import 'package:flutter_application_1/screens/PatientLogIn.dart';
// import 'package:flutter_application_1/screens/RegisterForPatient.dart';
// import 'package:flutter_application_1/screens/appointments.dart';
// import 'package:flutter_application_1/screens/clinics.dart';
// import 'package:flutter_application_1/screens/recording_screen.dart';
// import 'package:flutter_application_1/screens/resevations.dart';
// import 'package:flutter_application_1/screens/welcome.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(debugShowCheckedModeBanner: false, home: RecordingScreen());
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   SpeechToText _speechToText = SpeechToText();
//   bool _speechEnabled = false;
//   String _lastWords = '';

//   @override
//   void initState() {
//     super.initState();
//     _initSpeech();
//   }

//   /// This has to happen only once per app
//   void _initSpeech() async {
//     _speechEnabled = await _speechToText.initialize(
//       onError: (errorNotification) => print('ERROR is $errorNotification'),
//       onStatus: (status) => print('STATUS is $status'),
//     );
//     print('initailize');
//     setState(() {});
//   }

//   /// Each time to start a speech recognition session
//   void _startListening() async {
//     await _speechToText.listen(onResult: (result) {
//       //await ****************

//       print('speeeech');
//       setState(() {
//         _lastWords = result.recognizedWords;
//         print(_lastWords);
//       });
//     });
//     // Future<dynamic> words = _speechToText.listen(
//     //   onResult: (result) => result,
//     // );
//     // words.then(
//     //   (value) => print(value),
//     // );
//     // print('start listening');
//   }

//   /// Manually stop the active speech recognition session
//   /// Note that there are also timeouts that each platform enforces
//   /// and the SpeechToText plugin supports setting timeouts on the
//   /// listen method.
//   void _stopListening() async {
//     await _speechToText.stop();
//     print('stop listening');
//     setState(() {});
//   }

//   /// This is the callback that the SpeechToText plugin calls when
//   /// the platform returns recognized words.
//   void _onSpeechResult(SpeechRecognitionResult result) {
//     print('speeeech');
//     // setState(() {
//     //   _lastWords = result.recognizedWords;
//     //   print(_lastWords);
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('speech demo')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               padding: EdgeInsets.all(16),
//               child: Text(
//                 'Recognized words:',
//                 style: TextStyle(fontSize: 20.0),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.all(16),
//                 child: Text(
//                   // If listening is active show the recognized words
//                   _speechToText.isListening
//                       ? _lastWords
//                       // If listening isn't active but could be tell the user
//                       // how to start it, otherwise indicate that speech
//                       // recognition is not yet ready or not supported on
//                       // the target device
//                       : _speechEnabled
//                           ? 'Tap the microphone to start listening...'
//                           : 'Speech not available',
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed:
//             // If not yet listening for speech start, otherwise stop
//             _speechToText.isNotListening ? _startListening : _stopListening,
//         tooltip: 'Listen',
//         child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
//       ),
//     );
//   }
//
import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smg_senior/Clinics/ClinicReader.dart';
import 'package:smg_senior/Clinics/ClinicsList.dart';
import 'package:smg_senior/OTPCode/mainOTP.dart';
import 'package:smg_senior/screens/DoctorLogIn.dart';
import 'package:smg_senior/screens/PatientLogin.dart';
import 'package:smg_senior/screens/RegisterForPatient.dart';
import 'package:smg_senior/screens/RegisterLogin.dart';
import 'package:smg_senior/screens/clinics.dart';
import 'package:smg_senior/screens/recording_screen.dart';
import 'package:smg_senior/screens/verification_screen.dart';
// import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:translator/translator.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'OTPCode/SignUpPage.dart';
import 'OTPCode/homePage.dart';

// void main() => runApp(MaterialApp(home: MyApp()));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      home: MainOTP(),
    )

  );
}

// class MyApp extends S`tatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool _hasSpeech = false;
//   double level = 0.0;
//   double minSoundLevel = 50000;
//   double maxSoundLevel = -50000;
//   String lastWords = "";
//   String lastError = "";
//   String lastStatus = "";
//   String _currentLocaleId = "";
//   List<LocaleName> _localeNames = [];
//   final SpeechToText speech = SpeechToText();

//   final text = 'الم الظهر والرأس ووجع في المعدة والبطن';

//   @override
//   void initState() {
//     super.initState();
//   //  print(text);
//     // print(response);
//     translate();
//   }

//   void translate() async {
//     dynamic response = await text.translate(from: 'ar', to: 'en');
//     // final onDeviceTranslator = OnDeviceTranslator(
//     //     sourceLanguage: TranslateLanguage.arabic,
//     //     targetLanguage: TranslateLanguage.english);
//     // final String response = await onDeviceTranslator.translateText(text);
//     print(response.toString());
//   }

//   Future<void> initSpeechState() async {
//     bool hasSpeech = await speech.initialize(
//         onError: errorListener, onStatus: statusListener);
//     if (hasSpeech) {
//       _localeNames = await speech.locales();

//       var systemLocale = await speech.systemLocale();
//       _currentLocaleId = systemLocale!.localeId;
//     }

//     if (!mounted) return;

//     setState(() {
//       _hasSpeech = hasSpeech;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Speech to Text Example'),
//         ),
//         body: Column(children: [
//           Center(
//             child: Text(
//               'Speech recognition available',
//               style: TextStyle(fontSize: 22.0),
//             ),zz
//           ),
//           Container(
//             child: Column(
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//                     ElevatedButton(
//                       child: Text('Initialize'),
//                       onPressed: _hasSpeech ? null : initSpeechState,
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//                     ElevatedButton(
//                       child: Text('Start'),
//                       onPressed: !_hasSpeech || speech.isListening
//                           ? null
//                           : startListening,
//                     ),
//                     ElevatedButton(
//                       child: Text('Stop'),
//                       onPressed: speech.isListening ? stopListening : null,
//                     ),
//                     ElevatedButton(
//                       child: Text('Cancel'),
//                       onPressed: speech.isListening ? cancelListening : null,
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//                     DropdownButton(
//                       onChanged: (selectedVal) => _switchLang(selectedVal),
//                       value: _currentLocaleId,
//                       items: _localeNames
//                           .map(
//                             (localeName) => DropdownMenuItem(
//                               value: localeName.localeId,
//                               child: Text(localeName.name),
//                             ),
//                           )
//                           .toList(),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 4,
//             child: Column(
//               children: <Widget>[
//                 Center(
//                   child: Text(
//                     'Recognized Words',
//                     style: TextStyle(fontSize: 22.0),
//                   ),
//                 ),
//                 Expanded(
//                   child: Stack(
//                     children: <Widget>[
//                       Container(
//                         color: Theme.of(context).selectedRowColor,
//                         child: Center(
//                           child: Text(
//                             lastWords,
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                       Positioned.fill(
//                         bottom: 10,
//                         child: Align(
//                           alignment: Alignment.bottomCenter,
//                           child: Container(
//                             width: 40,
//                             height: 40,
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                               boxShadow: [
//                                 BoxShadow(
//                                     blurRadius: .26,
//                                     spreadRadius: level * 1.5,
//                                     color: Colors.black.withOpacity(.05))
//                               ],
//                               color: Colors.white,
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(50)),
//                             ),
//                             child: IconButton(
//                                 icon: Icon(Icons.mic),
//                                 onPressed: () {
//                                   /*...*/
//                                 }),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Column(
//               children: <Widget>[
//                 Center(
//                   child: Text(
//                     'Error Status',
//                     style: TextStyle(fontSize: 22.0),
//                   ),
//                 ),
//                 Center(
//                   child: Text(lastError),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(vertical: 20),
//             color: Theme.of(context).backgroundColor,
//             child: Center(
//               child: speech.isListening
//                   ? Text(
//                       "I'm listening...",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     )
//                   : Text(
//                       'Not listening',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }

//   void startListening() {
//     lastWords = "";
//     lastError = "";
//     speech.listen(
//         onResult: resultListener,
//         listenFor: Duration(seconds: 10),
//         localeId: _currentLocaleId,
//         onSoundLevelChange: soundLevelListener,
//         cancelOnError: true,
//         partialResults: true);
//     setState(() {});
//   }

//   void stopListening() {
//     speech.stop();
//     setState(() {
//       level = 0.0;
//     });
//   }

//   void cancelListening() {
//     speech.cancel();
//     setState(() {
//       level = 0.0;
//     });
//   }

//   void resultListener(SpeechRecognitionResult result) {
//     setState(() {
//       lastWords = "${result.recognizedWords} - ${result.finalResult}";
//     });
//   }

//   void soundLevelListener(double level) {
//     minSoundLevel = min(minSoundLevel, level);
//     maxSoundLevel = max(maxSoundLevel, level);
//     //print("sound level $level: $minSoundLevel - $maxSoundLevel ");
//     setState(() {
//       this.level = level;
//     });
//   }

//   void errorListener(SpeechRecognitionError error) {
//     print("Received error status: $error, listening: ${speech.isListening}");
//     setState(() {
//       lastError = "${error.errorMsg} - ${error.permanent}";
//     });
//   }

//   void statusListener(String status) {
//     print(
//         "Received listener status: $status, listening: ${speech.isListening}");
//     setState(() {
//       lastStatus = "$status";
//     });
//   }

//   _switchLang(selectedVal) {
//     setState(() {
//       _currentLocaleId = selectedVal;
//     });
//     print(selectedVal);
//   }
// }
