import 'package:Fuligo/screens/achievement/achievement_detail.dart';
import 'package:Fuligo/screens/chat/chat.dart';
import 'package:flutter/material.dart';
import 'route_costant.dart';

import 'package:Fuligo/screens/auth/login.dart';
import 'package:Fuligo/screens/verify.dart';
import 'package:Fuligo/screens/tours/start_tour.dart';
import 'package:Fuligo/screens/tours/tour_list.dart';
import 'package:Fuligo/screens/tours/tour_detail.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteName.Login:
      return MaterialPageRoute(builder: (context) => const Login());
    case RouteName.Verify:
      return MaterialPageRoute(builder: (context) => const Verify());
    case RouteName.Startour:
      return MaterialPageRoute(builder: (context) => const StartTour());
    // case RouteName.tourlist:
    //   return MaterialPageRoute(builder: (context) => const TourList());
    case RouteName.tourdetail:
      return MaterialPageRoute(builder: (context) => const TourDetail());
    // case RouteName.chat:
    //   return MaterialPageRoute(builder: (context) => const Chat());
    // case RouteName.achievementDetail:
    //   return MaterialPageRoute(
    //       builder: (context) => const ArchivementsDetail());

    default:
      return MaterialPageRoute(builder: (context) => const Verify());
  }
}
