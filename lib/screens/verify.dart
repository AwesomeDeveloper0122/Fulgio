import 'package:flutter/material.dart';
import 'package:Fuligo/utils/common_colors.dart';
//Screens
import 'package:Fuligo/screens/first.dart';
//Widgets
import 'package:Fuligo/widgets/button.dart';
import 'package:Fuligo/widgets/textheader.dart';
import 'package:Fuligo/screens/starttour.dart';

class Verify extends StatefulWidget {
  @override
  VerifyState createState() => new VerifyState();
}

class VerifyState extends State<Verify> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: hintColor,
        // appBar: AppBar(
        //   title: Text('TEST'),
        // ),
        body: Stack(
          children: <Widget>[
            TextHeader(context, "Verify",
                "Great! Please verify your e-mail start", ""),
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
                      child: CustomButton(context, StartTour(), "Start tour"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
