// ignore_for_file: non_constant_identifier_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:Fuligo/utils/common_colors.dart';

Widget Logo(context) => Container(
      height: MediaQuery.of(context).size.height * 0.15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 5, 0),
            child: Container(
              margin: const EdgeInsets.only(top: 50, bottom: 30),
              child: const Icon(
                Icons.settings,
                color: Colors.red,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 5, 0),
            child: Container(
              margin: const EdgeInsets.only(top: 50, bottom: 30),
              child: const Text(
                "FULIGO",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: whiteColor),
              ),
            ),
          ),
        ],
      ),
    );
