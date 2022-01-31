// ignore_for_file: unused_element

import 'package:Fuligo/widgets/map_button.dart';
import 'package:flutter/material.dart';
// import 'package:Fuligo/utils/common_colors.dart';
//Screens

//Widgets
import 'package:Fuligo/widgets/button.dart';
import 'package:Fuligo/widgets/text_header.dart';
import 'package:Fuligo/screens/start_tour.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Verify extends StatefulWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  VerifyState createState() => VerifyState();
}

class VerifyState extends State<Verify> {
  late GoogleMapController myController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    myController = controller;
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
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
            children: <Widget>[
              TextHeader(
                context,
                "Verify",
                "Great! Please verify your e-mail start",
              ),
              Center(
                child: Container(
                  height: 400.0,
                  width: 230.0,
                  margin: const EdgeInsets.only(top: 120),
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
                          const Text(
                            "Allow to use your ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const Text(
                            "location?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 6),
                            child: const Text(
                              "Turning on location services allows us",
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 6),
                            child: const Text(
                              "to show you whe pals are nearby..",
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 200,
                            child: GoogleMap(
                                onMapCreated: _onMapCreated,
                                initialCameraPosition: CameraPosition(
                                  target: _center,
                                  zoom: 10.0,
                                ),
                                mapType: _currentMapType),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(14.0),
                          //   child: Align(
                          //     alignment: Alignment.topRight,
                          //     child: FloatingActionButton(
                          //       onPressed: _onMapTypeButtonPressed,
                          //       materialTapTargetSize:
                          //           MaterialTapTargetSize.padded,
                          //       backgroundColor: Colors.green,
                          //       child: const Icon(Icons.map, size: 30.0),
                          //     ),
                          //   ),
                          // ),
                          Column(
                            children: [
                              MapButton(context, "Allow once"),
                              MapButton(context, "Allow while using app"),
                              MapButton(context, "Don't allow"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
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
