// ignore_for_file: sized_box_for_whitespace

import 'package:Fuligo/widgets/clear_button.dart';
import 'package:Fuligo/widgets/custom_button.dart';
import 'package:Fuligo/widgets/custom_image.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';
import 'package:Fuligo/widgets/image_detail.dart';
import 'package:Fuligo/widgets/subtxt.dart';

class TourAnother extends StatefulWidget {
  const TourAnother({Key? key}) : super(key: key);

  @override
  TourAnotherState createState() => TourAnotherState();
}

class TourAnotherState extends State<TourAnother> {
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
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
                width: mq.width,
                height: mq.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 60, 20, 0),
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: SubTxt(context, 'Remaining', '42min'),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: SubTxt(context, 'Stops', '4 / 7'),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            CrossButton(context),
            Positioned(
              bottom: 30,
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
                    // TourSmallImage(context, "assets/images/1.jpeg", "Red right",
                    //     "Amsterdam"),
                    // TourSmallImage(context, "assets/images/1.jpeg", "Old town",
                    //     "Amsterdam"),
                    // TourSmallImage(context, "assets/images/1.jpeg", "Old town",
                    //     "Amsterdam")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
