import 'package:flutter/material.dart';
import 'package:Fuligo/utils/common_colors.dart';
//Screens
import 'package:Fuligo/screens/first.dart';
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
