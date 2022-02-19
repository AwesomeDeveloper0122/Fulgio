// ignore_for_file: non_constant_identifier_names

import 'package:Fuligo/routes/route_costant.dart';
import 'package:Fuligo/screens/avatar_screen.dart';
import 'package:Fuligo/screens/keizersgracht.dart';
import 'package:Fuligo/video/audio.dart';
import 'package:Fuligo/video/video.dart';
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
                  builder: (context) => Keizersgracht(
                    infodata: {},
                  ),
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
        child: Container(
          child: ClipOval(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 3, color: whiteColor),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Image.network(
                data["image"][0],
                width: 100,
                height: 100,
                fit: BoxFit.fill,
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
        ),
      ),
    );
Widget CircleAudioImage(context, Map data) => Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: GestureDetector(
        onTap: () {
          // showConfirm(context, "avatar", url);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AudioScreen(
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
      ),
    );
