// ignore_for_file: sized_box_for_whitespace

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
                  Icons.clear_rounded,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              child: Container(
                padding: const EdgeInsets.only(right: 20, left: 20),
                width: mq.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TourSmallImage(context, "assets/images/1.jpeg", "Red right",
                        "Amsterdam"),
                    TourSmallImage(context, "assets/images/1.jpeg", "Old town",
                        "Amsterdam"),
                    TourSmallImage(context, "assets/images/1.jpeg", "Old town",
                        "Amsterdam")
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
      ),
    );
  }
}
