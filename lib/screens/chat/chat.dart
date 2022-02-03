// ignore_for_file: sized_box_for_whitespace

import 'package:Fuligo/widgets/clear_button.dart';
import 'package:Fuligo/widgets/logo.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';
import 'package:Fuligo/widgets/custom_image.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Container(
      decoration: bgDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              width: mq.width,
              height: mq.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Logo_test,
                  TextHeaderTest(
                    context,
                    "Chat",
                    "For which order do you need support?",
                  ),
                  TourBigImage(
                      context, "assets/images/1.jpeg", "Porto", "03-06-2021"),
                  TourBigImage(context, "assets/images/1.jpeg", "Amsterdam",
                      "05-11-2021"),
                ],
              ),
            ),
            ClearButton(context),
          ],
        ),
      ),
    );
  }
}
