import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


import '../Util/destination.dart';


class Home extends StatefulWidget {
  Home({required this.clinic});
  late String clinic;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Position _currentPosition;
  List<Destination> destinationlist = <Destination>[];

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
return Material(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('Clinics')
            .where('Clinic type', isEqualTo: widget.clinic)
            .snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasError) return Text('Error = ${snapshot.error}');
          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: destinationlist.length,
              itemBuilder: (_, i) {
                final data = docs[i].data();
                Destination destination = Destination(
                    data['lat'], data['lag'], data['Clinic name'],
                    distance: 0);
                destinations.add(destination);
                print(destination);
                //  if (data['Clinic type'] == widget.clinic) {
                return Card(
                    margin: EdgeInsets.all(5),
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        height: 40,
                        color:Colors.white,
                        child: Column(
                          children: [
                            Text(destinationlist[i].name),
                            Text("${destinationlist[i].distance.toStringAsFixed(2)} m"),
                          ],
                        ),
                      ),
                    ),
                  );
                // } else {
                //   return Text('');
                // }
              },
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );

    // return Scaffold(
    //     appBar: AppBar(
    //       title: Text("Location sorting from current location"),
    //     ),
    //     body: Container(
    //         child: destinationlist.length>0?
    //         ListView.builder(
    //             itemCount: destinationlist.length,
    //             itemBuilder: (context, index){
    //               return Card(
    //                 margin: EdgeInsets.all(5),
    //                 elevation: 5,
    //                 child: Padding(
    //                   padding: EdgeInsets.all(5),
    //                   child: Container(
    //                     height: 40,
    //                     color:Colors.white,
    //                     child: Column(
    //                       children: [
    //                         Text("${destinationlist[index].name}"),
    //                         Text("${destinationlist[index].distance.toStringAsFixed(2)} m"),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               );
    //             }
    //         ):
    //         Center(child: CircularProgressIndicator(),)
    //     )
    // );
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true)
        .then((Position position) {
      distanceCalculation(position);
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  distanceCalculation(Position position) {
    for(var d in destinations){
      //var m = Geolocator.distanceBetween(position.latitude,position.longitude, d.lat,d.lng);
      double distanceInMeters = Geolocator.distanceBetween(position.latitude, position.longitude, d.lat,d.lng);

      d.distance = distanceInMeters;
      destinationlist.add(d);
    }
    setState(() {
      destinationlist.sort((a, b) {
        return a.distance.compareTo(b.distance);
      });
    });
  }
}