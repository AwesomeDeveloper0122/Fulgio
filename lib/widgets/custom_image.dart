import 'dart:typed_data';

import 'package:Fuligo/routes/route_costant.dart';
import 'package:Fuligo/screens/chat/chat_detail.dart';
import 'package:Fuligo/screens/chat/chat_detail_test.dart';
import 'package:Fuligo/screens/documents/documentdetail.dart';
import 'package:Fuligo/screens/map/map.dart';
import 'package:Fuligo/screens/tours/cancel_tour.dart';
import 'package:Fuligo/screens/video/info.dart';
import 'package:Fuligo/screens/achievement/ranking.dart';
import 'package:Fuligo/screens/tours/tour_list.dart';
import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/utils/font_style.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: non_constant_identifier_names
Widget DocumentCard(
        context, Uint8List image, String title, String content, List list) =>
    GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DocumentDetail(citydetail: list, image_url: image),
          ),
        );
      },
      child: Container(
        width: 370,
        height: 160,
        margin: const EdgeInsets.only(bottom: 40),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: MemoryImage(image, scale: 0.5),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 12,
              // blurStyle: BlurStyle.normal,
              offset: Offset(1, 0), // changes position of shadow
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [gradientFrom, bgColor]),
              color: bgColor.withOpacity(0.35)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: font_20_white,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: 62,
                  height: 2.5,
                  decoration: const BoxDecoration(color: Colors.white54),
                ),
              ),
              Text(
                content,
                style: font_13_white,
              ),
            ],
          ),
        ),
      ),
    );
// ignore: non_constant_identifier_names
Widget ChatCard(
        context, Uint8List image, String title, String content, String docId) =>
    GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, RouteName.tourlist);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailTest(docId: docId),
          ),
        );
      },
      child: Container(
        width: 370,
        height: 160,
        margin: const EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 12,
              // blurStyle: BlurStyle.normal,
              offset: Offset(1, 0), // changes position of shadow
            ),
          ],
          image: new DecorationImage(
            fit: BoxFit.fill,
            image: MemoryImage(image, scale: 0.5),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [gradientFrom, bgColor]),
              color: bgColor.withOpacity(0.35)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: font_20_white,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: 62,
                  height: 2.5,
                  decoration: const BoxDecoration(color: Colors.white54),
                ),
              ),
              Text(
                content,
                style: font_13_white,
              ),
            ],
          ),
        ),
      ),
    );
// ignore: non_constant_identifier_names
Widget TourSmallImage(context, Uint8List image, String title, String content) =>
    GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, RouteName.tourlist);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => Info(),
        //   ),
        // );
      },
      child: Container(
        width: 160,
        height: 140,
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: MemoryImage(image, scale: 0.5),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [gradientFrom, bgColor]),
              color: bgColor.withOpacity(0.35)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: greyColor,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: 30,
                  height: 2.5,
                  decoration: const BoxDecoration(color: greyColor),
                ),
              ),
              Text(
                content,
                style: TextStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
// ignore: non_constant_identifier_names
Widget TourCard(context, Uint8List image, Map each) => GestureDetector(
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('parentID', each["id"]);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TourList(detailData: each),
            // builder: (context) => CancelTour(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 370,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 12,
                    // blurStyle: BlurStyle.normal,
                    offset: Offset(1, 0), // changes position of shadow
                  ),
                ],
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: MemoryImage(image, scale: 0.5),
                ),
              ),
            ),
            Positioned(
              child: Container(
                width: 370,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [gradientFrom, bgColor]),
                    color: bgColor.withOpacity(0.35)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      each["name"].toString(),
                      style: font_20_white,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        width: 62,
                        height: 2.5,
                        decoration: const BoxDecoration(color: Colors.white54),
                      ),
                    ),
                    Text(
                      each["description"].toString(),
                      style: font_13_white,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
