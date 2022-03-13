import 'package:Fuligo/model/user_model.dart';

import 'package:Fuligo/provider/auth_provider.dart';
import 'package:Fuligo/screens/achievement/achievements.dart';
import 'package:Fuligo/screens/chat/chat.dart';
import 'package:Fuligo/screens/map/map.dart';
import 'package:Fuligo/screens/settings.dart';

import 'package:Fuligo/widgets/custom_button.dart';

import 'package:flutter/material.dart';
import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/circleimage.dart';

import 'documents/documents.dart';

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
    UserModel _userInfo = AuthProvider.of(context).userModel;
    print("_userInfo.avatar");
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
                contentPadding: EdgeInsets.only(
                  bottom: 20,
                ),
                leading: Image(
                  image: AssetImage('assets/images/png/icon-map.png'),
                  width: 40,
                  height: 40,
                ),
                title: Text(
                  'Map',
                  style: TextStyle(
                      color: Colors.white70, fontSize: 20, letterSpacing: 1.5),
                ),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapScreen(),
                    ),
                  ),
                },
              ),
              ListTile(
                horizontalTitleGap: 30.0,
                contentPadding: EdgeInsets.only(bottom: 20),
                leading: Image(
                  image: AssetImage('assets/images/png/icon-document.png'),
                  width: 40,
                  height: 40,
                  color: whiteColor,
                ),
                title: Text(
                  'Documents',
                  style: TextStyle(
                      color: Colors.white70, fontSize: 20, letterSpacing: 1.5),
                ),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Documents(),
                    ),
                  ),
                },
              ),
              ListTile(
                horizontalTitleGap: 30.0,
                contentPadding: EdgeInsets.only(
                  bottom: 20,
                ),
                leading: Image(
                  image: AssetImage('assets/images/png/icon-support.png'),
                  width: 40,
                  height: 40,
                ),
                title: Text(
                  'Chat',
                  style: TextStyle(
                      color: Colors.white70, fontSize: 20, letterSpacing: 1.5),
                ),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Chat(),
                      // builder: (context) => ChatTest(
                      //   docId: "rWKqClPXawJvJQs4HUmf",
                      // ),
                    ),
                  ),
                },
              ),
              ListTile(
                horizontalTitleGap: 30.0,
                contentPadding: EdgeInsets.only(
                  bottom: 20,
                ),
                leading: Image(
                  image: AssetImage('assets/images/png/icon-achievement.png'),
                  width: 40,
                  height: 40,
                ),
                title: Text(
                  'Achivement',
                  style: TextStyle(
                      color: Colors.white70, fontSize: 20, letterSpacing: 1.5),
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
              ListTile(
                horizontalTitleGap: 30.0,
                contentPadding: EdgeInsets.only(
                  bottom: 20,
                ),
                leading: Image(
                  image: AssetImage('assets/images/png/icon-achievement.png'),
                  width: 40,
                  height: 40,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(
                      color: Colors.white70, fontSize: 20, letterSpacing: 1.5),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Settings(),
                    ),
                  );
                },
              ),
              // ListTile(
              //   horizontalTitleGap: 30.0,
              //   contentPadding: EdgeInsets.only(
              //     bottom: 20,
              //   ),
              //   leading: Image(
              //     image: AssetImage('assets/images/png/icon-achievement.png'),
              //     width: 40,
              //     height: 40,
              //   ),
              //   title: Text(
              //     'Language',
              //     style: TextStyle(
              //         color: Colors.white70, fontSize: 20, letterSpacing: 1.5),
              //   ),
              //   onTap: () {
              //     showDialog(
              //         context: context,
              //         builder: (BuildContext context) => const PopupWidget());
              //   },
              // ),
            ],
          ),
        ),
        CrossButton(context),
        Positioned(
          bottom: 30,
          child: Container(
            padding: EdgeInsets.only(left: 10),
            // width: mq.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleImage(context, _userInfo.avatar, 80, 80, "avatar"),
                Container(
                  padding: EdgeInsets.only(left: 0),
                  child: Text(
                    _userInfo.username["first"] != null
                        ? _userInfo.username["first"]
                        : "Anonymous",
                    style: TextStyle(
                        color: Colors.white70,
                        decoration: TextDecoration.none,
                        fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  selectLang(context) {
    print("object");
  }
}
