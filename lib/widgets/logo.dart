// ignore_for_file: non_constant_identifier_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
// import 'package:Fuligo/utils/common_colors.dart';

Widget Logo(context) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 5, 0),
          child: Container(
            margin: const EdgeInsets.only(top: 50, bottom: 20),
            child: const Image(
              image: AssetImage('assets/images/logo.png'),
              width: 100,
              height: 60,
            ),
          ),
        ),
      ],
    );
