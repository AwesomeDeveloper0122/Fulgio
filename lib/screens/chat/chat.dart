// ignore_for_file: sized_box_for_whitespace

import 'package:Fuligo/widgets/custom_image.dart';
import 'package:Fuligo/widgets/text_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:Fuligo/utils/common_colors.dart';
//Screens
import 'package:Fuligo/screens/tours.dart';
// import 'package:Fuligo/screens/touranother.dart';
// import 'package:Fuligo/screens/cancel_tour.dart';
// import 'package:Fuligo/screens/achievements.dart';

//Widgets
import 'package:Fuligo/widgets/custom_button.dart';
import 'package:Fuligo/widgets/logo.dart';
import 'package:Fuligo/widgets/circleimage.dart';
// import 'package:Fuligo/screens/menu_screen.dart';
import 'package:Fuligo/screens/chat/chat.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: bgColor,
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [gradientFrom, bgColor]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   title: Text('TEST'),
        // ),
        body: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Logo(context),
            ),
            TextHeader(context, "Chat", "For which order do you need supprot?"),
            SizedBox(
              height: 500,
            ),
            Column(
              children: [
                ImageCustom(
                    context, "assets/images/1.jpeg", "Porto", "03-06-2021"),
                ImageCustom(
                    context, "assets/images/1.jpeg", "Porto", "03-06-2021"),
              ],
            ),
            Positioned(
              top: 70,
              left: 20,
              child: GestureDetector(
                onTap: () => {Navigator.pop(context)},
                child: const Icon(
                  Icons.clear,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void _show() {
  //   SmartDialog.show(
  //     widget: MenuScreen(context),
  //   );

  //   //target widget
  // }
}
