// @dart=2.9

// import 'package:Fuligo/screens/tour_another.dart';
// import 'package:Fuligo/screens/route_screen.dart';
// import 'package:Fuligo/screens/chat/chat.dart';
// import 'package:Fuligo/screens/chat/chat_content.dart';
// import 'package:Fuligo/screens/credits.dart';
import 'package:Fuligo/provider/auth_provider.dart';
import 'package:Fuligo/screens/splash_page.dart';
// import 'package:Fuligo/screens/chat/chat_content.dart';
import 'package:Fuligo/test.dart';
import 'package:flutter/material.dart';
import 'package:Fuligo/routes/route.dart' as router;
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

// import 'package:Fuligo/screens/splash_page.dart';
import 'package:provider/provider.dart';

// import 'package:Fuligo/screens/keizersgracht.dart';
// import 'package:Fuligo/screens/route_screen.dart';
// import 'package:Fuligo/screens/achievements.dart';
// import 'package:Fuligo/screens/success.dart';
// import 'package:Fuligo/screens/ranking.dart';
// import 'package:Fuligo/screens/avatar_screen.dart';
// import 'package:Fuligo/screens/chat/chat.dart';
// import 'package:Fuligo/screens/home.dart';
// import 'package:Fuligo/test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({key}) : super(key: key);

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
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          // statusBarColor: AppColors.statusbarColor,
          //color set to transperent or set your own color
          // statusBarIconBrightness: Brightness.light,
          //set brightness for icons, like dark background light icons
          ),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
          title: 'Fulgio',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Noto_Sans_JP',
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: SplashPage(),
          builder: FlutterSmartDialog.init(),
          onGenerateRoute: router.generateRoute),
    );
  }
}
