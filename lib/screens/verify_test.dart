// ignore_for_file: unused_element

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/logo.dart';
import 'package:Fuligo/widgets/map_button.dart';
import 'package:flutter/material.dart';
// import 'package:Fuligo/utils/common_colors.dart';
//Screens

//Widgets
import 'package:Fuligo/widgets/custom_button.dart';
import 'package:Fuligo/widgets/text_header.dart';
import 'package:Fuligo/screens/tours/start_tour.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VerifyTest extends StatefulWidget {
  const VerifyTest({Key? key}) : super(key: key);

  @override
  VerifyTestState createState() => VerifyTestState();
}

class VerifyTestState extends State<VerifyTest> {
  // late Position _currentPosition;

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
                    Logo_test,
                    TextHeaderTest(context, "VerifyTest",
                        "Great! Please VerifyTest your e-mail start"),
                    Container(
                      height: map_height.height,
                      width: 280.0,
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
                          height: mq.height,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: map_height.height * 0.22,
                                child: Column(
                                  children: [
                                    Text(
                                      "Verify Test",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      child: const Text(
                                        "Turning on location services allows us \n to show you whe pals are nearby..",
                                        style: TextStyle(
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: map_height.height * 0.48,
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    MapButton(context, "Allow once"),
                                    MapButton(context, "Allow while using app"),
                                    MapButton(context, "Don't allow"),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Center(
              //   child: Container(
              //     height: 400.0,
              //     width: 230.0,
              //     margin: const EdgeInsets.only(top: 120),
              //     decoration: const BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.all(
              //         Radius.circular(25.0),
              //       ),
              //     ),
              //     child: Center(
              //       child: Container(
              //         padding: const EdgeInsets.only(top: 15),
              //         child: Column(
              //           children: <Widget>[
              //             const Text(
              //               "Allow to use your ",
              //               style: TextStyle(
              //                   fontWeight: FontWeight.bold, fontSize: 18),
              //             ),
              //             const Text(
              //               "location?",
              //               style: TextStyle(
              //                   fontWeight: FontWeight.bold, fontSize: 18),
              //             ),
              //             Container(
              //               margin: const EdgeInsets.only(top: 6),
              //               child: const Text(
              //                 "Turning on location services allows us",
              //                 style: TextStyle(
              //                   fontSize: 11,
              //                 ),
              //               ),
              //             ),
              //             Container(
              //               margin: const EdgeInsets.only(bottom: 6),
              //               child: const Text(
              //                 "to show you whe pals are nearby..",
              //                 style: TextStyle(
              //                   fontSize: 11,
              //                 ),
              //               ),
              //             ),
              //             SizedBox(
              //               height: 200,
              //               child: GoogleMap(
              //                   onMapCreated: _onMapCreated,
              //                   initialCameraPosition: CameraPosition(
              //                     target: _center,
              //                     zoom: 10.0,
              //                   ),
              //                   mapType: _currentMapType),
              //             ),
              //             // Padding(
              //             //   padding: const EdgeInsets.all(14.0),
              //             //   child: Align(
              //             //     alignment: Alignment.topRight,
              //             //     child: FloatingActionButton(
              //             //       onPressed: _onMapTypeButtonPressed,
              //             //       materialTapTargetSize:
              //             //           MaterialTapTargetSize.padded,
              //             //       backgroundColor: Colors.green,
              //             //       child: const Icon(Icons.map, size: 30.0),
              //             //     ),
              //             //   ),
              //             // ),
              //             Column(
              //               children: [
              //                 MapButton(context, "Allow once"),
              //                 MapButton(context, "Allow while using app"),
              //                 MapButton(context, "Don't allow"),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
// "Start tour" button
              // Positioned(
              //   bottom: 30,
              //   child: SizedBox(
              //     width: mq.width,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Container(
              //           child: CustomButton(
              //               context, const StartTour(), "Start tour"),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          )),
    );
  }
}