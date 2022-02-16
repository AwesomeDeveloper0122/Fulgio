import 'package:Fuligo/routes/route_costant.dart';
import 'package:Fuligo/screens/chat/chat_again.dart';
import 'package:Fuligo/screens/documents/documentdetail.dart';
import 'package:Fuligo/screens/keizersgracht.dart';
import 'package:Fuligo/screens/achievement/ranking.dart';
import 'package:Fuligo/screens/tours/tour_list.dart';
import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/utils/font_style.dart';

import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget TourBigImage(context, String url, String title, String content,
        bool ischat, List list) =>
    GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DocumentDetail(citydetail: list),
          ),
        );
      },
      child: Container(
        width: 350,
        height: 140,
        margin: const EdgeInsets.only(top: 40),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
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
                  decoration: const BoxDecoration(color: Colors.grey),
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
Widget ChatCard(context, String url, String title, String content, bool ischat,
        String docId) =>
    GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, RouteName.tourlist);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatAgain(docId: docId),
          ),
        );
      },
      child: Container(
        width: 350,
        height: 140,
        margin: const EdgeInsets.only(top: 40),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
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
                  decoration: const BoxDecoration(color: Colors.grey),
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
Widget TourSmallImage(context, String url, String title, String content) =>
    GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, RouteName.tourlist);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => Keizersgracht(),
        //   ),
        // );
      },
      child: Container(
        width: 160,
        height: 140,
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(url),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
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
    );
