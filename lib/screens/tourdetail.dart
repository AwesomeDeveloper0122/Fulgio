// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/textheader.dart';
import 'package:Fuligo/widgets/image.dart';

class TourDetail extends StatefulWidget {
  @override
  TourDetailState createState() => TourDetailState();
}

class TourDetailState extends State<TourDetail> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: hintColor,
      // appBar: AppBar(
      //   title: Text('TEST'),
      // ),
      body: Stack(
        children: [
          Container(
              width: mq.width,
              height: mq.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextHeader1(context, "Tours", "Dicovery the city with one of",
                      "our digital travel tours"),
                  ImageCustom(context, "assets/images/1.jpeg", "Red right",
                      "Amsterdam"),
                  ImageCustom(
                      context, "assets/images/1.jpeg", "Old town", "Amsterdam"),
                ],
              )),
          Positioned(
            top: 60,
            left: 20,
            child: GestureDetector(
              onTap: () {
                // ignore: avoid_print
                print("onTap called.");
              },
              child: const Icon(
                Icons.cancel,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
          // Positioned(
          //   bottom: 50,
          //   child: Container(
          //     width: mq.width,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Container(
          //           width: 350,
          //           height: 50,
          //           child: CustomButton(context, Tours(), "Start tour"),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
