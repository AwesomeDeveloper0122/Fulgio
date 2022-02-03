// ignore_for_file: sized_box_for_whitespace

import 'package:Fuligo/widgets/clear_button.dart';
import 'package:Fuligo/widgets/logo.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';
import 'package:Fuligo/widgets/custom_image.dart';

class Tours extends StatefulWidget {
  const Tours({Key? key}) : super(key: key);

  @override
  ToursState createState() => ToursState();
}

class ToursState extends State<Tours> {
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
                  SizedBox(
                    height: mq.height * 0.17,
                  ),
                  TextHeaderTest(
                    context,
                    "Tours",
                    "Dicovery the city with one of \n our digital travel tours",
                  ),
                  TourBigImage(context, "assets/images/1.jpeg", "Red right",
                      "Amsterdam"),
                  TourBigImage(
                      context, "assets/images/1.jpeg", "Old town", "Amsterdam"),
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
