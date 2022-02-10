// ignore_for_file: sized_box_for_whitespace

import 'package:Fuligo/widgets/circleimage.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';
// import 'package:Fuligo/widgets/button.dart';
// import 'package:Fuligo/widgets/imagedetail.dart';
import 'package:Fuligo/widgets/subtxt.dart';
import 'package:Fuligo/widgets/fuligo_card.dart';

// import 'package:Fuligo/screens/tours.dart';

class AvatarScreen extends StatefulWidget {
  const AvatarScreen({Key? key}) : super(key: key);

  @override
  AvatarScreenState createState() => AvatarScreenState();
}

class AvatarScreenState extends State<AvatarScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> avatarList = [];
    for (var i = 0; i < 6; i++) {
      avatarList.add(
        CircleLocalImage(context, "assets/images/avatar-1.jpg"),
      );
    }
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
                // width: 400,
                // height: mq.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    TextHeader1(
                      context,
                      "Avatar",
                      "Choose your avatar",
                    ),
                    Container(
                      width: mq.width,
                      height: mq.height * 0.7,
                      margin: const EdgeInsets.only(bottom: 10, top: 10),
                      child: GridView.count(
                          padding: const EdgeInsets.all(60),
                          crossAxisCount: 2,
                          children: avatarList),
                    ),
                  ],
                )),
            Positioned(
              top: 60,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.clear,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            // Positioned(
            //   bottom: 50,
            //   child: Container(
            //     padding: const EdgeInsets.only(right: 20, left: 20),
            //     width: mq.width,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         ImageDetail(context, "assets/images/1.jpeg", "Red right",
            //             "Amsterdam"),
            //         ImageDetail(
            //             context, "assets/images/1.jpeg", "Old town", "Amsterdam"),
            //         ImageDetail(
            //             context, "assets/images/1.jpeg", "Old town", "Amsterdam")
            //       ],
            //     ),
            //   ),
            // ),
            // Positioned(
            //   bottom: 50,
            //   child: Container(
            //     width: mq.width,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Container(
            //           width: 350,
            //           height: 50,
            //           child: CustomButton(context, const Tours(), "Start tour"),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
