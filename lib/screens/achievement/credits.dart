// ignore_for_file: sized_box_for_whitespace

import 'package:Fuligo/model/my_order_modal.dart';
import 'package:Fuligo/model/user_modal.dart';
import 'package:Fuligo/provider/auth_provider.dart';
import 'package:Fuligo/repositories/user_repository.dart';
import 'package:Fuligo/utils/font_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';
// import 'package:Fuligo/widgets/button.dart';
// import 'package:Fuligo/widgets/imagedetail.dart';
import 'package:Fuligo/widgets/subtxt.dart';
import 'package:Fuligo/widgets/fuligo_card.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

// import 'package:Fuligo/screens/tours.dart';

// ignore: must_be_immutable
class Credits extends StatefulWidget {
  List<Map> arch_list;
  Credits({Key? key, required this.arch_list}) : super(key: key);

  @override
  CreditsState createState() => CreditsState();
}

class CreditsState extends State<Credits> {
  void initState() {
    super.initState();
    List<Map> archList = widget.arch_list;
    getCreditsData(archList);
  }

  List<Map> creditList = [];
  int available_credits = 0;
  int used_credits = 0;
  int deductedPrice = 0;

  List<Map> _orderdata = [];
  List ordercity = [];

  Future<int> getCreditsData(List<Map> archList) async {
    int available_credits;
    List orderdata = [];
    UserModel _userInfo = AuthProvider.of(context).userModel;
    QuerySnapshot orderSnapshot =
        await FirebaseFirestore.instance.collection('order').get();
    orderSnapshot.docs
        .map(
          // UVJ7ZRb12UVeL3YJvzAPXnA0Cem1 is _userInfo.userId
          (doc) => {
            if (doc.get('userId') == 'vVBdd7pUdjZY537PX6pT8FNCrA52' &&
                doc.get('deductedPrice') > 0)
              {
                deductedPrice = doc.get('deductedPrice'),
                used_credits += deductedPrice,
                print("printcity"),
                orderdata.add(doc.get('city')),
              }
          },
        )
        .toList();
    for (var referId in orderdata) {
      // Get data from DocumentReference in firebase flutter
      referId.get().then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {
          print('Document exists on the database');

          String name = documentSnapshot.get('name')["en_GB"];
          // String image = documentSnapshot.get('image')[0];
          DateTime datetime = documentSnapshot.get('updatedAt').toDate();

          Map test = {
            "name": name,
            "datetime": datetime,
          };

          _orderdata.add(test);

          setState(() {
            creditList = archList;
          });
        } else {
          SmartDialog.showToast("No data");
        }
      });
    }

    /// get available credits
    final result = await UserRepository.getUserByID(_userInfo.uid);
    if (result["credits"] == null) {
      available_credits = 0;
    } else {
      available_credits = result["credits"];
    }
    print("orderdata");
    print(_orderdata);
    // print("archlist");
    // print(archList);
    setState(() {});
    return available_credits;
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    var used_credits = 0;
    print("iam here");
    print(this.creditList.length);

    List<Widget> creditData = [];

    for (var item in widget.arch_list) {
      String date = item["updatedAt"];
      creditData.add(
        Container(
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: bgColor,
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [gradientFrom, bgColor]),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
            leading:
                Icon(Icons.location_on_outlined, color: Colors.white, size: 32),
            title: Text(
              item["name"]["en_GB"],
              style: item["isDone"] ? font_14_white : font_14_grey,
            ),
            subtitle: item["isDone"]
                ? Text(
                    date + " | " + item["credits"].toString() + " CHF",
                    style: font_14_grey,
                  )
                : Text(
                    date + " | -" + item["credits"].toString() + " CHF",
                    style: font_14_grey,
                  ),
            onTap: () => {
              // Navigator.pushNamed(context, RouteName.Startour),
              print("object"),
            },
          ),
        ),
      );
    }
    return Container(
      decoration: bgDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   title: Text('TEST'),
        // ),
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
                    height: MediaQuery.of(context).size.height * 0.17,
                  ),
                  TextHeaderTest(
                    context,
                    "Credits",
                    "Your credit will be automatically applied \n to your next booking with Flugio. \n No actions are required",
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 60),
                          child: SubTxt(context, 'Avaialble',
                              " CHF " + available_credits.toString()),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 60),
                          child: SubTxt(context, 'Used',
                              " CHF " + used_credits.toString()),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(children: creditData),
                  )
                ],
              ),
            ),
            Positioned(
              top: 60,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.clear,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
