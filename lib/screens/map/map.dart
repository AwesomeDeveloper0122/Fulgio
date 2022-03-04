import 'dart:typed_data';

import 'package:Fuligo/utils/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import '../../utils/common_colors.dart';
import '../../widgets/circleimage.dart';
import '../../widgets/custom_button.dart';
import '../tours/tours.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController mapController = MapController();
  var points = [
    LatLng(51.5074, 0.1278),
    LatLng(54.5074, 0.1278),
    LatLng(27.591585, 76.61139),
    LatLng(27.591548, 76.611397),
    LatLng(27.591473, 76.611407),
    // LatLng(27.591437, 76.611413),
    // LatLng(27.591362, 76.611425),
    // LatLng(27.591325, 76.61143),
    // LatLng(27.59125, 76.611442),
    // LatLng(27.591177, 76.611452),
    // LatLng(27.59114, 76.611458),
    // LatLng(27.591065, 76.61147),
    // LatLng(27.591028, 76.611475),
    // LatLng(27.591007, 76.611587),
    // LatLng(27.591013, 76.611693),
    // LatLng(27.590777, 76.611805),
    // LatLng(27.590657, 76.611822),
    // LatLng(27.590535, 76.61184),
    // LatLng(27.590413, 76.611857),
    // LatLng(27.590293, 76.611875),
    // LatLng(27.590172, 76.611892)
  ];
  // UserLocationOptions userLocationOptions;
  List<Marker> markers = [
    Marker(
      width: 20.0,
      height: 20.0,
      point: LatLng(51.5074, 0.1278),
      // point: _center,
      builder: (ctx) => const IconButton(
        icon: Icon(Icons.circle),
        iconSize: 40,
        color: Colors.white,
        onPressed: null,
        // color: Colors.red,
      ),
    ),
  ];
  late LatLng _center;
  List pointdata = [];
  bool loading = true;
  List imageNetList = [];
  List<Uint8List> imageList = [];

  final CollectionReference _pointCollection =
      FirebaseFirestore.instance.collection('pointOfInterest');

  void initState() {
    super.initState();
    getPointData();
    // getCurrentLocation();
  }

  void drawRoute() {}

  Future<List> getPointData() async {
    QuerySnapshot querySnapshot = await _pointCollection.get();
    List videoUrl = [];
    List imageUrlList = [];
    List idList = [];
    int n = 0;
    Map location = {};
    String imgUrl = "";

    if (querySnapshot.docs.isNotEmpty) {
      print("important");
      for (var i = 0; i < querySnapshot.docs.length; i++) {
        var ele = querySnapshot.docs[i];

        try {
          videoUrl = ele.get("video");
        } catch (e) {
          videoUrl = [];
        }

        if (videoUrl.isNotEmpty) {
          imageUrlList = ele.get("image");
          location = ele.get('location');
          if (imageUrlList.isNotEmpty) {
            String videoId = ele.id;
            String videoimgurl =
                await getUrlFromFirebase(imageUrlList[0].toString());
            Uint8List uint8image =
                (await NetworkAssetBundle(Uri.parse(videoimgurl)).load(""))
                    .buffer
                    .asUint8List();
            imageList.add(uint8image);
            markers.add(
              Marker(
                width: 120.0,
                height: 144.0,
                point: LatLng(location["latitude"], location["longtitude"]),
                builder: (ctx) =>
                    CircleVideoMapImage(context, videoId, uint8image),
              ),
            );
            n++;
          }

          // pointdata.add({"id": id, "location": location, "flag": "video"});
        } else {
          imageUrlList = ele.get("image");
          location = ele.get('location');
          String audioId = ele.id;
          if (imageUrlList.isNotEmpty) {
            String audioimgUrl = await getUrlFromFirebase(imageUrlList[0]);

            Uint8List uint8image =
                (await NetworkAssetBundle(Uri.parse(audioimgUrl)).load(""))
                    .buffer
                    .asUint8List();
            imageList.add(uint8image);
            markers.add(
              Marker(
                width: 120.0,
                height: 144.0,
                point: LatLng(location["latitude"], location["longtitude"]),
                builder: (ctx) =>
                    CircleAudioMapImage(context, audioId, uint8image),
              ),
            );
            n++;
          }

          // pointdata.add({"id": id, "location": location, "flag": "audio"});
        }
      }
      print(n);
      if (n == querySnapshot.docs.length) {
        print("123");
        setState(() {
          pointdata = pointdata;
          markers = markers;
          loading = false;
          imageList = imageList;
        });
      }
    } else {
      setState(() {
        loading = false;
        markers = markers;
      });
    }

    return pointdata;
  }

  Future<String> getUrlFromFirebase(String firebaseURL) async {
    Reference ref = FirebaseStorage.instance.ref().child(firebaseURL);
    String url = await ref.getDownloadURL();

    return url;
  }

  getCurrentLocation() async {
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
      _center = LatLng(_locationData.latitude!, _locationData.longitude!);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("markers");
    print(markers);
    return Scaffold(
      body: !loading
          ? Stack(alignment: Alignment.center, children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [gradientFrom, bgColor]),
                    color: bgColor.withOpacity(0.5)),
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(51.5074, 0.1278),
                    zoom: 3.0,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          'https://api.mapbox.com/styles/v1/sakura0122/cl0asbsbv000314menn31lgqa/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic2FrdXJhMDEyMiIsImEiOiJja3pmNTFjam0yZ3M0Mm9tbTJ3bnFqbHc0In0.SbKkWu_yR23brbvErKLL9Q',
                      additionalOptions: {
                        'accessToken':
                            'pk.eyJ1Ijoic2FrdXJhMDEyMiIsImEiOiJja3pmNTFjam0yZ3M0Mm9tbTJ3bnFqbHc0In0.SbKkWu_yR23brbvErKLL9Q',
                      },
                    ),
                    MarkerLayerOptions(markers: markers),
                    PolylineLayerOptions(polylineCulling: false, polylines: [
                      Polyline(
                          points: points, strokeWidth: 10.0, color: Colors.red)
                    ])
                  ],
                  mapController: mapController,
                ),
              ),
              MenuButton(context),
              PrimaryButton(context, const Tours(), "Start tour")
            ])
          : defaultloading(context),
    );
  }
}
