// ignore_for_file: sized_box_for_whitespace

import 'package:Fuligo/screens/tours/tour_list.dart';
import 'package:Fuligo/utils/font_style.dart';
import 'package:Fuligo/utils/loading.dart';
import 'package:Fuligo/widgets/clear_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';

class Tours extends StatefulWidget {
  const Tours({Key? key}) : super(key: key);

  @override
  ToursState createState() => ToursState();
}

class ToursState extends State<Tours> {
  void initState() {
    getTourData();
  }

  List tourData = [];

  CollectionReference _tourCollection =
      FirebaseFirestore.instance.collection('city');

  Future<List> getTourData() async {
    QuerySnapshot querySnapshot = await _tourCollection.get();

    // Get data from docs and convert map to List
    List tourdata = querySnapshot.docs
        .map(
          (doc) => doc.data(),
        )
        .toList();

    for (var item in tourdata) {
      item["image"] = await getUrlFromFirebase((item["image"][0]));
    }

    setState(() {
      tourData = tourdata;
    });
    return tourData;
  }

  Future<String> getUrlFromFirebase(String firebaseURL) async {
    Reference ref = FirebaseStorage.instance.ref().child(firebaseURL);
    String url = await ref.getDownloadURL();
    print("123");

    return url;
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;

    List<Widget> tourlist = [];
    for (var each in tourData) {
      if (each["active"] == true) {
        tourlist.add(
          GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, RouteName.tourlist);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TourList(detailData: each),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      each["image"],
                      width: mq.width * 0.8,
                      height: mq.height * 0.2,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: kLoadingFadingWidget(context),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    child: Container(
                      width: mq.width * 0.8,
                      height: mq.height * 0.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [gradientFrom, bgColor]),
                          color: bgColor.withOpacity(0.4)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            each["name"]["en_GB"],
                            style: font_20_white,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              width: 62,
                              height: 2.5,
                              decoration:
                                  const BoxDecoration(color: Colors.white54),
                            ),
                          ),
                          Text(
                            each["description"]["en_GB"],
                            style: font_13_white,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    }

    return Container(
      decoration: bgDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              width: mq.width,
              height: mq.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: mq.height * 0.17,
                  ),
                  TextHeaderTest(
                    context,
                    "Tours",
                    "Dicovery the city with one of \n our digital travel tours",
                  ),
                  tourlist.isNotEmpty
                      ? Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          width: mq.width * 0.8,
                          height: mq.height * 0.7,
                          child: ListView(
                            padding: EdgeInsets.all(0),
                            children: tourlist,
                          ),
                        )
                      : Container(
                          // color: widget.backgroundColor,
                          margin: EdgeInsets.symmetric(vertical: 100),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: mq.height * 0.2,
                                ),
                                kLoadingFadingWidget(context),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
            ClearButton(context),
          ],
        ),
      ),
    );
  }
}
