import 'package:Fuligo/screens/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:Fuligo/routes/route.dart' as router;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

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
        home: const SplashPage(),
        onGenerateRoute: router.generateRoute);
  }
}
