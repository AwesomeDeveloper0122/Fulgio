// ignore_for_file: non_constant_identifier_names

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/utils/font_style.dart';
import 'package:flutter/material.dart';

Widget ChatTest(context, String url) => Container(
      width: 200,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(20)),
      child: Text(url, style: font_14_white),
    );
