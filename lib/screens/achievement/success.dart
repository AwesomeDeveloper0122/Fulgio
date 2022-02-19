// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';
// import 'package:Fuligo/widgets/button.dart';
// import 'package:Fuligo/widgets/imagedetail.dart';
import 'package:Fuligo/widgets/subtxt.dart';
import 'package:Fuligo/widgets/custom_button.dart';
// import 'package:Fuligo/widgets/fuligo_card.dart';
import 'package:Fuligo/screens/achievement/credits.dart';

// import 'package:Fuligo/screens/tours.dart';

class Sucess extends StatefulWidget {
  const Sucess({Key? key}) : super(key: key);

  @override
  SucessState createState() => SucessState();
}

class SucessState extends State<Sucess> {
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
              padding: const EdgeInsets.only(right: 0, left: 0),
              width: mq.width,
              height: mq.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  TextHeader1(
                    context,
                    "Sucess",
                    "You finished an achievement",
                  ),
                  Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 60),
                      decoration: BoxDecoration(
                        color: bgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Image.asset(
                              'assets/images/png/icon-umbrella.png',
                              height: 100,
                              width: 100,
                            ),
                          ),
                          Text(
                            "123",
                            style: TextStyle(color: whiteColor, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 100,
              child: Container(
                width: mq.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "You have earned CHF 1",
                      style: TextStyle(
                          color: whiteColor, fontSize: 12, letterSpacing: 1.5),
                    ),
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
                          context,
                          Credits(
                            arch_list: [],
                          ),
                          "Close"),
                    ),
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
