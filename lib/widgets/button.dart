// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:Fuligo/utils/common_colors.dart';

// ignore: deprecated_member_use
Widget CustomButton(context, StatefulWidget page, String txt) => RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      color: btnbackgroundColor,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      },
      textColor: Colors.white,
      child: Text(
        txt,
        style: const TextStyle(
          fontSize: 16,
          color: whiteColor,
        ),
      ),
    );
