import 'package:flutter/material.dart';
import 'package:Fuligo/routes/route_costant.dart';

// ignore: non_constant_identifier_names
Widget MapButton(context, String txt) => InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        width: 400,

        // height: 50,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0, color: Color(0xFF7F7F7F)),
            // left: BorderSide(
            //     width: 1.0, color: Color(0xFFDFDFDF)),
            // right: BorderSide(
            //     width: 1.0, color: Color(0xFF7F7F7F)),
            // bottom: BorderSide(
            //   width: 1.0,
            //   color: Color(0xFF7F7F7F),
            // ),
          ),
        ),

        child: Text(
          txt,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.blue),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, RouteName.Startour);
      },
    );
