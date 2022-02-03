// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

Widget ClearButton(context) => Positioned(
      top: 50,
      left: 20,
      child: GestureDetector(
        onTap: () => {(Navigator.pop(context))},
        child: const Icon(
          Icons.clear_rounded,
          size: 50,
          color: Colors.white,
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
