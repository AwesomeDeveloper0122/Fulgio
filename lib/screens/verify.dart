// ignore_for_file: unused_element

import 'dart:math';

import 'package:Fuligo/routes/route_costant.dart';
import 'package:Fuligo/screens/achievement/success.dart';
import 'package:Fuligo/screens/configuration/location.dart';
import 'package:Fuligo/screens/tours/start_tour.dart';
import 'package:Fuligo/utils/localtext.dart';
import 'package:Fuligo/widgets/logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/widgets/text_header.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

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
  bool permission = false;
  bool emailVerified = false;
  @override
  void initState() {
    super.initState();
    getUserPosition();
  }

  Future<void> getUserPosition() async {
    print("123123123");
    User? fire_user = FirebaseAuth.instance.currentUser;
    print("fire_user");
    print(fire_user);

    if (fire_user != null && !fire_user.emailVerified) {
      await fire_user.sendEmailVerification();
    }

    emailVerified = fire_user!.emailVerified;

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
      print("denied");

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
                            builder: (context) => LocationScreen()),
                      );
                    },
                    child: Container(
                      height: mapHeight.height,
                      width: mq.width * 0.6,
                      child: Text(""),
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
