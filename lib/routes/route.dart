import 'package:flutter/material.dart';
import 'package:Fuligo/screens/verify.dart';
import 'package:Fuligo/screens/auth/login.dart';
import 'route_costant.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteName.Verify:
      return MaterialPageRoute(builder: (context) => const Verify());
    case RouteName.Login:
      return MaterialPageRoute(builder: (context) => const Login());
    // case 'login':
    //   return MaterialPageRoute(builder: (context) => LoginView());
    default:
      return MaterialPageRoute(builder: (context) => const Verify());
  }
}
