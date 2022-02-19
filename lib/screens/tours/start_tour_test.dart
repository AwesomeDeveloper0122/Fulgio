// ignore_for_file: sized_box_for_whitespace

import 'package:Fuligo/utils/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:Fuligo/utils/common_colors.dart';
//Screens
import 'package:Fuligo/screens/tours/tours.dart';
// import 'package:Fuligo/screens/touranother.dart';
// import 'package:Fuligo/screens/cancel_tour.dart';
// import 'package:Fuligo/screens/achievements.dart';

//Widgets
import 'package:Fuligo/widgets/custom_button.dart';
import 'package:Fuligo/widgets/logo.dart';
import 'package:Fuligo/widgets/circleimage.dart';
import 'package:Fuligo/screens/menu_screen.dart';

class StartTourTest extends StatefulWidget {
  const StartTourTest({Key? key}) : super(key: key);

  @override
  StartTourTestState createState() => StartTourTestState();
}

class StartTourTestState extends State<StartTourTest> {
  List pointdata = [];
  void initState() {
    getPointData();
  }

  // late Map test;
  // List videoUrl = [];
  // List audioUrl = [];

  // List netImageUrl = [];
  // String netVideoUrl = "";
  // String netAudioUrl = "";
  // List imageUrl = [];

  final CollectionReference _pointCollection =
      FirebaseFirestore.instance.collection('pointOfInterest');

  Future<List> getPointData() async {
    QuerySnapshot querySnapshot = await _pointCollection.get();
    List<Map> pointdata = [];
    for (var ele in querySnapshot.docs) {
      String netVideoUrl = await getVideoData(ele);
      String netAudioUrl = await getAudioData(ele);
      List imageUrl = await getImageData(ele);
      Map location = await getLocationData(ele);
      pointdata.add({
        "video": netVideoUrl,
        "image": imageUrl,
        "location": location,
        "audio": netAudioUrl,
      });
      setState(() {});
    }

    return pointdata;
  }

  Future<String> getVideoData(QueryDocumentSnapshot item) async {
    List urlList = [];
    String url = "";
    if ((item.data() as Map<String, dynamic>).containsKey("video")) {
      urlList = item.get("video");
      if (urlList.isNotEmpty) {
        url = await getUrlFromFirebase(urlList[0]);
        //
      }
    }
    return url;
  }

  Future<String> getAudioData(QueryDocumentSnapshot item) async {
    List urlList = [];
    String url = "";
    if ((item.data() as Map<String, dynamic>).containsKey("audio")) {
      urlList = item.get("video");
      if (urlList.isNotEmpty) {
        url = await getUrlFromFirebase(urlList[0]);
        //
      }
    }
    return url;
  }

  Future<List> getImageData(QueryDocumentSnapshot item) async {
    List urlList = [];
    List<String> url = [];
    if ((item.data() as Map<String, dynamic>).containsKey("audio")) {
      url = item.get("video");
      if (url.isNotEmpty) {
        for (var item in url) {
          urlList.add(await getUrlFromFirebase(item));
        }
      }
    }
    return url;
  }

  Future<Map> getLocationData(QueryDocumentSnapshot item) async {
    Map location = item.get("location");
    return location;
  }

  Future<String> getUrlFromFirebase(String firebaseURL) async {
    Reference ref = FirebaseStorage.instance.ref().child(firebaseURL);
    String url = await ref.getDownloadURL();

    return url;
  }

  @override
  Widget build(BuildContext context) {
    print("pointdata builder");
    print(pointdata);
    var mq = MediaQuery.of(context).size;
    List<Widget> widgets = [];
    if (pointdata.length > 0) {
      for (var item in pointdata) {
        widgets.add(
          Positioned(
            top: 0,
            left: 0,
            child: CircleNetworkImage(context, item),
          ),
        );
      }
    } else {
      widgets.add(
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
                  Logo_test,
                ],
              ),
            ),

            Column(
              children: widgets,
            ),

// Menu Icon
            Positioned(
              top: 50,
              left: 20,
              child: GestureDetector(
                onTap: () => {_show()},
                child: const Icon(
                  Icons.menu,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),

            CustomButtonTest(context, const Tours(), "Start tour")
          ],
        ),
      ),
      // appBar: AppBar(
      //   title: Text('TEST'),
      // ),
    );
  }

  void _show() {
    SmartDialog.show(
      widget: MenuScreen(),
    );

    //target widget
  }
}
