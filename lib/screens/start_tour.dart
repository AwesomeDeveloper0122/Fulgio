// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:Fuligo/utils/common_colors.dart';
//Screens
import 'package:Fuligo/screens/tours.dart';
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
              child:
                  CircleImage(context, "assets/images/avatar-1.jpg", 100, 100),
            ),
            Positioned(
              top: 400,
              left: 30,
              child:
                  CircleImage(context, "assets/images/avatar-2.jpg", 100, 100),
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
