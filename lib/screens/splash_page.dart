import 'dart:async';
import 'package:flutter/material.dart';
import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/screens/home.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
