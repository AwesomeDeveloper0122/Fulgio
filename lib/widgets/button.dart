// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:Fuligo/utils/common_colors.dart';

// ignore: deprecated_member_use
Widget CustomButton(context, StatefulWidget page, String txt) => SizedBox(
      height: 50,
      width: 340,
      // ignore: deprecated_member_use
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        color: bgColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ),
          );
        },
        textColor: bgColor,
        child: Text(
          txt,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
