// ignore_for_file: sized_box_for_whitespace

import 'dart:typed_data';

import 'package:Fuligo/utils/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//Screens
import 'package:Fuligo/screens/tours/tours.dart';

//Widgets
import 'package:Fuligo/widgets/custom_button.dart';
import 'package:Fuligo/widgets/logo.dart';
import 'package:Fuligo/widgets/circleimage.dart';

class StartTour extends StatefulWidget {
  const StartTour({Key? key}) : super(key: key);

  @override
  StartTourState createState() => StartTourState();
}

class StartTourState extends State<StartTour> {
  List pointdata = [];
  bool loading = true;
  List imageNetList = [];
  List<Uint8List> imageList = [];
  final CollectionReference _pointCollection =
      FirebaseFirestore.instance.collection('pointOfInterest');
  @override
  // ignore: must_call_super
  void initState() {
    getPointData();
  }

  Future<String> getUrlFromFirebase(String firebaseURL) async {
    print("firebaseURL");
    print(firebaseURL);

    Reference ref = FirebaseStorage.instance.ref().child(firebaseURL);
    String url = await ref.getDownloadURL();
    print("network url");
    print(url);

    return url;
  }

  Future<List> getPointData() async {
    QuerySnapshot querySnapshot = await _pointCollection.get();
    List videoUrl = [];
    List imageUrlList = [];
    List idList = [];
    int n = 0;
    Map location = {};
    String imgUrl = "";
    if (querySnapshot.docs.isNotEmpty) {
      List snapdata = querySnapshot.docs
          .map((doc) => {
                doc.data(),
                idList.add(doc.id),
              })
          .toList();
      print("important");
      for (var i = 0; i < querySnapshot.docs.length; i++) {
        var ele = querySnapshot.docs[i];

        try {
          videoUrl = ele.get("video");

          print(videoUrl);
        } catch (e) {
          videoUrl = [];

          print(videoUrl);
        }

        if (videoUrl.isNotEmpty) {
          imageUrlList = ele.get("image");
          location = ele.get('location');
          if (imageUrlList.isNotEmpty) {
            // imgUrl = await getUrlFromFirebase(imageUrlList[0].toString());
            // print("videourl");
            // print(imgUrl);
            Uint8List uint8image = (await NetworkAssetBundle(
                        Uri.parse("https://picsum.photos/250?image=9"))
                    .load(""))
                .buffer
                .asUint8List();
            imageList.add(uint8image);
            n++;
          }
          String id = ele.id;
          pointdata.add({"id": id, "location": location, "flag": "video"});
        } else {
          imageUrlList = ele.get("image");
          location = ele.get('location');
          if (imageUrlList.isNotEmpty) {
            // imgUrl = await getUrlFromFirebase(imageUrlList[0].toString());
            // print("audiourl");
            // print(imgUrl);
            Uint8List uint8image = (await NetworkAssetBundle(
                        Uri.parse("https://picsum.photos/250?image=9"))
                    .load(""))
                .buffer
                .asUint8List();
            imageList.add(uint8image);
            n++;
          }
          String id = ele.id;
          pointdata.add({"id": id, "location": location, "flag": "audio"});
        }
      }
      if (n == querySnapshot.docs.length) {
        setState(() {
          pointdata = pointdata;
          loading = false;
          imageList = imageList;
        });
      }
    } else {
      setState(() {
        loading = false;
      });
    }
    print("pointdata");
    print(pointdata);
    return pointdata;
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    List<Widget> mediaList = [];

    if (pointdata.isNotEmpty) {
      for (var i = 0; i < pointdata.length; i++) {
        var item = pointdata[i];

        if (item["flag"] == "video") {
          mediaList.add(
            Positioned(
                top: 0,
                left: 0,
                child: CircleVideoImage(context, item, imageList[i])),
          );
        } else {
          mediaList.add(
            Positioned(
                top: 0,
                left: 0,
                child: CircleAudioImage(context, item, imageList[i])),
          );
        }
      }
    } else if (loading) {
      mediaList.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: mq.height * 0.5,
            ),
            kLoadingFadingWidget(context)
          ],
        ),
      );
    } else {
      mediaList.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: mq.height * 0.2,
            ),
            Text(
              "No order data",
              style: TextStyle(fontSize: 30, color: Colors.white30),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/map_test.png"),
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
                ],
              ),
            ),
            Column(
              children: mediaList,
            ),
            MenuButton(context),
            PrimaryButton(context, const Tours(), "Start tour")
          ],
        ),
      ),
    );
  }
}
