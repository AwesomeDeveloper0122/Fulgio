// ignore_for_file: deprecated_member_use, unused_local_variable

import 'dart:convert';

import 'package:Fuligo/screens/chat/chat.dart';
import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/utils/common_functions.dart';
import 'package:Fuligo/utils/common_header_list.dart';
import 'package:flutter/material.dart';
import 'package:Fuligo/screens/auth/login.dart';
import 'package:Fuligo/widgets/custom_button.dart';
import 'package:Fuligo/widgets/text_header.dart';
import 'package:Fuligo/widgets/logo.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/common_functions.dart';
// import 'package:Fuligo/utils/common_colors.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  LocationState createState() => LocationState();
}

class LocationState extends State<Location> {
  String page = HeaderList.explorer;
  String title = '';
  String subtitle = '';
  List<String> headerList = [];
  @override
  void initState() {
    super.initState();
    getData(page);

    // setState(() {});
  }

  void getData(pageName) async {
    headerList = await getTitle(pageName);
    title = headerList[0];
    subtitle = headerList[1];
    setState(() {});
  }

  // Future<List<String>> getTitle(pageName) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String headerList = prefs.getString('headerlist').toString();
  //   print("123123123123123123");
  //   print(headerList);
  //   var header = jsonDecode(headerList)[pageName];

  //   print(header);
  //   title = header['title'];
  //   subtitle = header['subtitle'];
  //   setState(() {});
  //   return [];
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/explore.png"),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Logo_test,
                  TextHeaderTest(context, "Location",
                      "In order to user the application and the naviagtions  technologie, enable your location tracking service"),
                ],
              ),
            ),
            Positioned(
              bottom: 30,
              child: Center(
                child: SizedBox(
                  height: 50,
                  width: 340,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    color: bgColor,
                    onPressed: () {
                      //  Navigator.of(context).pushReplacementNamed(page);
                      showConfirm(context, "tracking");
                    },
                    textColor: bgColor,
                    child: Text(
                      "Enable Tracking",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
