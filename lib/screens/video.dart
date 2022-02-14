// ignore_for_file: sized_box_for_whitespace

import 'package:Fuligo/screens/cancel_tour.dart';
import 'package:Fuligo/screens/keizersgracht.dart';
import 'package:Fuligo/screens/route_screen.dart';
import 'package:Fuligo/utils/font_style.dart';
import 'package:Fuligo/widgets/circleimage.dart';
import 'package:Fuligo/widgets/clear_button.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';
import 'package:Fuligo/widgets/custom_button.dart';
import 'package:Fuligo/widgets/image_detail.dart';
import 'package:Fuligo/widgets/subtxt.dart';

// import 'package:Fuligo/screens/tours.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  VideoScreenState createState() => VideoScreenState();
}

class VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
            image: NetworkImage(
                "https://firebasestorage.googleapis.com/v0/b/project-flugio.appspot.com/o/assets%2F1623336600707_9955.jpg?alt=media&token=75cc95c4-c371-4528-9c0f-b8ef2b73f855"),
            fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   title: Text('TEST'),
        // ),
        body: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [gradientFrom, bgColor]),
              color: bgColor.withOpacity(0.5)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: mq.width,
                height: mq.height,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: mq.height * 0.17,
                    ),
                    TextHeaderTest(
                      context,
                      "VideoScreen",
                      "The Red Light District is the mdieval city center of Amsterdam, known for its canals and narrow streets lined with old-scholl bars,",
                    ),
                  ],
                ),
              ),
              ClearButton(context),
              Positioned(
                bottom: 60,
                child: Row(
                  children: [
                    Container(
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Keizersgracht(),
                            ),
                          ),
                        },
                        child: const Icon(
                          Icons.info_outline,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: () => {},
                        child: const Icon(
                          Icons.play_circle,
                          size: 100,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                          onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RouteScreen(),
                                  ),
                                ),
                              },
                          child: const Icon(
                            Icons.compass_calibration_outlined,
                            size: 50,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: mq.width * 0.9,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Text("widget"),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text("widget"),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Container(
                            height: 2.5,
                            decoration: const BoxDecoration(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 56,
                right: 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Keizersgrachi",
                      style: font_13_white,
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: whiteColor,
                        ),
                        Icon(
                          Icons.favorite,
                          color: whiteColor,
                        ),
                        Icon(
                          Icons.favorite,
                          color: whiteColor,
                        ),
                        Icon(
                          Icons.favorite,
                          color: whiteColor,
                        ),
                        Icon(
                          Icons.favorite_border,
                          color: whiteColor,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
