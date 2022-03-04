// ignore_for_file: unused_element

import 'package:Fuligo/routes/route_costant.dart';
import 'package:Fuligo/utils/localtext.dart';
import 'package:Fuligo/widgets/logo.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/widgets/text_header.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';

import 'package:location/location.dart';

class Verify extends StatefulWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  VerifyState createState() => VerifyState();
}

class VerifyState extends State<Verify> {
  LatLng _center = LatLng(51.5074, 0.1278);
  MapController _mapController = MapController();
  List<Marker> markers = [];
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() async {
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
    print("current user locatiom");
    print(_locationData);

    setState(() {
      _center = LatLng(_locationData.latitude!, _locationData.longitude!);
    });
  }

  addPin(LatLng latlng) {
    setState(() {
      markers.add(Marker(
        width: 30.0,
        height: 30.0,
        point: latlng,
        builder: (ctx) => IconButton(
          icon: Icon(Icons.circle),
          iconSize: 30,
          color: Colors.blue,
          onPressed: null,
          // color: Colors.red,
        ),
      ));
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
                                    // onLongPress: this.addPin(latlng),
                                    center: _center,
                                    zoom: 16.0,
                                  ),
                                  layers: [
                                    TileLayerOptions(
                                      urlTemplate: LocalText.urlTemplate,
                                      additionalOptions: {
                                        'accessToken': LocalText.accessToken,
                                      },
                                    ),
                                    MarkerLayerOptions(
                                      markers: [
                                        Marker(
                                          width: 20.0,
                                          height: 20.0,
                                          point: LatLng(51.5074, 0.1278),
                                          // point: _center,
                                          builder: (ctx) => const IconButton(
                                            icon: Icon(Icons.circle),
                                            iconSize: 30,
                                            color: Colors.blue,
                                            onPressed: null,
                                            // color: Colors.red,
                                          ),
                                        ),
                                        // Marker(
                                        //   width: 20.0,
                                        //   height: 20.0,
                                        //   point: LatLng(48.5074, 0.1278),
                                        //   builder: (ctx) => Container(
                                        //     child: IconButton(
                                        //       icon: Icon(Icons.location_on),
                                        //       onPressed: null,
                                        //       color: Colors.red,
                                        //     ),
                                        //   ),
                                        // ),
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
