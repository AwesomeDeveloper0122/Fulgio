// ignore_for_file: unused_element

import 'dart:async';

import 'package:Fuligo/model/user_model.dart';
import 'package:Fuligo/provider/auth_provider.dart';
import 'package:Fuligo/screens/tours/start_tour.dart';
import 'package:Fuligo/utils/loading.dart';
import 'package:Fuligo/utils/localtext.dart';
import 'package:Fuligo/widgets/logo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/widgets/text_header.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';

import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class VerifyTracking extends StatefulWidget {
  String permission;
  VerifyTracking({Key? key, required this.permission}) : super(key: key);

  @override
  VerifyTrackingState createState() => VerifyTrackingState();
}

class VerifyTrackingState extends State<VerifyTracking> {
  LatLng currentUserPoistion = LatLng(38.9036614038578, -76.99211156195398);
  List<Marker> markers = [];
  bool permission = false;
  bool emailVerified = false;
  String page = "Verify";
  Map headerData = {};

  late Timer timer;
  User? user;
  bool loading = true;
  bool isUserEmailVerified = false;

  @override
  void initState() {
    super.initState();
    getHeader();
    getUserPosition();
    User? fireUser = FirebaseAuth.instance.currentUser;
    fireUser?.sendEmailVerification();
    timer = Timer.periodic(
      const Duration(
        seconds: 5,
      ),
      (timer) {
        checkEmailVerified();
      },
    );
  }

  Future<void> getHeader() async {
    FirebaseFirestore.instance
        .collection('header')
        .doc("od9KyauEGUn5PYycMKS6")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        print(documentSnapshot[page]);
        headerData = documentSnapshot[page];
        print(headerData);
        setState(() {
          headerData = headerData;
          loading = false;
        });
      }
    });
  }

  Future<void> checkEmailVerified() async {
    User? fireUser = FirebaseAuth.instance.currentUser;

    await fireUser?.reload();
    print("fireUser!.emailVerified");
    print(fireUser!.emailVerified);
    final signedInUser = fireUser;
    if (signedInUser != null && signedInUser.emailVerified) {
      timer.cancel();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StartTour(),
        ),
      );
    }
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
    } else {
      permission = true;
    }

    _locationData = await location.getLocation();

    setState(() {
      currentUserPoistion =
          LatLng(_locationData.latitude!, _locationData.longitude!);
      emailVerified = emailVerified;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel userInfo = AuthProvider.of(context).userModel;
    print("lang");
    print(userInfo.uid);
    print("isUserEmailVerified");
    print(isUserEmailVerified);

    String lang = userInfo.app_lang.toString();
    var mq = MediaQuery.of(context).size;
    var mapHeight = mq * 0.5;
    return !loading
        ? Container(
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
                      PageHeader(context, headerData["title"][lang].toString(),
                          headerData["subtitle"][lang].toString()),
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StartTour(),
                            ),
                          ),
                        },
                        child: !permission
                            ? Container(
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
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25.0),
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            child: Column(
                                              children: [
                                                Text(
                                                  LocalText.allow_title[lang]
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: Text(
                                                    LocalText
                                                        .allow_description[lang]
                                                        .toString(),
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
                                                    'accessToken':
                                                        LocalText.accessToken,
                                                  },
                                                ),
                                                MarkerLayerOptions(
                                                  markers: [
                                                    Marker(
                                                      point:
                                                          currentUserPoistion,
                                                      builder: (ctx) =>
                                                          IconButton(
                                                        icon: Icon(Icons
                                                            .person_pin_circle),
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
                            : Text(""),
                      )
                    ],
                  ))
                ],
              ),
            ),
          )
        : defaultloading(context);
  }
}
