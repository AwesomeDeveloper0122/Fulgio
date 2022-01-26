// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/textheader.dart';
import 'package:Fuligo/widgets/button.dart';
import 'package:Fuligo/widgets/imagedetail.dart';
import 'package:Fuligo/widgets/subtxt.dart';

import 'package:Fuligo/screens/tours.dart';

class TourAnother extends StatefulWidget {
  const TourAnother({Key? key}) : super(key: key);

  @override
  TourAnotherState createState() => TourAnotherState();
}

class TourAnotherState extends State<TourAnother> {
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
              padding: const EdgeInsets.only(right: 20, left: 20),
              width: mq.width,
              height: mq.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 60, 20, 0),
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SubTxt(context, 'Remaining', '42min'),
                        SubTxt(context, 'Stops', '4/7'),
                      ],
                    ),
                  ),
                  TextHeader1(
                      context,
                      "Another",
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
                        )
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
            bottom: 50,
            child: Container(
              padding: const EdgeInsets.only(right: 20, left: 20),
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
          //           child: CustomButton(context, const Tours(), "Start tour"),
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
