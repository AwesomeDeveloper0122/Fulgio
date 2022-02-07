// ignore_for_file: sized_box_for_whitespace, prefer_final_fields

import 'dart:convert';

import 'package:Fuligo/utils/common_header_list.dart';
import 'package:Fuligo/utils/loading.dart';
import 'package:Fuligo/widgets/clear_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';
// import 'package:Fuligo/widgets/button.dart';
// import 'package:Fuligo/widgets/imagedetail.dart';
import 'package:Fuligo/widgets/subtxt.dart';
import 'package:Fuligo/widgets/fuligo_card.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:Fuligo/screens/tours.dart';

class Achievements extends StatefulWidget {
  const Achievements({Key? key}) : super(key: key);

  @override
  ArchivmentsState createState() => ArchivmentsState();
}

class ArchivmentsState extends State<Achievements> {
  List allData = [];
  bool is_load = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('achievement');

  Future<List> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    is_load = true;

    setState(() {});
    print("bbbb");
    print(allData);

    return [];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    print("aaaaaaaaaaaaaa");
    print(allData);
    allData.forEach((element) {
      if (element["active"] == true) {
        widgets.add(
          Container(
            padding: EdgeInsets.all(5),
            child: FuligoCard(context, element["name"]["en_GB"],
                element["active"] ? whiteColor : greyColor),
          ),
        );
      } // only show if active is true
    });
    var mq = MediaQuery.of(context).size;

    return Builder(builder: (context) {
      return Container(
        decoration: bgDecoration,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            // appBar: AppBar(
            //   title: Text('TEST'),
            // ),
            body: is_load
                ? Stack(
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
                              "Archivements",
                              "Each completed achievement \n brings you credit on Flugio, ",
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 55),
                                    child: SubTxt(
                                        context, 'Achievementss', '5 of 75'),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 55),
                                    child: SubTxt(context, 'Credit', '8 CHF'),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: mq.width,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: widgets,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ClearButton(context),
                    ],
                  )
                : kLoadingFadeWidget(context)),
      );
    });
  }
}
