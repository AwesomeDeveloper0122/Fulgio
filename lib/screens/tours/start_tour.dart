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

class StartTour extends StatefulWidget {
  const StartTour({Key? key}) : super(key: key);

  @override
  StartTourState createState() => StartTourState();
}

class StartTourState extends State<StartTour> {
  List pointdata = [];
  void initState() {
    getPointData();
  }

  late Map test;

  final CollectionReference _pointCollection =
      FirebaseFirestore.instance.collection('pointOfInterest');

  Future<List> getPointData() async {
    QuerySnapshot querySnapshot = await _pointCollection.get();
    try {
      for (var ele in querySnapshot.docs) {
        try {
          List videoUrl = [];
          List audioUrl = [];

          List netImageUrl = [];
          String netVideoUrl = "";
          String netAudioUrl = "";
          List imageUrl = ele.get("image");
          if (imageUrl.length > 0) {
            for (var item in imageUrl) {
              netImageUrl.add(await getUrlFromFirebase(item));
            }
          }
          if ((ele.data() as Map<String, dynamic>).containsKey("video")) {
            videoUrl = ele.get("video");
            if (videoUrl.length > 0) {
              netVideoUrl = await getUrlFromFirebase(videoUrl[0]);

              pointdata.add({
                "video": netVideoUrl,
                "location": ele.get("location"),
                "image": netImageUrl,
              });
            }
          } else if ((ele.data() as Map<String, dynamic>)
                  .containsKey("audio") &&
              (ele.data() as Map<String, dynamic>).containsKey("image")) {
            // SmartDialog.showToast("imagefiled not exist");
            audioUrl = ele.get("audio");
            if (audioUrl.length > 0) {
              netAudioUrl = await getUrlFromFirebase(audioUrl[0]);
            }

            pointdata.add(
              {
                "image": netImageUrl,
                "location": ele.get("location"),
                "audio": netAudioUrl
              },
            );
          }
        } catch (err) {
          // SmartDialog.showToast("Error");
        }
      }
    } catch (e) {
      SmartDialog.showToast("No data");
    }

    setState(() {
      pointdata = pointdata;
    });

    return pointdata;
  }

  Future<String> getUrlFromFirebase(String firebaseURL) async {
    Reference ref = FirebaseStorage.instance.ref().child(firebaseURL);
    String url = await ref.getDownloadURL();

    return url;
  }

  @override
  Widget build(BuildContext context) {
    print("123123");
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
