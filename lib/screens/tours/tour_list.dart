// ignore_for_file: sized_box_for_whitespace

import 'dart:typed_data';

import 'package:Fuligo/screens/tours/cancel_tour.dart';
import 'package:Fuligo/utils/loading.dart';
import 'package:Fuligo/widgets/clear_button.dart';
import 'package:Fuligo/widgets/custom_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';
import 'package:Fuligo/widgets/custom_button.dart';
import 'package:Fuligo/widgets/subtxt.dart';
import 'package:flutter/services.dart';

class TourList extends StatefulWidget {
  final Map detailData;
  const TourList({Key? key, required this.detailData}) : super(key: key);

  @override
  TourListState createState() => TourListState();
}

class TourListState extends State<TourList> {
  List _tourdetail = [];
  List<Uint8List> imageList = [];
  bool loading = true;
  FirebaseStorage storage = FirebaseStorage.instance;
  void initState() {
    super.initState();
    Map detailData = widget.detailData;

    getData(detailData["pointslist"]);
  }

  Future<void> getData(List _detail) async {
    if (_detail.isNotEmpty) {
      int n = 0;
      for (var referId in _detail) {
        referId.get().then((DocumentSnapshot documentSnapshot) async {
          if (documentSnapshot.exists) {
            print('Document exists on the database');
            List imageList = documentSnapshot.get("image");
            Reference ref = storage.ref().child(imageList[0]);

            String url = await ref.getDownloadURL();
            Uint8List uint8image =
                (await NetworkAssetBundle(Uri.parse(url)).load(""))
                    .buffer
                    .asUint8List();

            imageList.add(uint8image);

            String description = documentSnapshot.get('description')["en_GB"];

            String name = documentSnapshot.get('name')["en_GB"];

            Map temp = {
              "description": description,
              "name": name,
              "image": url,
              // "datetime": datetime,
            };

            _tourdetail.add(temp);
            n++;
            if (n == _detail.length) {
              setState(() {
                _tourdetail = _tourdetail;
                loading = false;
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

  @override
  Widget build(BuildContext context) {
    Map _detailData = widget.detailData;
    List<Widget> _pointwidgets = [];
    print(" ===== CollectionReference ==========");
    print(_tourdetail);
    for (var i = 0; i < _tourdetail.length; i++) {
      // for (var item in _tourdetail) {
      var item = _tourdetail[i];

      _pointwidgets.add(
        TourSmallImage(context, imageList[i], "Stop ${i + 1}", item["name"]),
      );
    }

    var mq = MediaQuery.of(context).size;
    print(" ===== overview ==========");
    print(_detailData["pointslist"]);
    return Container(
      decoration: bgDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              !loading
                  ? _pointwidgets.isNotEmpty
                      ? Container(
                          width: mq.width,
                          height: mq.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: mq.height * 0.17,
                              ),
                              PageHeader(context, _detailData["name"],
                                  _detailData["description"]),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 40),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 60),
                                      child: SubTxt(context, 'Stops',
                                          _pointwidgets.length.toString()),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 60),
                                      child: SubTxt(context, 'Duration',
                                          '${widget.detailData["duration"]} Stunden'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ))
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: mq.height * 0.2,
                            ),
                            Text(
                              "No order data",
                              style: TextStyle(
                                  fontSize: 30, color: Colors.white30),
                            ),
                          ],
                        )
                  : kLoadingFadingWidget(context),
              SecondaryButton(context),
              Positioned(
                bottom: 100,
                left: 20,
                child: SizedBox(
                  height: 140,
                  // padding: const EdgeInsets.only(right: 20, left: 20),
                  width: mq.width,
                  child: ListView(
                    shrinkWrap: true,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    scrollDirection: Axis.horizontal,
                    children: _pointwidgets,
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                child: Container(
                  width: mq.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 350,
                        height: 50,
                        child: CustomButton(
                            context, const CancelTour(), "Start tour"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
