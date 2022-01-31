// ignore_for_file: non_constant_identifier_names, sized_box_for_whitespace, avoid_print

// import 'package:Fuligo/routes/route_costant.dart';
import 'package:Fuligo/screens/start_tour.dart';
import 'package:flutter/material.dart';
import 'package:Fuligo/utils/common_colors.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
// import 'package:Fuligo/widgets/button.dart';
import 'package:Fuligo/widgets/circleimage.dart';
// import 'package:Fuligo/screens/achievements.dart';

Widget MenuScreen(context) => Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 150, left: 20),
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
              // SizedBox(
              //   height: 80,
              //   child: ListTile(
              //     leading: Icon(
              //       Icons.map,
              //       color: Colors.white,
              //       size: 32,
              //     ),
              //     title: Text(
              //       'Map',
              //       style: TextStyle(color: Colors.white, fontSize: 20),
              //     ),
              //   ),
              // ),
              ListTile(
                contentPadding: EdgeInsets.only(bottom: 20, left: 20),
                leading: Icon(Icons.location_on_outlined,
                    color: Colors.white, size: 32),
                title: Text(
                  'Map',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () => {
                  // Navigator.pushNamed(context, RouteName.Startour),
                  print("object"),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StartTour(),
                    ),
                  ),
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.only(bottom: 20, left: 20),
                leading: Icon(Icons.document_scanner_outlined,
                    color: Colors.white, size: 32),
                title: Text(
                  'Documentations',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.only(bottom: 20, left: 20),
                leading:
                    Icon(Icons.chat_outlined, color: Colors.white, size: 32),
                title: Text(
                  'Chat',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.only(bottom: 20, left: 20),
                leading: Icon(Icons.archive, color: Colors.white, size: 32),
                title: Text(
                  'Archivement',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 70,
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
        Positioned(
          bottom: 30,
          child: Container(
            padding: EdgeInsets.only(left: 30),
            // width: mq.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleImage(context, "assets/images/avatar-1.jpg", 80, 80),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Dominic test",
                    style: TextStyle(color: whiteColor, fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
