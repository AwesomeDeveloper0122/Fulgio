// ignore_for_file: sized_box_for_whitespace

import 'package:Fuligo/screens/tours/start_tour.dart';
import 'package:Fuligo/screens/tours/tours.dart';
import 'package:Fuligo/screens/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:Fuligo/utils/common_colors.dart';
//Screens
// import 'package:Fuligo/screens/tours.dart';
// import 'package:Fuligo/screens/touranother.dart';
import 'package:Fuligo/screens/achievement/achievements.dart';

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
              child: CircleImage(
                  context,
                  "https://firebasestorage.googleapis.com/v0/b/project-flugio.appspot.com/o/assets%2Fstatic%2Favatar-marieke-harmsen%402x.png?alt=media&token=8043d7f3-347b-457c-abf8-126a79449354",
                  80,
                  80,
                  "tour"),
            ),
            Positioned(
              top: 400,
              left: 30,
              child: CircleImage(
                  context,
                  "https://firebasestorage.googleapis.com/v0/b/project-flugio.appspot.com/o/assets%2Fstatic%2Favatar-marieke-harmsen%402x.png?alt=media&token=8043d7f3-347b-457c-abf8-126a79449354",
                  80,
                  80,
                  "tour"),
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
                      height: mq.height * 0.1,
                      width: mq.width * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/project-flugio.appspot.com/o/assets%2F1623336600707_9955.jpg?alt=media&token=75cc95c4-c371-4528-9c0f-b8ef2b73f855"),
                            fit: BoxFit.fill),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [gradientFrom, bgColor]),
                            color: bgColor.withOpacity(0.6)),
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
                          trailing: Image(
                            image:
                                AssetImage('assets/images/png/icon-route.png'),
                            width: 60,
                            height: 60,
                          ),
                          subtitle: Text(
                            'Rijksmuseum',
                            textScaleFactor: 1.1,
                            style: TextStyle(color: whiteColor),
                          ),
                          selected: false,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const VideoScreen(),
                              ),
                            );
                          },
                        ),
                      ),
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

  void _show() {
    SmartDialog.show(
      widget: MenuScreen(),
    );

    //target widget
  }
}
