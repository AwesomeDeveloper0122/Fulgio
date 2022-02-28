import 'dart:typed_data';

import 'package:Fuligo/routes/route_costant.dart';
import 'package:Fuligo/screens/chat/chat_detail.dart';
import 'package:Fuligo/screens/documents/documentdetail.dart';
import 'package:Fuligo/screens/video/info.dart';
import 'package:Fuligo/screens/achievement/ranking.dart';
import 'package:Fuligo/screens/tours/tour_list.dart';
import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/utils/font_style.dart';

import 'package:flutter/material.dart';

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
        width: 350,
        height: 160,
        margin: const EdgeInsets.only(top: 40),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: MemoryImage(image, scale: 0.5),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [gradientFrom, bgColor]),
              color: bgColor.withOpacity(0.5)),
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
            builder: (context) => ChatDetail(docId: docId),
          ),
        );
      },
      child: Container(
        width: 350,
        height: 140,
        margin: const EdgeInsets.only(top: 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          image: new DecorationImage(
            fit: BoxFit.fill,
            // image: MemoryImage(imageData, scale: 0.5),
            image: MemoryImage(image, scale: 0.5),
          ),
        ),
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: NetworkImage(url),
        //     fit: BoxFit.fill,
        //   ),
        //   borderRadius: BorderRadius.circular(25.0),
        // ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [gradientFrom, bgColor]),
              color: bgColor.withOpacity(0.5)),
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
              color: bgColor.withOpacity(0.4)),
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
