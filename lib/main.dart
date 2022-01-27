import 'package:Fuligo/screens/landing_page.dart';
import 'package:flutter/material.dart';
// import 'package:Fuligo/screens/first.dart';

// import 'package:testproject/widgets/landing_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fulgio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Noto_Sans_JP',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LandingPage(),
      // routes: routes,
    );
  }
}
