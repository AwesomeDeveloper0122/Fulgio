// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

// ignore: deprecated_member_use
Widget SubTxt(context, String uptxt, String downtxt) => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 10),
          child: Text(
            uptxt,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 10),
          child: Text(
            downtxt,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
