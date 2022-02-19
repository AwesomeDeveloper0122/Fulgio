// ignore_for_file: sized_box_for_whitespace

import 'package:Fuligo/model/interest_model.dart';
import 'package:Fuligo/model/my_order_modal.dart';
import 'package:Fuligo/screens/cancel_tour.dart';
import 'package:Fuligo/utils/loading.dart';
import 'package:Fuligo/widgets/clear_button.dart';
import 'package:Fuligo/widgets/custom_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';
import 'package:Fuligo/widgets/custom_button.dart';
import 'package:Fuligo/widgets/image_detail.dart';
import 'package:Fuligo/widgets/subtxt.dart';

import 'package:Fuligo/screens/tours/tours.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class TourList extends StatefulWidget {
  final Map detailData;
  const TourList({Key? key, required this.detailData}) : super(key: key);

  @override
  TourListState createState() => TourListState();
}

class TourListState extends State<TourList> {
  void initState() {
    super.initState();
    Map detailData = widget.detailData;
    print("detailData");
    print(detailData["interests"]);
    getData(detailData["interests"], detailData["activities"]);
  }

  CollectionReference _interestRef =
      FirebaseFirestore.instance.collection('interest');
  CollectionReference _activityRef =
      FirebaseFirestore.instance.collection('activity');

  Future<void> getData(List _detail, List _activity) async {
    // Get docs from collection reference
    List _tourdetail = [];
    List _activitydetail = [];
    for (var referId in _detail) {
      // Get data from DocumentReference in firebase flutter
      referId.get().then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {
          print('Document exists on the database');
          //get image url from firebase storage
          Reference ref = FirebaseStorage.instance
              .ref()
              .child(documentSnapshot.get('image')["main"]);

          String url = await ref.getDownloadURL();
          print("ref123");
          print(url);
          String description = documentSnapshot.get('description')["en_GB"];
          print("url description");
          print(description);

          String name = documentSnapshot.get('name')["en_GB"];
          // String image = documentSnapshot.get('image')[0];
          DateTime datetime = documentSnapshot.get('updatedAt').toDate();

          Map test = {
            "description": description,
            "name": name,
            // "image": url,
            "datetime": datetime,
          };
          InterestModel _InterestModel = InterestModel.fromJson(test);

          _tourdetail.add(_InterestModel);
          print("_tourdetail");
          print(_tourdetail);
          setState(() {
            _tourdetail = _tourdetail;
          });
        } else {
          SmartDialog.showToast("No data");
        }
      });
    }

    QuerySnapshot interestquerySnapshot = await _interestRef.get();
    QuerySnapshot activityquerySnapshot = await _activityRef.get();
    print("------------------");
    print(_detail.runtimeType);
    // Get data from docs and convert map to List

    // interestquerySnapshot.docs
    //     .map((doc) => {
    //           if (_detail.contains(doc.reference))
    //             {
    //               print("===== doc.data() =========="),
    //               print(doc.data()),
    //               _tourdetail.add(doc.data())
    //             }
    //         })
    //     .toList();
    activityquerySnapshot.docs
        .map((doc) => {
              if (_activity.contains(doc.reference))
                {
                  // print("===== doc.data() =========="),
                  // print(doc.data()),
                  _activitydetail.add(doc.data())
                }
            })
        .toList();

    // print(" ===== allData =====");
    // print(allData);
    print(" ===== _tourdetail =====");
    print(_tourdetail);
    // print(" ===== _activitydetail =====");
    // print(_activitydetail.length);
  }

  @override
  Widget build(BuildContext context) {
    Map _detailData = widget.detailData;

    print(" ===== CollectionReference ==========");

    var mq = MediaQuery.of(context).size;
    print(" ===== overview ==========");
    print(_detailData["interests"]);
    return Container(
      decoration: bgDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              _detailData.isNotEmpty
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
                          TextHeaderTest(context, _detailData["name"]["en_GB"],
                              _detailData["overview"]["en_GB"]),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 60),
                                  child: SubTxt(context, 'Stops', '7'),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 60),
                                  child:
                                      SubTxt(context, 'Duration', '2 Stunden'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))
                  : kLoadingFadingWidget(context),
              ClearButton(context),
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
                    children: <Widget>[
                      TourSmallImage(context, "assets/images/1.jpeg",
                          "Red right", "Amsterdam"),
                      TourSmallImage(context, "assets/images/1.jpeg",
                          "Old town", "Amsterdam"),
                      TourSmallImage(context, "assets/images/1.jpeg",
                          "Old town", "Amsterdam")
                    ],
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
