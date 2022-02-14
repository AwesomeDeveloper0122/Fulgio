// ignore_for_file: sized_box_for_whitespace

import 'package:Fuligo/screens/tours/tour_list.dart';
import 'package:Fuligo/utils/font_style.dart';
import 'package:Fuligo/utils/loading.dart';
import 'package:Fuligo/widgets/clear_button.dart';
import 'package:Fuligo/widgets/logo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';
import 'package:Fuligo/widgets/custom_image.dart';

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

  final CollectionReference _tourCollection =
      FirebaseFirestore.instance.collection('city');

  Future<List> getTourData() async {
    QuerySnapshot querySnapshot = await _tourCollection.get();

    // Get data from docs and convert map to List
    List tourdata = querySnapshot.docs.map((doc) => doc.data()).toList();
    print("==== List tourdata ====");
    print(tourdata);
    setState(() {
      tourData = tourdata;
    });
    return tourData;
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    print("==== tourdata  ====");

    List<Widget> tourlist = [];
    for (var item in tourData) {
      print(" ======== item ============");
      print(item);
      if (item["active"] == true) {
        tourlist.add(
          InkWell(
            onTap: () {
              // Navigator.pushNamed(context, RouteName.tourlist);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TourList(detailData: item),
                ),
              );
            },
            child: Container(
              width: 350,
              height: 140,
              margin: const EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/1.jpeg"),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    item["name"]["en_GB"],
                    style: font_20_white,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: 62,
                      height: 2.5,
                      decoration: const BoxDecoration(color: Colors.grey),
                    ),
                  ),
                  Text(
                    item["description"]["en_GB"],
                    style: font_13_white,
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }
    // for (var i = 0; i < 6; i++) {
    //   tourlist.add(TourBigImage(
    //       context, "assets/images/1.jpeg", "Red right", "Amsterdam"));
    // }

    print("==== tourlist====");
    print(tourlist);

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
