// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:Fuligo/utils/common_colors.dart';
//Screens
import 'package:Fuligo/screens/tours/tours.dart';
// import 'package:Fuligo/screens/touranother.dart';
// import 'package:Fuligo/screens/cancel_tour.dart';
// import 'package:Fuligo/screens/achievements.dart';

//Widgets
import 'package:Fuligo/widgets/custom_button.dart';
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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/map_test.png"),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  Logo_test,
                ],
              ),
            ),
            Positioned(
              top: 200,
              left: 80,
              child: CircleImage(
                  context,
                  "https://firebasestorage.googleapis.com/v0/b/project-flugio.appspot.com/o/assets%2Fstatic%2Favatar-marieke-harmsen%402x.png?alt=media&token=8043d7f3-347b-457c-abf8-126a79449354",
                  100,
                  100,
                  "starttour"),
            ),
            Positioned(
              top: 400,
              left: 30,
              child: CircleImage(
                  context,
                  "https://firebasestorage.googleapis.com/v0/b/project-flugio.appspot.com/o/assets%2Fstatic%2Favatar-marieke-harmsen%402x.png?alt=media&token=8043d7f3-347b-457c-abf8-126a79449354",
                  100,
                  100,
                  "starttour"),
            ),
// Menu Icon
            Positioned(
              top: 50,
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

            CustomButtonTest(context, const Tours(), "Start tour")
          ],
        ),
      ),
      // appBar: AppBar(
      //   title: Text('TEST'),
      // ),
    );
  }

  void _show() {
    SmartDialog.show(
      widget: MenuScreen(),
    );

    //target widget
  }
}
