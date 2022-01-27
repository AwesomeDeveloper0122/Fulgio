import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget FuligoCard(context, String url, String title, String content) =>
    Container(
      width: 150,
      height: 130,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        // image: DecorationImage(
        //   image: AssetImage(url),
        //   fit: BoxFit.fill,
        // ),
        color: Colors.green,
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
