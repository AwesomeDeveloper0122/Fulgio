import 'package:flutter/material.dart';
import 'package:Fuligo/utils/common_colors.dart';
//Screens

//Widgets
import 'package:Fuligo/widgets/button.dart';
import 'package:Fuligo/widgets/text_header.dart';
import 'package:Fuligo/screens/start_tour.dart';

class Verify extends StatefulWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  VerifyState createState() => VerifyState();
}

class VerifyState extends State<Verify> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/discover.png"),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          // appBar: AppBar(
          //   title: Text('TEST'),
          // ),
          body: Stack(
            children: <Widget>[
              TextHeader(context, "Verify",
                  "Great! Please verify your e-mail start", ""),
              Center(
                child: Container(
                  height: 400.0,
                  width: 230.0,
                  margin: const EdgeInsets.only(top: 120),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Column(
                        children: const [
                          Text(
                            "Allow to use your ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            "location?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            "Turning on location services allows us",
                            style: TextStyle(
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            "to show you whe pals are nearby..",
                            style: TextStyle(
                              fontSize: 11,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                child: SizedBox(
                  width: mq.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: CustomButton(
                            context, const StartTour(), "Start tour"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
