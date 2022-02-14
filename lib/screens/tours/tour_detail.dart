// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
// import 'package:Fuligo/widgets/text_header.dart';
// import 'package:Fuligo/widgets/image.dart';

class TourDetail extends StatefulWidget {
  const TourDetail({Key? key}) : super(key: key);

  @override
  TourDetailState createState() => TourDetailState();
}

class TourDetailState extends State<TourDetail> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Container(
      width: mq.width,
      height: mq.height,
      decoration: const BoxDecoration(
        color: bgColor,
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [gradientFrom, bgColor]),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            width: mq.width,
            child: Stack(
              children: [
                Positioned(
                  top: 60,
                  left: 20,
                  child: GestureDetector(
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.clear,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  left: mq.width - 150,
                  child: Container(
                    width: mq.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 350,
                          height: 50,
                          child: Text("Keizersgracht"),
                        ),
                        Container(
                          width: 350,
                          height: 50,
                          child: Text("123"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
