// ignore_for_file: non_constant_identifier_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/logo.dart';

Widget TextHeader(context, String txt1, String txt2, String txt3) => Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Logo(context),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Text(
            txt1,
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: whiteColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
          child: Container(
            width: 70,
            height: 2,
            decoration: const BoxDecoration(color: Colors.green),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 2),
          child: Text(
            txt2,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: whiteColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Text(
            txt3,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: whiteColor,
            ),
          ),
        ),
      ],
    );

Widget TextHeader1(context, String txt1, String txt2, String txt3) => Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Container(
            child: Text(
              txt1,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: whiteColor),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
          child: Container(
            width: 70,
            height: 2,
            decoration: const BoxDecoration(color: Colors.green),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 2),
          child: Text(
            txt2,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: whiteColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Text(
            txt3,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: whiteColor,
            ),
          ),
        ),
      ],
    );
