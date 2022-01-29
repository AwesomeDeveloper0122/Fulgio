import 'package:flutter/material.dart';

import 'package:Fuligo/screens/auth/login.dart';
import 'package:Fuligo/widgets/button.dart';
import 'package:Fuligo/widgets/text_header.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/explore.png"),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextHeader(
                      context,
                      "Explore",
                      "Exploer the city through digital city",
                      "guids and exciting video content"),
                ],
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
                        child: CustomButton(context, const Login(), "Next"),
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
