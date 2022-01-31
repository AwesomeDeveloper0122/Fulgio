// ignore_for_file: sized_box_for_whitespace

import 'package:Fuligo/screens/cancel_tour.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';
import 'package:Fuligo/widgets/custom_button.dart';
import 'package:Fuligo/widgets/image_detail.dart';
import 'package:Fuligo/widgets/subtxt.dart';
import 'package:Fuligo/screens/start_tour.dart';

// import 'package:Fuligo/screens/tours.dart';

class RouteScreen extends StatefulWidget {
  const RouteScreen({Key? key}) : super(key: key);

  @override
  RouteScreenState createState() => RouteScreenState();
}

class RouteScreenState extends State<RouteScreen> {
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
                    "RouteScreen",
                    "Would you like to be taken there?",
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 50),
                    child: CanelButton(
                        context, const StartTour(), "Show directions"),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 30,
              left: mq.width / 2 - 30,
              child: GestureDetector(
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.cancel,
                  size: 70,
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
