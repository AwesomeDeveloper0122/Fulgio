// ignore_for_file: non_constant_identifier_names

import 'package:Fuligo/routes/route_costant.dart';
import 'package:flutter/material.dart';

Widget CircleImage(context, String url, double height, double width) => InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteName.tourdetail);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: Image(
          image: AssetImage(url),
          height: height,
          width: width,
        ),
      ),
    );
