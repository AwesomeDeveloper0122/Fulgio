// ignore_for_file: sized_box_for_whitespace

import 'package:Fuligo/model/user_modal.dart';
import 'package:Fuligo/provider/auth_provider.dart';
import 'package:Fuligo/repositories/user_repository.dart';
import 'package:Fuligo/widgets/circleimage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';
// import 'package:Fuligo/widgets/button.dart';
// import 'package:Fuligo/widgets/imagedetail.dart';
import 'package:Fuligo/widgets/subtxt.dart';
import 'package:Fuligo/widgets/fuligo_card.dart';

// import 'package:Fuligo/screens/tours.dart';

class Ranking extends StatefulWidget {
  const Ranking({Key? key}) : super(key: key);

  @override
  RankingState createState() => RankingState();
}

class RankingState extends State<Ranking> {
  void initState() {
    super.initState();

    getData();
  }

  List<Map> _users = [];
  bool is_load = false;

  String avatar =
      "https://firebasestorage.googleapis.com/v0/b/project-flugio.appspot.com/o/assets%2Fstatic%2Favatar-marieke-harmsen%402x.png?alt=media&token=8043d7f3-347b-457c-abf8-126a79449354";
  int achievement_num = 0;
  String userId = "";

  Future<bool> getData() async {
    UserModel _userInfo = AuthProvider.of(context).userModel;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    users.get().then((QuerySnapshot querySnapshot) {
      for (var user in querySnapshot.docs) {
        Map _usermap = user.data() as Map<String, dynamic>;
        userId = user["uid"];
        if (_usermap.containsKey("avatar")) {
          if (_usermap.containsKey("achievements")) {
            avatar = _usermap["avatar"];
            List aaa = _usermap["achievements"];
            achievement_num = aaa.length;
          } else {
            avatar = _usermap["avatar"];
          }
        }
        if (_usermap.containsKey("achievements")) {
          List aaa = _usermap["achievements"];
          achievement_num = aaa.length;
        }

        _users.add({"avatar": avatar, "name": userId, "num": achievement_num});
        setState(() {});
      }
    });

    return is_load;
  }

  @override
  Widget build(BuildContext context) {
    print("users345");
    print(_users.length);
    var mq = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: bgColor,
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [gradientFrom, bgColor]),
      ),
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
                    height: MediaQuery.of(context).size.height * 0.17,
                  ),
                  TextHeaderTest(
                    context,
                    "Ranking",
                    "So where do you stand? Let's see...",
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                    child: Column(
                      children: [
                        // Container(
                        //   margin: EdgeInsets.only(bottom: 20),
                        //   decoration: BoxDecoration(
                        //     color: bgColor,
                        //     gradient: const LinearGradient(
                        //         begin: Alignment.topLeft,
                        //         end: Alignment.bottomRight,
                        //         colors: [gradientFrom, bgColor]),
                        //     borderRadius: BorderRadius.circular(25.0),
                        //   ),
                        //   child: ListTile(
                        //     contentPadding: EdgeInsets.symmetric(
                        //         horizontal: 20, vertical: 5),
                        //     leading: CircleImage(context,
                        //         "assets/images/1.jpeg", 50, 50, "ranking"),
                        //     trailing: CircleImage(context,
                        //         "assets/images/1.jpeg", 50, 50, "ranking"),
                        //     title: Text(
                        //       'Zurich-Amsterdam',
                        //       style:
                        //           TextStyle(color: Colors.white, fontSize: 16),
                        //     ),
                        //     subtitle: Text(
                        //       '11-02-2021 | -2 CHF',
                        //       style:
                        //           TextStyle(color: Colors.grey, fontSize: 14),
                        //     ),
                        //     onTap: () => {
                        //       // Navigator.pushNamed(context, RouteName.Startour),
                        //       print("object"),
                        //     },
                        //   ),
                        // ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: bgColor,
                            gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [gradientFrom, bgColor]),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            leading: Icon(Icons.location_on_outlined,
                                color: Colors.white, size: 32),
                            title: Text(
                              'Zurich-Amsterdam',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            subtitle: Text(
                              '11-02-2021 | -2 CHF',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                            onTap: () => {
                              // Navigator.pushNamed(context, RouteName.Startour),
                            },
                          ),
                        ),
                      ],
                    ),
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
