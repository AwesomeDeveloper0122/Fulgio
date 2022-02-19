// ignore_for_file: sized_box_for_whitespace

import 'package:Fuligo/widgets/clear_button.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';

// import 'package:Fuligo/screens/tours.dart';

class Keizersgracht extends StatefulWidget {
  Map infodata;
  Keizersgracht({Key? key, required this.infodata}) : super(key: key);

  @override
  KeizersgrachtState createState() => KeizersgrachtState();
}

class KeizersgrachtState extends State<Keizersgracht> {
  @override
  Widget build(BuildContext context) {
    Map infodata = widget.infodata;
    print("infodata123");
    print(infodata);
    var mq = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(infodata["image"][0]), fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   title: Text('TEST'),
        // ),
        body: Stack(
          children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [gradientFrom, bgColor]),
                    color: bgColor.withOpacity(0.8)),
                width: mq.width,
                height: mq.height,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: mq.height * 0.17,
                    ),
                    TextHeaderTest(
                      context,
                      infodata["name"]["en_GB"]!,
                      infodata["description"]["en_GB"]!,
                    ),
                  ],
                )),
            ClearRoundButton(context, mq.width / 2 - 40),
          ],
        ),
      ),
    );
  }
}
