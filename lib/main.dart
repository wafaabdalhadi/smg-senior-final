import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smg_senior/OTPCode/SignUpPage.dart';
import 'package:smg_senior/OTPCode/mainOTP.dart';
import 'package:smg_senior/screens/DoctorRegister.dart';
import 'package:smg_senior/screens/DoctorRegisterNextStep.dart';
import 'package:smg_senior/screens/PatientLogin.dart';
import 'package:smg_senior/screens/intro_screen.dart';
import 'package:smg_senior/screens/location.dart';
import 'package:smg_senior/screens/recording_screen.dart';
import 'package:smg_senior/screens/response.dart';
import 'package:smg_senior/screens/welcome.dart';

import 'Util/var.dart';
import 'screens/RegisterLogin.dart';
import 'screens/profile.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    navigatorKey: navigatorKey,
    debugShowCheckedModeBanner: false,
    home: Welcome(),
  ));
}

class MainHome extends StatelessWidget {
  MainHome({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic user = FirebaseAuth.instance.currentUser;

    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Something went wrong!'),
          );
        } else if (snapshot.hasData) {
          return DoctorRegisterNextStep();
        }
        return RegisterLogin();
      },
    );
  }
}
