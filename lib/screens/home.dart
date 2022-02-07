// ignore_for_file: deprecated_member_use, unused_local_variable

import 'dart:convert';

import 'package:Fuligo/utils/common_functions.dart';
import 'package:Fuligo/utils/common_header_list.dart';
import 'package:flutter/material.dart';
import 'package:Fuligo/screens/auth/login.dart';
import 'package:Fuligo/widgets/custom_button.dart';
import 'package:Fuligo/widgets/text_header.dart';
import 'package:Fuligo/widgets/logo.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:Fuligo/utils/common_colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
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
                  TextHeaderTest(context, title, subtitle),
                ],
              ),
            ),
            CustomButtonTest(context, const Login(), "Next")
          ],
        ),
      ),

      // body: Stack(
      //   children: <Widget>[
      //     Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         TextHeader(
      //           context,
      //           "Explore",
      //           "Exploer the city through digital city \nguids and exciting video content",
      //         ),
      //       ],
      //     ),
      //     Positioned(
      //       bottom: 30,
      //       child: SizedBox(
      //         width: mq.width,
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: [
      //             Container(
      //               child: CustomButton(context, const Login(), "Next"),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
