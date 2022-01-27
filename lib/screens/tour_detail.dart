// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';
import 'package:Fuligo/widgets/button.dart';
import 'package:Fuligo/widgets/image_detail.dart';
import 'package:Fuligo/widgets/subtxt.dart';

import 'package:Fuligo/screens/tours.dart';

class TourDetail extends StatefulWidget {
  const TourDetail({Key? key}) : super(key: key);

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
              padding: EdgeInsets.only(right: 20, left: 20),
              width: mq.width,
              height: mq.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextHeader1(
                      context,
                      "Red Light",
                      "The Red Light District is the mdieval city ",
                      "and narrow streetes lined with old-school bars,"),
                  Container(
                    padding: const EdgeInsets.fromLTRB(40, 30, 40, 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(30, 20, 60, 20),
                          child: SubTxt(context, 'Stops', '7'),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(60, 20, 30, 20),
                          child: SubTxt(context, 'Stops', '7'),
                        ),
                      ],
                    ),
                  )
                ],
              )),
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
                Icons.cancel,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 110,
            child: Container(
              padding: EdgeInsets.only(right: 20, left: 20),
              width: mq.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ImageDetail(context, "assets/images/1.jpeg", "Red right",
                      "Amsterdam"),
                  ImageDetail(
                      context, "assets/images/1.jpeg", "Old town", "Amsterdam"),
                  ImageDetail(
                      context, "assets/images/1.jpeg", "Old town", "Amsterdam")
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            child: Container(
              width: mq.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 350,
                    height: 50,
                    child: CustomButton(context, const Tours(), "Start tour"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
