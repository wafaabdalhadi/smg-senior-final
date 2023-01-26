import 'dart:convert';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import '../screens/page_header.dart';
import '../Util/bottom_bar.dart';
import '../Util/colors.dart';
import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
// import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:translator/translator.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'dart:convert' as convert;

import 'response.dart';

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
  //final text = 'الم الظهر والرأس ووجع في المعدة والبطن';

  @override
  void initState() {
    super.initState();
    tr();

    //  print(text);
    // print(response);
  }

  Future tr() async {
    //  'Internal clinic',
    //     'Oncology clinic',
    //     'Orthopedic clinic',
    //     'Respiratory clinic',
    //     'Urology clinic'
    String d = 'Urology clinic';
    dynamic f = await d.translate(from: 'en', to: 'ar');
    print(f.toString());
  }

  Future translate() async {
    dynamic text = await lastWords.translate(from: 'ar', to: 'en');
    String translatedText = text.toString();
    print(translatedText);
    var url = Uri.http('10.0.2.2:5000', '/');
    var response = await http.post(url,
        body: json.encode(
          {'result': translatedText},
        ),
        headers: {'Content-Type': "application/json; charset=utf-8"});

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      String clinic = jsonResponse['clinic'];
      dynamic clinicTrns = await clinic.translate(from: 'en', to: 'ar');
      // List c1 = [
      //   'Brain and nerves clinic',
      //   'Dermatology clinic',
      //   'Emergency',
      //   'Ear, nose and throat clinic',
      //   'Endocrinology clinic',
      //   'General clinic',
      //   'Heart, veins and arteries clinic',
      //   'Internal clinic',
      //   'Oncology clinic',
      //   'Orthopedic clinic',
      //   'Respiratory clinic',
      //   'Urology clinic'
      // ];
      // List trans = [];
      // c1.map((e) async {
      //   dynamic tr = await e.translate(from: 'en', to: 'ar');
      //   trans.add(tr.toString());
      //   print(tr.toString());
      // });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ClinicName(
                    clinic: clinicTrns.toString(),
                  )));
    }
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
            AvatarGlow(
              glowColor: Color(0xff21A7CC),
              endRadius: 140,
              duration: Duration(seconds: 2),
              repeat: true,
              showTwoGlows: true,
              curve: Curves.easeOutQuad,
              child: GestureDetector(
                child: GestureDetector(
                  onTap: () {
                    if (!_hasSpeech || speech.isListening) {
                      null;
                    } else {
                      startListening();
                      print(lastStatus);
                    }
                  },
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
    setState(() {});
  }

  void stopListening() {
    speech.stop();
    translate();
    setState(() {
      level = 0.0;
    });
    //Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      lastWords = "${result.recognizedWords}";
    });
    if (lastStatus == 'notListening') {
      translate();
    }
    print(lastStatus);
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
