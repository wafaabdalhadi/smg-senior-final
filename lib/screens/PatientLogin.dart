import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smg_senior/screens/welcome.dart';
import '../Util/RegistrerInfo.dart';

class PatientLogIn extends StatefulWidget {
  const PatientLogIn({Key? key}) : super(key: key);

  @override
  State<PatientLogIn> createState() => _PatientLogInState();
}

class _PatientLogInState extends State<PatientLogIn> {
  String phone = '';
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo.jpeg',
              width: 100,
              height: 100,
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0, bottom: 10, top: 20),
              child: Text(
                'تسجيل الدخول للمريض',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 25,
                  fontFamily: 'Lateef',
                ),
              ),
            ),
            Form(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        phone = value.toString();
                        print(phone);
                      },
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          prefixIcon: Icon(Icons.person_add_alt),
                          hintStyle: TextStyle(
                            color: Color(0xff21A7CC),
                            fontFamily: 'Lateef',
                            fontSize: 18,
                          ),
                          hintText: "رقم الهاتف",
                          fillColor: Colors.white),
                    ),
                  ),
                  RegisterInfo(
                      info: 'اسم المستخدم', icon: Icon(Icons.person_add_alt)),
                  SizedBox(
                    height: 10,
                  ),
                  RegisterInfo(info: 'كلمة المرور', icon: Icon(Icons.key)),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: null,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Color(0xff21A7CC),
                      margin:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: ListTile(
                        title: GestureDetector(
                          onTap: () async {
                            FirebaseAuth auth = FirebaseAuth.instance;
                            dynamic res =
                                await auth.signInWithPhoneNumber('+972'+phone);
                            print(res);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => Welcome()));
                          },
                          child: Text(
                            'إنشاء حساب',
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'Lateef',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: null,
                    child: Text(
                      'هل نسيت كلمة المرور؟',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontFamily: 'Lateef',
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
