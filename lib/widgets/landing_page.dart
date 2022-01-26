// ignore: file_names
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow,
        appBar: AppBar(title: const Text('Set Full Screen Background Image')),
        body: Center(
            child: Container(
                constraints: const BoxConstraints.expand(),
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //         image: AssetImage("images/1.jpeg"),
                //         fit: BoxFit.cover)),
                child: const Center(
                  child: Image(image: AssetImage('assets/images/mark.png')),
                  // child: Text(
                  //   'Set Full Screen Background Image in Flutter',
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //       color: Colors.brown,
                  //       fontSize: 25,
                  //       fontWeight: FontWeight.bold),
                  // ),
                ))));
  }
}
