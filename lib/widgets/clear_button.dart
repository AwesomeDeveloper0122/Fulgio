// ignore_for_file: non_constant_identifier_names

import 'package:Fuligo/utils/common_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

Widget SecondaryButton(context) => Positioned(
      top: 50,
      left: 20,
      child: GestureDetector(
        onTap: () => {(Navigator.pop(context))},
        child: Image.asset(
          'assets/images/png/icon-cross.png',
          scale: 0.8,
        ),
      ),
    );
Widget ClearRoundButton(context, double left) => Positioned(
      bottom: 30,
      left: left,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.cancel,
          size: 100,
          color: Colors.white,
        ),
      ),
    );
