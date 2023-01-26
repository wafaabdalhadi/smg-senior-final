import 'package:flutter/material.dart';
import 'package:smg_senior/screens/DoctorLogIn.dart';
import 'package:smg_senior/screens/PatientLogin.dart';
import 'package:smg_senior/screens/RegisterForPatient.dart';
import 'package:smg_senior/screens/SecretaryLogIn.dart';
import 'package:smg_senior/screens/SecretaryRegistration.dart';

import '../Util/User.dart';
import '../Util/var.dart';

class RegisterLogin extends StatefulWidget {
  const RegisterLogin({Key? key}) : super(key: key);

  @override
  State<RegisterLogin> createState() => _RegisterLoginState();
}

class _RegisterLoginState extends State<RegisterLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 25, bottom: 5),
            child: Image.asset(
              'images/logo.jpeg',
              width: 130,
              height: 130,
            ),
          ),
          Text(
            'التوجيه الطبي الذكي',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff21A7CC),
              fontSize: 30,
              fontFamily: 'Lateef',
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 25.0),
                  child: Text(
                    ' تسجيل الدخول كــ',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Color(0xff21A7CC),
                      fontSize: 25,
                      fontFamily: 'Lateef',
                    ),
                  ),
                ),
                User(
                  user: 'مريض',
                  ontap: () {
                    setState(() {
                      displayName = "patient";
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PatientLogIn()));
                  },
                ),
                User(
                    user: 'طبيب',
                    ontap: () {
                      setState(() {
                        displayName = "doctor";
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DoctorLogIn()));
                    }),
                User(
                    user: 'سكرتير',
                    ontap: () {
                      setState(() {
                      displayName = "secretary";
                    });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecretaryLogIn()));
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//
// class User extends StatelessWidget {
//   User({super.key, required this.user});
//   final user;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: null,
//       child: Card( shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(30.0),
//       ),
//         color: Color(0xff21A7CC),
//         margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
//         child: ListTile(
//           title: Text(
//             user,
//             textAlign: TextAlign.center,
//             textDirection: TextDirection.rtl,
//             style: TextStyle(
//               color:  Colors.white,
//               fontSize: 25,
//               fontFamily: 'Lateef',
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
