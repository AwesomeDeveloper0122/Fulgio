// ignore_for_file: non_constant_identifier_names

import 'package:Fuligo/routes/route_costant.dart';
import 'package:Fuligo/screens/avatar_screen.dart';
import 'package:Fuligo/screens/keizersgracht.dart';
import 'package:Fuligo/video/video.dart';
import 'package:Fuligo/video/videotest.dart';
import 'package:Fuligo/utils/common_colors.dart';
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
        child: ClipOval(
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
          showConfirm(context, "avatar", url);

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

Widget CircleNetworkImage(context, Map data) => Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: GestureDetector(
        onTap: () {
          // showConfirm(context, "avatar", url);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideoScreen(
                mediadata: data,
              ),
              // builder: (context) => VideoPlayerScreen(),
            ),
          );
        },
        child: ClipOval(
          child: Image.network(
            data["image"][0],
            width: 100,
            height: 100,
            fit: BoxFit.cover,
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
        // child: Container(
        //   width: 80.0,
        //   height: 80.0,
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: NetworkImage(data["image"][0]),
        //       fit: BoxFit.cover,
        //     ),
        //     borderRadius: BorderRadius.all(Radius.circular(50.0)),
        //   ),
        //   child: Container(
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.all(Radius.circular(50.0)),
        //         gradient: const LinearGradient(
        //             begin: Alignment.topLeft,
        //             end: Alignment.bottomRight,
        //             colors: [gradientFrom, bgColor]),
        //         color: bgColor.withOpacity(0.3)),
        //   ),
        // ),
      ),
    );
