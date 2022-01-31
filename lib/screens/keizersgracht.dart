// ignore_for_file: sized_box_for_whitespace

import 'package:Fuligo/screens/cancel_tour.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';
import 'package:Fuligo/widgets/button.dart';
import 'package:Fuligo/widgets/image_detail.dart';
import 'package:Fuligo/widgets/subtxt.dart';

// import 'package:Fuligo/screens/tours.dart';

class Keizersgracht extends StatefulWidget {
  const Keizersgracht({Key? key}) : super(key: key);

  @override
  KeizersgrachtState createState() => KeizersgrachtState();
}

class KeizersgrachtState extends State<Keizersgracht> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: bgColor,
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [gradientFrom, bgColor]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    TextHeader1(
                      context,
                      "Keizersgracht",
                      "The Red Light District is the mdieval city center of Amsterdam, known for its canals and narrow streets lined with old-scholl bars,",
                    ),
                  ],
                )),
            Positioned(
              bottom: 30,
              left: mq.width / 2 - 30,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.cancel,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
