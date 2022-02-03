// ignore_for_file: sized_box_for_whitespace

import 'package:Fuligo/screens/start_tour.dart';
import 'package:Fuligo/screens/tours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:Fuligo/utils/common_colors.dart';
//Screens
// import 'package:Fuligo/screens/tours.dart';
// import 'package:Fuligo/screens/touranother.dart';
import 'package:Fuligo/screens/achievements.dart';

//Widgets
import 'package:Fuligo/widgets/custom_button.dart';
import 'package:Fuligo/widgets/logo.dart';
import 'package:Fuligo/widgets/circleimage.dart';
import 'package:Fuligo/screens/menu_screen.dart';

class CancelTour extends StatefulWidget {
  const CancelTour({Key? key}) : super(key: key);

  @override
  CancelTourState createState() => CancelTourState();
}

class CancelTourState extends State<CancelTour> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
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
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  Logo_test,
                ],
              ),
            ),
            // circle image
            Positioned(
              top: 200,
              left: 80,
              child: CircleImage(context, "assets/images/avatar-1.jpg", 80, 80),
            ),
            Positioned(
              top: 400,
              left: 30,
              child: CircleImage(context, "assets/images/avatar-2.jpg", 80, 80),
            ),
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
//Cancel tour
            Positioned(
              bottom: 30,
              child: Container(
                width: mq.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: CanelButton(
                          context, const StartTour(), "Cancel Tour"),
                    ),
                  ],
                ),
              ),
            ),
//video list
            Positioned(
              bottom: 90,
              child: Container(
                width: mq.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 340,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage("assets/images/explore.png"),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.play_arrow,
                          size: 30,
                          color: Colors.white,
                        ),
                        title: Text(
                          'In 250 Meter',
                          // textScaleFactor: 1.5,
                        ),
                        trailing: Icon(
                          Icons.alt_route_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                        subtitle: Text(
                          'Rijksmuseum',
                          textScaleFactor: 1.1,
                          style: TextStyle(color: whiteColor),
                        ),
                        selected: false,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Positioned(
            //   top: 100,
            //   child: ListView(
            //     padding: const EdgeInsets.all(8),
            //     children: const <Widget>[
            //       ListTile(
            //           title: Text("Battery Full"),
            //           subtitle: Text("The battery is full."),
            //           leading: Icon(Icons.battery_full),
            //           trailing: Icon(Icons.star)),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  void _show() {
    SmartDialog.show(
      widget: MenuScreen(),
    );

    //target widget
  }
}
