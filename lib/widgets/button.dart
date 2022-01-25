import 'package:flutter/material.dart';
import 'package:Fuligo/utils/common_colors.dart';

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
        style: TextStyle(
          fontSize: 16,
          color: whiteColor,
        ),
      ),
    );
