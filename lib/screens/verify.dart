// ignore_for_file: unused_element

import 'package:Fuligo/routes/route_costant.dart';
import 'package:Fuligo/screens/tours/start_tour.dart';
import 'package:Fuligo/utils/localtext.dart';
import 'package:Fuligo/widgets/logo.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/widgets/text_header.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';

import 'package:location/location.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

class Verify extends StatefulWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  VerifyState createState() => VerifyState();
}

class VerifyState extends State<Verify> {
  LatLng currentUserPoistion = LatLng(38.9036614038578, -76.99211156195398);
  List<Marker> markers = [];
  @override
  void initState() {
    super.initState();
    getUserPosition();
  }

  Future<void> getUserPosition() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    setState(() {
      currentUserPoistion =
          LatLng(_locationData.latitude!, _locationData.longitude!);
    });
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    var mapHeight = mq * 0.5;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/discover.png"),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  Logo,
                  PageHeader(context, "Verify",
                      "Great! Please verify your e-mail start"),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StartTour(
                                currentUserPosition: currentUserPoistion)),
                      );
                    },
                    child: Container(
                      height: mapHeight.height,
                      width: mq.width * 0.6,
                      margin: const EdgeInsets.only(top: 15),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.only(top: 15),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "Allow to use your \n location? ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: const Text(
                                        "Turning on location services allows us \n to show you whe pals are nearby..",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: FlutterMap(
                                  options: MapOptions(
                                    center: currentUserPoistion,
                                    zoom: 16.0,
                                  ),
                                  layers: [
                                    TileLayerOptions(
                                      urlTemplate:
                                          'https://api.mapbox.com/styles/v1/sakura0122/cl0asbsbv000314menn31lgqa/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic2FrdXJhMDEyMiIsImEiOiJja3pmNTFjam0yZ3M0Mm9tbTJ3bnFqbHc0In0.SbKkWu_yR23brbvErKLL9Q',
                                      additionalOptions: {
                                        'accessToken': LocalText.accessToken,
                                      },
                                    ),
                                    MarkerLayerOptions(
                                      markers: [
                                        Marker(
                                          point: currentUserPoistion,
                                          builder: (ctx) => IconButton(
                                            icon: Icon(Icons.person_pin_circle),
                                            iconSize: 40,
                                            color: Color.fromARGB(
                                                255, 243, 33, 33),
                                            onPressed: null,
                                            // color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
