import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 30),
          children: const [
            Text(
              'مواعيد اليوم',
              style: TextStyle(
                  color: Color.fromARGB(255, 17, 132, 219), fontSize: 22),
            ),
            AppointmentCard(
                'حجز رقم 1',
                "10/9/2021, 11:00 AM",
                'عيادة د. محمد جابر',
                'مراجعة'
            ),

            AppointmentCard(
                'حجز رقم 1',
                "10/9/2021, 11:00 AM",
                'عيادة د. محمد جابر',
                'مراجعة'
            ),
            AppointmentCard(
                'حجز رقم 1',
                "10/9/2021, 11:00 AM",
                'عيادة د. محمد جابر',
                'مراجعة'
            ),
            AppointmentCard(
                'حجز رقم 1',
                "10/9/2021, 11:00 AM",
                'عيادة د. محمد جابر',
                'مراجعة'
            ),
            AppointmentCard(
                'حجز رقم 1',
                "10/9/2021, 11:00 AM",
                'عيادة د. محمد جابر',
                'مراجعة'
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  const AppointmentCard(this.appointmentNum, this.appointmentDate,
      this.clinicName, this.visitType);
  final String appointmentNum;
  final String appointmentDate;
  final String clinicName;
  final String visitType;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color.fromARGB(222, 35, 35, 35),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              appointmentNum,
              style: TextStyle(color: Color(0xffffffff)),
            ),
            Text(
              appointmentDate,
              style: TextStyle(color: Color(0xffffffff)),
            ),
            Text(
              clinicName,
              style: TextStyle(color: Color(0xffffffff)),
            ),
            Text(visitType,
                style: TextStyle(color: Color(0xffffffff)))

          ],
        ));
  }
}
