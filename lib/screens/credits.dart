// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';
// import 'package:Fuligo/widgets/button.dart';
// import 'package:Fuligo/widgets/imagedetail.dart';
import 'package:Fuligo/widgets/subtxt.dart';
import 'package:Fuligo/widgets/fuligo_card.dart';

// import 'package:Fuligo/screens/tours.dart';

class Credits extends StatefulWidget {
  const Credits({Key? key}) : super(key: key);

  @override
  CreditsState createState() => CreditsState();
}

class CreditsState extends State<Credits> {
  @override
  Widget build(BuildContext context) {
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
                    "Credits",
                    "Your credit will be automatically applied \n to your next booking with Flugio. \n No actions are required",
                  ),
                  Container(
                    width: mq.width,
                    margin: const EdgeInsets.only(bottom: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: mq.width / 2,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SubTxt(context, 'Available', 'CHF 8'),
                        ),
                        Container(
                          width: mq.width / 2,
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: SubTxt(context, 'Used', 'CHF 4'),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: bgColor,
                            gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [gradientFrom, bgColor]),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            leading: Icon(Icons.location_on_outlined,
                                color: Colors.white, size: 32),
                            title: Text(
                              'Zurich-Amsterdam',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            subtitle: Text(
                              '11-02-2021 | -2 CHF',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                            onTap: () => {
                              // Navigator.pushNamed(context, RouteName.Startour),
                              print("object"),
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: bgColor,
                            gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [gradientFrom, bgColor]),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            leading: Icon(Icons.location_on_outlined,
                                color: Colors.white, size: 32),
                            title: Text(
                              'Zurich-Amsterdam',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            subtitle: Text(
                              '11-02-2021 | -2 CHF',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                            onTap: () => {
                              // Navigator.pushNamed(context, RouteName.Startour),
                              print("object"),
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

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
