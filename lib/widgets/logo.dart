import 'package:flutter/material.dart';
import 'package:Fuligo/utils/common_colors.dart';

Widget Logo(context) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 5, 0),
          child: Container(
            margin: const EdgeInsets.only(top: 50, bottom: 30),
            child: Icon(
              Icons.settings,
              color: Colors.red,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 5, 0),
          child: Container(
            margin: const EdgeInsets.only(top: 50, bottom: 30),
            child: Text(
              "FULIGO",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: whiteColor),
            ),
          ),
        ),
      ],
    );
