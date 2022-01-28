// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:Fuligo/utils/common_colors.dart';
//Screens
// import 'package:Fuligo/screens/tours.dart';
// import 'package:Fuligo/screens/touranother.dart';
import 'package:Fuligo/screens/achievements.dart';

//Widgets
import 'package:Fuligo/widgets/button.dart';
import 'package:Fuligo/widgets/logo.dart';
import 'package:Fuligo/widgets/circleimage.dart';

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
            top: 60,
            left: 20,
            child: GestureDetector(
              onTap: () {
                print("onTap called.");
              },
              child: const Icon(
                Icons.menu,
                size: 40,
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
                    child: CustomButton(
                        context, const Achievements(), "Start tour"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
