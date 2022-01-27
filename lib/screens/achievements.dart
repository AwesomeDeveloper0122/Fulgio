// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';
// import 'package:Fuligo/widgets/button.dart';
// import 'package:Fuligo/widgets/imagedetail.dart';
import 'package:Fuligo/widgets/subtxt.dart';
import 'package:Fuligo/widgets/fuligo_card.dart';

// import 'package:Fuligo/screens/tours.dart';

class Achievements extends StatefulWidget {
  const Achievements({Key? key}) : super(key: key);

  @override
  ArchivmentsState createState() => ArchivmentsState();
}

class ArchivmentsState extends State<Achievements> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: hintColor,
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
                      "Archivements",
                      "Each completed achievement ",
                      "brings you credit on Flugio,"),
                  Container(
                    width: mq.width,
                    margin: const EdgeInsets.only(bottom: 20, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // margin: const EdgeInsets.fromLTRB(0, 0, 80, 0),
                          child: SubTxt(context, 'Achievements', '5 of 75'),
                        ),
                        Container(
                          // margin: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                          child: SubTxt(context, 'Credit', '8 CHF'),
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          FuligoCard(
                              context, "assets/images/1.jpeg", "test", "test"),
                          FuligoCard(
                              context, "assets/images/1.jpeg", "test", "test")
                        ],
                      )
                    ],
                  )
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
                Icons.cancel,
                size: 40,
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
    );
  }
}
