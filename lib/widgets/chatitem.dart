import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/utils/font_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatItem extends StatefulWidget {
  const ChatItem({Key? key}) : super(key: key);

  @override
  ChatItemState createState() => ChatItemState();
}

class ChatItemState extends State<ChatItem> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Container(
      width: mq.width * 0.65,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(20)),
      child: Text("123123", style: font_14_white),
    );
  }
}
