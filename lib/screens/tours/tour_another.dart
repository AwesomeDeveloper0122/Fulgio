import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:Fuligo/screens/video/audio.dart';
import 'package:Fuligo/utils/loading.dart';
import 'package:Fuligo/utils/localtext.dart';
import 'package:Fuligo/widgets/clear_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../utils/common_colors.dart';
import '../../widgets/circleimage.dart';
import '../../widgets/custom_button.dart';
import 'package:mapbox_api/mapbox_api.dart';
import 'package:http/http.dart' as http;

import '../../widgets/custom_image.dart';
import '../../widgets/subtxt.dart';
import '../video/video.dart';

class TourAnother extends StatefulWidget {
  TourAnother({Key? key}) : super(key: key);

  @override
  _TourAnotherState createState() => _TourAnotherState();
}

class _TourAnotherState extends State<TourAnother> {
  MapController mapController = MapController();
  LatLng currentUserPoistion =
      LatLng(38.9036614038578, -76.99211156195398); // call getcurrentposition

  final mapbox = MapboxApi(
    accessToken: LocalText.accessToken,
  );
  List<LatLng> points = [];
  List<Marker> markers = [];
  List pointdata = [];
  bool loading = true;
  List nameList = [];
  List flagList = [];
  List<Uint8List> imageList = [];
  List _tourdetail = [];
  List<Map> mediaList = [];
  double shortDistance = 0;
  LatLng nearestPosition = LatLng(0.00, 0.00);
  int index = 0;
  List partPoints = [];
  double lon1 = 0.00;
  double lon2 = 0.00;
  double lat1 = 0.00;
  double lat2 = 0.00;
  int remaining = 0;
  int stopCounts = 0;
  int passCounts = 0;

  final CollectionReference _tourCollection =
      FirebaseFirestore.instance.collection('cityGuide');

  final CollectionReference _pointCollection =
      FirebaseFirestore.instance.collection('pointOfInterest');
  FirebaseStorage storage = FirebaseStorage.instance;

  void initState() {
    super.initState();
    // getUserPosition();
    getPointInterest();
  }

  Future<void> drawPoint(lon1, lat1, lon2, lat2) async {
    print(lon1);
    print(lat1);
    print(lon2);
    print(lat2);

    // points.add(currentUserPoistion);
    // String request =
    //     "https://api.mapbox.com/directions/v5/mapbox/driving-traffic/47.467561,-110.046834;50.467561,11.046834?steps=true&geometries=geojson&access_token=pk.eyJ1Ijoic2FrdXJhMDEyMiIsImEiOiJja3pmNTFjam0yZ3M0Mm9tbTJ3bnFqbHc0In0.SbKkWu_yR23brbvErKLL9Q";
    // String request =
    //     "https://api.mapbox.com/directions/v5/mapbox/cycling/-82.662323,45.523751;-82.64394599688436,45.5334555889784?steps=true&geometries=geojson&access_token=pk.eyJ1Ijoic2FrdXJhMDEyMiIsImEiOiJja3pmNTFjam0yZ3M0Mm9tbTJ3bnFqbHc0In0.SbKkWu_yR23brbvErKLL9Q";
    // final response = await http.get(Uri.parse(
    //     'https://api.mapbox.com/directions/v5/mapbox/cycling/51.50743,0.12782;27.59072,76.61892?steps=true&geometries=geojson&access_token=pk.eyJ1Ijoic2FrdXJhMDEyMiIsImEiOiJja3pmNTFjam0yZ3M0Mm9tbTJ3bnFqbHc0In0.SbKkWu_yR23brbvErKLL9Q'));
    String request =
        "https://api.mapbox.com/directions/v5/mapbox/walking/${lon1},${lat1};${lon2},${lat2}?steps=true&geometries=geojson&access_token=pk.eyJ1Ijoic2FrdXJhMDEyMiIsImEiOiJja3pmNTFjam0yZ3M0Mm9tbTJ3bnFqbHc0In0.SbKkWu_yR23brbvErKLL9Q";
    final response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      double duration = data["routes"][0]["duration"];

      final eta = Duration(seconds: duration.toInt());
      remaining = eta.inMinutes;
      setState(() {
        remaining = remaining;
      });

      var coordinates = data["routes"][0]["geometry"]["coordinates"];
      print("coordinates");
      print(coordinates);

      for (var i = 0; i < coordinates.length; i++) {
        points.add(
          LatLng(
            coordinates[i][1],
            coordinates[i][0],
          ),
        );
      }
      setState(() {
        points = points;
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<void> getPointInterest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? parentID = prefs.getString('parentID');

    markers.add(
      Marker(
        point: currentUserPoistion,
        // point: _center,
        builder: (ctx) => const IconButton(
          icon: Icon(Icons.circle),
          iconSize: 50,
          color: Colors.white,
          onPressed: null,
          // color: Colors.red,
        ),
      ),
    );
    final prefs2 = await SharedPreferences.getInstance();
    String lang = prefs2.getString('lang') ?? "";
    int n = 0;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('cityGuide')
        .doc(parentID)
        .get();
    List pointOfInterests = snapshot["pointOfInterests"];
    print("pointOfInterests");
    print(pointOfInterests);

    if (pointOfInterests.isNotEmpty) {
      stopCounts = pointOfInterests.length;
      for (var j = 0; j < pointOfInterests.length; j++) {
        var refId = pointOfInterests[j];
        refId.get().then((DocumentSnapshot documentSnapshot) async {
          if (documentSnapshot.exists) {
            List videoUrl = [];
            try {
              videoUrl = documentSnapshot.get("video");
            } catch (e) {
              videoUrl = [];
            }

            if (videoUrl.isNotEmpty) {
              var sellocation = documentSnapshot.get('location');

              partPoints.add(sellocation); // location of PointofInterests

              var image_ist = documentSnapshot.get("image");
              String videoId = documentSnapshot.id;
              Reference ref = storage.ref().child(image_ist[0]);

              String url = await ref.getDownloadURL();
              Uint8List uint8image =
                  (await NetworkAssetBundle(Uri.parse(url)).load(""))
                      .buffer
                      .asUint8List();
              String description = documentSnapshot.get('description')["en_GB"];

              String name = documentSnapshot.get('name')["en_GB"];
              var location = documentSnapshot.get('location');

              imageList.add(uint8image);
              Map temp = {
                "description": description,
                "name": name,
                "image": url,
                "location": location,
                // "datetime": datetime,
              };
              _tourdetail.add(temp);
              markers.add(
                Marker(
                  width: 120.0,
                  height: 144.0,
                  point: LatLng(location["latitude"], location["longtitude"]),
                  builder: (ctx) =>
                      CircleVideoMapImage(context, videoId, uint8image),
                ),
              );
            } else {
              var sellocation = documentSnapshot.get('location');

              partPoints.add(sellocation); // location of PointofInterests

              var image_ist = documentSnapshot.get("image");
              String videoId = documentSnapshot.id;
              Reference ref = storage.ref().child(image_ist[0]);

              String url = await ref.getDownloadURL();
              Uint8List uint8image =
                  (await NetworkAssetBundle(Uri.parse(url)).load(""))
                      .buffer
                      .asUint8List();
              String description = documentSnapshot.get('description')["en_GB"];

              String name = documentSnapshot.get('name')["en_GB"];
              var location = documentSnapshot.get('location');

              imageList.add(uint8image);
              Map temp = {
                "description": description,
                "name": name,
                "image": url,
                "location": location,
                // "datetime": datetime,
              };
              _tourdetail.add(temp);
              markers.add(
                Marker(
                  width: 120.0,
                  height: 144.0,
                  point: LatLng(location["latitude"], location["longtitude"]),
                  builder: (ctx) =>
                      CircleAudioMapImage(context, videoId, uint8image),
                ),
              );
            }

            print("11111partPoints");
            print(partPoints);
            if (partPoints.length == pointOfInterests.length) {
              if (partPoints.length == 1) {
                drawPoint(
                    currentUserPoistion.longitude,
                    currentUserPoistion.latitude,
                    partPoints[0]["longtitude"],
                    partPoints[0]["latitude"]);
              } else {
                int lastindex = partPoints.length - 1;
                print("partPoints[lastindex]");
                print(partPoints[lastindex]);
                drawPoint(
                    partPoints[0]["longtitude"],
                    partPoints[0]["latitude"],
                    partPoints[lastindex]["longtitude"],
                    partPoints[lastindex]["latitude"]);
              }
            }

            n++;
            if (n == pointOfInterests.length) {
              setState(() {
                _tourdetail = _tourdetail;
                loading = false;
                imageList = imageList;
                partPoints = partPoints;
                stopCounts = stopCounts;
              });
            }
          }
        });
      }
    } else {
      loading = false;
      setState(() {});
    }
  }

  Future<String> getUrlFromFirebase(String firebaseURL) async {
    Reference ref = FirebaseStorage.instance.ref().child(firebaseURL);
    String url = await ref.getDownloadURL();

    return url;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pointwidgets = [];

    if (_tourdetail.isNotEmpty) {
      for (var i = 0; i < _tourdetail.length; i++) {
        var item = _tourdetail[i];

        _pointwidgets.add(
          TourSmallImage(context, imageList[i], "Stop ${i + 1}", item["name"]),
        );
      }
    }

    var mq = MediaQuery.of(context).size;

    return Scaffold(
      body: !loading
          ? Stack(alignment: Alignment.center, children: <Widget>[
              FlutterMap(
                options: MapOptions(
                  center: LatLng(partPoints[0]["longtitude"],
                      partPoints[0]["latitude"]), // current user postion
                  minZoom: 13.0,

                  bounds: LatLngBounds(
                    LatLng(partPoints[0]["latitude"] - 1,
                        partPoints[0]["longtitude"] - 1), // [west,south]
                    LatLng(partPoints[0]["latitude"] + 1,
                        partPoints[0]["longtitude"] + 1),
                  ), // [east,north]
                  boundsOptions:
                      const FitBoundsOptions(padding: EdgeInsets.all(8.0)),
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate: LocalText.styleWithBackground,
                    // urlTemplate:
                    //     'https://api.mapbox.com/styles/v1/sakura0122/cl0asbsbv000314menn31lgqa/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic2FrdXJhMDEyMiIsImEiOiJja3pmNTFjam0yZ3M0Mm9tbTJ3bnFqbHc0In0.SbKkWu_yR23brbvErKLL9Q',
                    additionalOptions: {
                      'accessToken': LocalText.accessToken,
                    },
                  ),
                  MarkerLayerOptions(
                      markers: markers, rotateAlignment: Alignment.center),
                  PolylineLayerOptions(polylineCulling: false, polylines: [
                    Polyline(
                        isDotted: true,
                        points: points,
                        strokeWidth: 8.0,
                        color: Colors.white)
                  ])
                ],
                mapController: mapController,
              ),
              SecondaryButton(context),
              Positioned(
                bottom: 30,
                left: 20,
                child: SizedBox(
                  height: 140,
                  width: mq.width,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: _pointwidgets,
                  ),
                ),
              ),
              Container(
                  width: mq.width,
                  height: mq.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 60, 20, 0),
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: SubTxt(context, 'Remaining',
                                  '${remaining.toString()} min'),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: SubTxt(context, 'Stops',
                                  '${passCounts} / ${stopCounts}'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ])
          : defaultloading(context),
    );
  }
}
