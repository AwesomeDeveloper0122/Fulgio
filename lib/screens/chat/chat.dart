// ignore_for_file: sized_box_for_whitespace
import 'dart:convert';
import 'package:Fuligo/utils/loading.dart';
import 'package:intl/intl.dart';
import 'package:Fuligo/model/my_order_modal.dart';
import 'package:Fuligo/model/user_modal.dart';
import 'package:Fuligo/provider/auth_provider.dart';
import 'package:Fuligo/widgets/clear_button.dart';
import 'package:Fuligo/widgets/logo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';
import 'package:Fuligo/widgets/custom_image.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class Chat extends StatefulWidget {
  bool ischat;
  Chat({Key? key, required this.ischat}) : super(key: key);

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  List<OrderModel> myOrderCity = [];
  List _citydetail = [];
  List _myorderId = [];

  var dateFormat;

  void initState() {
    getOrderData();
    super.initState();
  }

  Future<List<OrderModel>> getOrderData() async {
    // Get docs from collection reference
    List _myordertempdata = [];
    List allCity = [];

    // CollectionReference _interestRef =
    //     FirebaseFirestore.instance.collection('order');
    UserModel _userInfo = AuthProvider.of(context).userModel;
    QuerySnapshot orderSnapshot =
        await FirebaseFirestore.instance.collection('order').get();
    // Get data from DocumentRefernce
    // DocumentReference docRef =
    //     FirebaseFirestore.instance.doc("city/xrIDkBvtxYjXUYLgDtnG");
    // docRef.get().then((DocumentSnapshot documentSnapshot) {
    //   if (documentSnapshot.exists) {
    //     // print('Document exists on the database');
    //     // print(documentSnapshot.data());
    //   }
    // });

    // Get data from docs and convert map to List
    orderSnapshot.docs
        .map(
          (doc) => {
            if (doc.get('userId') ==
                'vVBdd7pUdjZY537PX6pT8FNCrA52') // UVJ7ZRb12UVeL3YJvzAPXnA0Cem1 is _userInfo.userId
              {
                print(doc.get('city')),
                _citydetail.add(doc.get('documents')),
                print("==doc.reference.id=="),
                print(doc.reference.id),
                _myordertempdata.add(doc.get('city')), // refernce id
                _myorderId.add(doc.reference.id),
              }
          },
        )
        .toList();
    for (var i = 0; i < _myordertempdata.length; i++) {
      _myordertempdata[i].get().then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {
          print('Document exists on the database');
          //get image url from firebase storage
          Reference ref = FirebaseStorage.instance
              .ref()
              .child(documentSnapshot.get('image')[0]);
          String url = await ref.getDownloadURL();

          String name = documentSnapshot.get('name')["en_GB"];
          // String image = documentSnapshot.get('image')[0];
          DateTime datetime = documentSnapshot.get('updatedAt').toDate();

          Map test = {
            "orderId": _myorderId[i],
            "name": name,
            "image": url,
            "datetime": datetime,
          };
          OrderModel _orderModel = OrderModel.fromJson(test);

          myOrderCity.add(_orderModel);
          setState(() {
            myOrderCity = myOrderCity;
          });
        } else {
          SmartDialog.showToast("No data");
        }
      });
    }

    return myOrderCity;
  }

  @override
  Widget build(BuildContext context) {
    print("Start ChatItem");
    List<Widget> citydetaildata = [];

    for (var element in myOrderCity) {
      String date = DateFormat('MM-dd-yyyy').format(element.datetime);
      if (!widget.ischat) {
        citydetaildata.add(
          TourBigImage(
              context, element.image, element.name, date, false, _citydetail),
        );
      } else {
        citydetaildata.add(
          ChatCard(context, element.image, element.name, date, true,
              element.orderId),
        );
      }
    }
    var mq = MediaQuery.of(context).size;
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
                  Logo_test,
                  widget.ischat
                      ? TextHeaderTest(
                          context,
                          "Chat",
                          "For which order do you need support?",
                        )
                      : Text(""),
                  citydetaildata.length > 0
                      ? Column(
                          children: citydetaildata,
                        )
                      : Container(
                          margin: EdgeInsets.only(top: mq.height * 0.3),
                          child: kLoadingFadingWidget(context),
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
