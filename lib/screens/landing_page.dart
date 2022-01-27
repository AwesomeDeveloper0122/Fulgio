// ignore: file_names
import 'package:flutter/material.dart';
import 'package:Fuligo/utils/common_colors.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: bgColor,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [gradientFrom, bgColor])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(title: const Text('Set Full Screen Background Image')),
        body: Center(
          child: Container(
            constraints: const BoxConstraints.expand(),
            child: const Center(
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                width: 200,
                height: 100,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
