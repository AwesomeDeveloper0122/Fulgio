// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

Widget CircleImage(context, String url, double height, double width) =>
    ClipRRect(
      borderRadius: BorderRadius.circular(100.0),
      child: Image(
        image: AssetImage(url),
        height: height,
        width: width,
      ),
    );
