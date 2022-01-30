// ignore_for_file: sized_box_for_whitespace

import 'package:Fuligo/screens/cancel_tour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:Fuligo/utils/common_colors.dart';
//Screens
// import 'package:Fuligo/screens/tours.dart';
// import 'package:Fuligo/screens/touranother.dart';
import 'package:Fuligo/screens/achievements.dart';

//Widgets
import 'package:Fuligo/widgets/button.dart';
import 'package:Fuligo/widgets/logo.dart';
import 'package:Fuligo/widgets/circleimage.dart';
import 'package:Fuligo/screens/menu_screen.dart';

class StartTour extends StatefulWidget {
  const StartTour({Key? key}) : super(key: key);

  @override
  StartTourState createState() => StartTourState();
}

class StartTourState extends State<StartTour> {
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
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Logo(context),
          ),
          // circle image
          Positioned(
            top: 200,
            left: 80,
            child: CircleImage(context, "assets/images/avatar-1.jpg", 100, 100),
          ),
          Positioned(
            top: 400,
            left: 30,
            child: CircleImage(context, "assets/images/avatar-2.jpg", 100, 100),
          ),
          Positioned(
            top: 70,
            left: 20,
            child: GestureDetector(
              onTap: () => {_show()},
              child: const Icon(
                Icons.menu,
                size: 50,
                color: Colors.white,
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
                    child:
                        CustomButton(context, const CancelTour(), "Start tour"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _show() {
    SmartDialog.show(
      widget: MenuScreen(context),
    );

    //target widget
  }
}
