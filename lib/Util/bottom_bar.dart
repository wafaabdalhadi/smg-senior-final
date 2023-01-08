import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/notfications.dart';
import '../screens/profile.dart';
import '../screens/recording_screen.dart';
import '../screens/reservations.dart';
import 'colors.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(

        width: MediaQuery.of(context).size.width/2,
        decoration: BoxDecoration(
            color: Colors.grey,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.blue,
                blurStyle: BlurStyle.outer,
              )
            ],
            borderRadius: BorderRadius.circular(25)
        ),
        child: BottomNavigationBar(
          iconSize: 30,
          selectedItemColor: KColor.mainBlueColor,
          selectedLabelStyle: TextStyle(
              color:KColor.mainBlueColor
          ),
          unselectedItemColor: KColor.lightBlueColor,
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          items:const [
            BottomNavigationBarItem(
                icon: Icon(Icons.person),label: 'الملف الشخصي'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),label: 'الاشعارات'),
            BottomNavigationBarItem(
                icon: Icon(Icons.record_voice_over_rounded),label: 'تسجيل صوت'),
            BottomNavigationBarItem(icon: Icon(Icons.bookmark_added),
                label: 'حجوزاتي'),
          ],
          onTap: (value) {
            switch(value){
              case 1:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
                break;
              case 2:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Notifications()));
                break;
              case 3:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyApp()));
                break;
              case 4:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Resevations()));
                break;
            }
          },
        ),
      ),
    );
    //   Container(
    //   padding: EdgeInsets.all(5),
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(20),
    //   ),
    //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Icon(Icons.person, size: 30,color: KColor.mainBlueColor,),
    //       Icon(Icons.notifications,size: 30,color: KColor.mainBlueColor,),
    //       Image(
    //           width: 35,
    //           image:AssetImage('images/logopng.png')),
    //       Icon(Icons.bookmark_added,size: 30,color: KColor.mainBlueColor,)
    //
    //     ],
    //   ),
    // );
  }
}