// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/screens/login.dart';
import 'package:Fuligo/widgets/button.dart';
import 'package:Fuligo/widgets/text_header.dart';

class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  FirstState createState() => FirstState();
}

class FirstState extends State<First> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          color: bgColor,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [gradientFrom, bgColor])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          // appBar: AppBar(
          //   title: Text('TEST'),
          // ),
          body: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextHeader(
                      context,
                      "Explore",
                      "Exploer the city through digital city",
                      "guids and exciting video content"),
                ],
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
                        child: CustomButton(context, Login(), "Next"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
