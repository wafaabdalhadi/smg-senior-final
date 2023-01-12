import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../Util/destination.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Position _currentPosition;
  List<Destination> destinationlist = <Destination>[];

  @override
  void initState() {
    print('here');
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Location sorting from current location"),
        ),
        body: Container(
            child: destinationlist.length > 0
                ? ListView.builder(
                    itemCount: destinationlist.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.all(5),
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Container(
                            height: 40,
                            color: Colors.white,
                            child: Column(
                              children: [
                                Text("${destinationlist[index].name}"),
                                Text(
                                    "${destinationlist[index].distance.toStringAsFixed(2)} m"),
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                : Center(
                    child: CircularProgressIndicator(),
                  )));
  }

  _getCurrentLocation() {
    print('hell');
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
    print('jjnhjj');
    for (var d in destinations) {
      //var m = Geolocator.distanceBetween(position.latitude,position.longitude, d.lat,d.lng);
      double distanceInMeters = Geolocator.distanceBetween(
          position.latitude, position.longitude, d.lat, d.lng);
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
