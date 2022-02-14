// ignore_for_file: non_constant_identifier_names

import 'package:Fuligo/routes/route_costant.dart';
import 'package:Fuligo/screens/avatar_screen.dart';
import 'package:Fuligo/screens/keizersgracht.dart';
import 'package:Fuligo/utils/common_functions.dart';
import 'package:Fuligo/utils/loading.dart';
import 'package:flutter/material.dart';

Widget CircleImage(
        context, String url, double height, double width, String str) =>
    Container(
      height: height,
      width: width,
      margin: EdgeInsets.all(20),
      child: InkWell(
        onTap: () {
          switch (str) {
            case "menu":
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AvatarScreen(),
                ),
              );
              break;
            case "tour":
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Keizersgracht(),
                ),
              );
              break;
          }
        },
        // child: CircleAvatar(
        //   backgroundImage: NetworkImage('https://picsum.photos/id/237/200/300'),
        // ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100.0),
          child: Image.network(
            url,
            height: height,
            width: width,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: kLoadingFadingWidget(context),
              );
            },
          ),
        ),
      ),
    );
Widget CircleLocalImage(context, String url) => Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: InkWell(
        onTap: () {
          showConfirm(context, "avatar");

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const AvatarScreen(),
          //   ),
          // );
        },
        child: CircleAvatar(
          backgroundImage: AssetImage(url),
          radius: 100,
        ),
      ),
    );
