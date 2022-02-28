// ignore_for_file: unused_element

import 'package:Fuligo/routes/route_costant.dart';
import 'package:Fuligo/widgets/logo.dart';
import 'package:Fuligo/widgets/map_button.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/widgets/text_header.dart';

class Verify extends StatefulWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  VerifyState createState() => VerifyState();
}

class VerifyState extends State<Verify> {
// late Position _currentPosition;

// LatLng? _mylocation;

  void initState() {
    super.initState();
    // _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    var map_height = mq * 0.5;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/discover.png"),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          // appBar: AppBar(
          //   title: Text('TEST'),
          // ),
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
                        Navigator.pushNamed(context, RouteName.Startour);
                      },
                      child: Container(
                        height: map_height.height,
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
                                Flexible(
                                  child: Container(
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
                                ),
                                // MapScreen(),
                                // Flexible(
                                //   child: SizedBox(
                                //     height: map_height.height * 0.48,
                                //     child: GoogleMap(
                                //       onMapCreated: _onMapCreated,
                                //       initialCameraPosition: CameraPosition(
                                //         target: _center,
                                //         zoom: 10.0,
                                //       ),
                                //       mapType: _currentMapType,
                                //       myLocationEnabled: true,
                                //       myLocationButtonEnabled: true,
                                //     ),
                                //   ),
                                // ),
                                // Flexible(
                                //   child: Container(
                                //     child: Column(
                                //       children: [
                                //         MapButton(context, "Allow once"),
                                //         MapButton(
                                //             context, "Allow while using app"),
                                //         MapButton(context, "Don't allow"),
                                //       ],
                                //     ),
                                //   ),
                                // )
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
          )),
    );
  }
}
