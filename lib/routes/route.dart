import 'package:Fuligo/screens/chat/chat.dart';
import 'package:flutter/material.dart';
import 'route_costant.dart';

import 'package:Fuligo/screens/auth/login.dart';
import 'package:Fuligo/screens/verify.dart';
import 'package:Fuligo/screens/start_tour.dart';
import 'package:Fuligo/screens/tour_list.dart';
import 'package:Fuligo/screens/tour_detail.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteName.Login:
      return MaterialPageRoute(builder: (context) => const Login());
    case RouteName.Verify:
      return MaterialPageRoute(builder: (context) => const Verify());
    case RouteName.Startour:
      return MaterialPageRoute(builder: (context) => const StartTour());
    case RouteName.tourlist:
      return MaterialPageRoute(builder: (context) => const TourList());
    case RouteName.tourdetail:
      return MaterialPageRoute(builder: (context) => const TourDetail());
    case RouteName.chat:
      return MaterialPageRoute(builder: (context) => const Chat());

    default:
      return MaterialPageRoute(builder: (context) => const Verify());
  }
}
