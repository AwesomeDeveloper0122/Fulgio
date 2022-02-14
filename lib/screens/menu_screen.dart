// ignore_for_file: non_constant_identifier_names, sized_box_for_whitespace, avoid_print

// import 'package:Fuligo/routes/route_costant.dart';
import 'dart:convert';

import 'package:Fuligo/model/user_modal.dart';

import 'package:Fuligo/provider/auth_provider.dart';
import 'package:Fuligo/routes/route_costant.dart';
import 'package:Fuligo/screens/achievement/achievements.dart';
import 'package:Fuligo/screens/chat/chat.dart';
import 'package:Fuligo/screens/chat/chat_again.dart';
import 'package:Fuligo/screens/chat/chat_content.dart';
import 'package:Fuligo/screens/documents/documents.dart';
import 'package:Fuligo/screens/tours/start_tour.dart';
import 'package:Fuligo/utils/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Fuligo/utils/common_colors.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
// import 'package:Fuligo/widgets/button.dart';
import 'package:Fuligo/widgets/circleimage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'avatar_screen.dart';
// import 'package:Fuligo/screens/achievements.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();

    // setState(() {});
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Test(),
    );
  }
}

class Test extends StatelessWidget {
  Test({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    bool isLoad = false;
    UserModel _userInfo = AuthProvider.of(context).userModel;
    if (_userInfo.avatar != "") {
      isLoad = true;
    }

    print("========= userInfo ============");
    print(isLoad);
    print(_userInfo.avatar);
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20),
          decoration: const BoxDecoration(
            color: bgColor,
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [gradientFrom, bgColor]),
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              ListTile(
                horizontalTitleGap: 30.0,
                contentPadding: EdgeInsets.only(bottom: 20, left: 20),
                leading: Image(
                  image: AssetImage('assets/images/png/icon-map.png'),
                  width: 40,
                  height: 40,
                ),
                title: Text(
                  'Map',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () => {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         ChatAgain(documentId: 'qEnncoZSqLs8QE4jS3bF'),
                  //   ),
                  // ),
                },
              ),
              ListTile(
                horizontalTitleGap: 30.0,
                contentPadding: EdgeInsets.only(bottom: 20, left: 20),
                leading: Image(
                  image: AssetImage('assets/images/png/icon-document.png'),
                  width: 40,
                  height: 40,
                  color: whiteColor,
                ),
                title: Text(
                  'Documents',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Chat(
                        ischat: false,
                      ),
                    ),
                  ),
                },
              ),
              ListTile(
                horizontalTitleGap: 30.0,
                contentPadding: EdgeInsets.only(bottom: 20, left: 20),
                leading: Image(
                  image: AssetImage('assets/images/png/icon-achievement.png'),
                  width: 40,
                  height: 40,
                ),
                title: Text(
                  'Chat',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Chat(ischat: true),
                    ),
                  ),
                },
              ),
              ListTile(
                horizontalTitleGap: 30.0,
                contentPadding: EdgeInsets.only(bottom: 20, left: 20),
                leading: Image(
                  image: AssetImage('assets/images/png/icon-achievement.png'),
                  width: 40,
                  height: 40,
                ),
                title: Text(
                  'Achivement',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Achievements(),
                    ),
                  ),
                },
              ),
            ],
          ),
        ),
        Positioned(
          top: 50,
          left: 20,
          child: GestureDetector(
            onTap: () => {(SmartDialog.dismiss())},
            child: const Icon(
              Icons.clear_rounded,
              size: 50,
              color: Colors.white,
            ),
          ),
        ),
        isLoad
            ? Positioned(
                bottom: 30,
                child: Container(
                  padding: EdgeInsets.only(left: 30),
                  // width: mq.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _userInfo.avatar != ""
                          ? CircleImage(
                              context, _userInfo.avatar, 80, 80, "menu")
                          : CircleImage(
                              context,
                              "https://picsum.photos/id/237/200/300",
                              80,
                              80,
                              "menu"),
                      Container(
                        padding: EdgeInsets.only(left: 0),
                        child: Text(
                          _userInfo.username,
                          style: TextStyle(
                              color: whiteColor,
                              decoration: TextDecoration.none,
                              fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : kLoadingFadingWidget(context),
      ],
    );
  }
}
