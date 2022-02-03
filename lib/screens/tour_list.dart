// ignore_for_file: sized_box_for_whitespace

import 'package:Fuligo/screens/cancel_tour.dart';
import 'package:Fuligo/widgets/clear_button.dart';
import 'package:Fuligo/widgets/custom_image.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';
import 'package:Fuligo/widgets/custom_button.dart';
import 'package:Fuligo/widgets/image_detail.dart';
import 'package:Fuligo/widgets/subtxt.dart';

import 'package:Fuligo/screens/tours.dart';

class TourList extends StatefulWidget {
  const TourList({Key? key}) : super(key: key);

  @override
  TourListState createState() => TourListState();
}

class TourListState extends State<TourList> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Container(
      decoration: bgDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   title: Text('TEST'),
        // ),
        body: Container(
          child: Stack(
            alignment: Alignment.center,
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
                        "Red Light",
                        "The Red Light District is the mdieval city \n center of Amsterdam, known for its canals\n and narrow streets lined with old-scholl bars, \n exotic nightclubs and brothels surrouned by \n neo-lit red lights",
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 60),
                              child: SubTxt(context, 'Stops', '7'),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 60),
                              child: SubTxt(context, 'Stops', '7'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              ClearButton(context),
              Positioned(
                bottom: 100,
                left: 20,
                child: SizedBox(
                  height: 140,
                  // padding: const EdgeInsets.only(right: 20, left: 20),
                  width: mq.width,
                  child: ListView(
                    shrinkWrap: true,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      TourSmallImage(context, "assets/images/1.jpeg",
                          "Red right", "Amsterdam"),
                      TourSmallImage(context, "assets/images/1.jpeg",
                          "Old town", "Amsterdam"),
                      TourSmallImage(context, "assets/images/1.jpeg",
                          "Old town", "Amsterdam")
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                child: Container(
                  width: mq.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 350,
                        height: 50,
                        child: CustomButton(
                            context, const CancelTour(), "Start tour"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
