import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget ImageCustom(context, String url, String title, String content) =>
    Container(
      width: 350,
      height: 140,
      margin: const EdgeInsets.only(top: 60),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(url),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          Text(
            content,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
