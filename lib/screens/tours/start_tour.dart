import 'dart:typed_data';

import 'package:Fuligo/utils/loading.dart';
import 'package:Fuligo/utils/localtext.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../utils/common_colors.dart';
import '../../widgets/circleimage.dart';
import '../../widgets/custom_button.dart';
import '../tours/tours.dart';
import 'package:mapbox_api/mapbox_api.dart';

import '../video/audio.dart';
import '../video/video.dart';

// ignore: must_be_immutable
class StartTour extends StatefulWidget {
  LatLng currentUserPosition;
  StartTour({Key? key, required this.currentUserPosition}) : super(key: key);

  @override
  _StartTourState createState() => _StartTourState();
}

class _StartTourState extends State<StartTour> {
  MapController mapController = MapController();
  final mapbox = MapboxApi(
    accessToken: LocalText.accessToken,
  );

  List pointdata = [];
  bool loading = true;
  List imageNetList = [];
  List<Uint8List> imageList = [];
  List<Marker> markers = [];

  final CollectionReference _pointCollection =
      FirebaseFirestore.instance.collection('pointOfInterest');

  @override
  void initState() {
    super.initState();
    getPointData();
  }

  Future<List> getPointData() async {
    markers.add(Marker(
      point: widget.currentUserPosition, //current user poistion
      builder: (ctx) => const IconButton(
        icon: Icon(Icons.circle),
        iconSize: 50,
        color: Colors.red,
        onPressed: null,
        // color: Colors.red,
      ),
    )
        // builder: (ctx) =>
        //     Image(image: AssetImage("assets/images/png/icon-heart.png"))),
        );
    QuerySnapshot querySnapshot = await _pointCollection.get();
    List videoUrl = [];
    List imageUrlList = [];
    int n = 0;
    Map location = {};

    if (querySnapshot.docs.isNotEmpty) {
      for (var i = 0; i < querySnapshot.docs.length; i++) {
        var ele = querySnapshot.docs[i];

        try {
          videoUrl = ele.get("video");
        } catch (e) {
          videoUrl = [];
        }

        imageUrlList = ele.get("app_image");

        location = ele.get('location');
        String id = ele.id;

        if (videoUrl.isNotEmpty) {
          if (imageUrlList.isNotEmpty) {
            markers.add(
              Marker(
                width: 120.0,
                height: 144.0,
                point: LatLng(location["latitude"], location["longitude"]),
                builder: (ctx) => Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Video(
                            id: id,
                          ),
                        ),
                      );
                    },
                    child: ClipOval(
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: imageUrlList[0],
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            );
            n++;
          }
        } else {
          if (imageUrlList.isNotEmpty) {
            markers.add(
              Marker(
                width: 120,
                height: 120,
                point: LatLng(location["latitude"], location["longitude"]),
                builder: (ctx) => Container(
                  // margin:
                  //     const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      print("audio");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Audio(id: id),
                        ),
                      );
                    },
                    child: ClipOval(
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: imageUrlList[0],
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            );
            n++;
          }
        }
      }

      if (n == querySnapshot.docs.length) {
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

  @override
  Widget build(BuildContext context) {
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
                    center: widget.currentUserPosition, // current user postion
                    minZoom: 10.0,
                    bounds: LatLngBounds(
                      LatLng(
                          widget.currentUserPosition.latitude - 1,
                          widget.currentUserPosition.longitude -
                              1), // [west,south]
                      LatLng(widget.currentUserPosition.latitude + 1,
                          widget.currentUserPosition.longitude + 1),
                    ), // [/ [east,north]
                    boundsOptions:
                        const FitBoundsOptions(padding: EdgeInsets.all(8.0)),
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate: LocalText.styleWithBackground,
                      additionalOptions: {
                        'accessToken': LocalText.accessToken,
                      },
                    ),
                    MarkerLayerOptions(markers: markers),
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
