import 'package:flutter/material.dart';
import 'package:Fuligo/utils/common_colors.dart';

// ignore: non_constant_identifier_names
Widget FuligoCard(context, String content) => Container(
    width: 165,
    height: 130,
    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
    decoration: BoxDecoration(
      color: bgColor,
      gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [gradientFrom, bgColor]),
      borderRadius: BorderRadius.circular(25.0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Icon(
            Icons.audiotrack,
            color: Colors.grey,
            size: 30.0,
          ),
        ),
        Text(
          content,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    ));
