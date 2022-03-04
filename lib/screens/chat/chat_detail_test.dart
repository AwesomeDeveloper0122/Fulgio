// ignore_for_file: sized_box_for_whitespace

import 'dart:async';

import 'package:Fuligo/model/chat_model.dart';
import 'package:Fuligo/model/user_model.dart';
import 'package:Fuligo/provider/auth_provider.dart';
import 'package:Fuligo/utils/font_style.dart';
import 'package:Fuligo/utils/loading.dart';
import 'package:Fuligo/widgets/circleimage.dart';
import 'package:Fuligo/widgets/clear_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';

// ignore: must_be_immutable
class ChatDetailTest extends StatefulWidget {
  String docId;
  ChatDetailTest({Key? key, required this.docId}) : super(key: key);

  @override
  ChatDetailTestState createState() => ChatDetailTestState();
}

class ChatMessageModel {
  String image;
  String comment;
  ChatMessageModel({
    this.image = "",
    this.comment = "",
  });
}

class ChatDetailTestState extends State<ChatDetailTest> {
  TextEditingController textEditingController = TextEditingController();
  final ScrollController _controller = ScrollController();
  bool loading = true;

  List chatList = [];
  void initState() {
    super.initState();
    getChatData(widget.docId);
    setState(() {});
  }

  Future<List> getChatData(id) async {
    try {
      print("111");
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('order').doc(id).get();

      chatList = snapshot['chatMessages'];
      print("try");
      print(snapshot.data());
      print(chatList);
      loading = false;
      setState(() {});
    } catch (e) {
      // print("222");
      // CollectionReference order =
      //     FirebaseFirestore.instance.collection('order');
      // order
      //     .doc(widget.docId)
      //     .set({'chatMessages': []}, SetOptions(merge: true))
      //     .then((value) => print("ChatMessages Field Added"))
      //     .catchError((error) => print("Failed to add user: $error"));
      // loading = false;
      // print("catch");
      // print(chatList);

      // setState(() {});
    }

    return chatList;
  }

  Future<void> addChatMessage() async {
    CollectionReference order = FirebaseFirestore.instance.collection('order');

    if (textEditingController.text.trim().isNotEmpty) {
      ChatModel _chat = ChatModel(
        author: "user",
        message: textEditingController.text.trim(),
      );
      // List chatdata = [];
      // SmartDialog.showLoading(
      //     backDismiss: false, background: Colors.transparent);
      // chatdata = await getChatData(widget.docId);
      // SmartDialog.dismiss();

      // setState(() {});

      chatList.add(_chat.toJson());

      order
          .doc(widget.docId)
          .set({'chatMessages': chatList}, SetOptions(merge: true))
          .then((value) => print("Chat Added"))
          .catchError((error) => print("Failed to add user: $error"));
      setState(() {
        chatList = chatList;
        textEditingController.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("chatList");
    print(chatList);
    List<Widget> chatItems = [];
    var mq = MediaQuery.of(context).size;
    UserModel userInfo = AuthProvider.of(context).userModel;

    if (chatList.isNotEmpty) {
      for (var element in chatList.reversed) {
        chatItems.add(Column(
          crossAxisAlignment: element["author"] == "user"
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            Container(
              width: mq.width * 0.65,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: bgColor, borderRadius: BorderRadius.circular(15)),
              child: Text(element['message'], style: font_14_white),
            ),
          ],
        ));
      }
    }
    print("chatItems.length");
    print(chatItems.length);
    return Container(
      decoration: bgDecoration,
      child: Scaffold(
        backgroundColor: chatContentColor,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                // _appBar(),

                Flexible(
                    child: !loading
                        ? chatItems.isNotEmpty
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: ListView(
                                  reverse: true,
                                  children: chatItems,
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: mq.height * 0.2,
                                  ),
                                  Text(
                                    "No chat data",
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.white30),
                                  ),
                                ],
                              )
                        : kRingWidget(context)),
                buildMessageTextField(),
              ],
            ),
            Positioned(
              top: 0,
              child: Container(
                // height: mq.height * 0.15,
                width: mq.width,
                decoration: const BoxDecoration(
                  color: chatTitleColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 0, top: 30),
                      child: Text(
                        userInfo.username["first"].toString(),
                        style: font_18_white,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 20, top: 30),
                      child:
                          CircleImage(context, userInfo.avatar, 40, 40, "chat"),
                    ),
                  ],
                ),
              ),
            ),
            SecondaryButton(context),
          ],
        ),
      ),
    );
  }

  Widget buildMessageTextField() {
    var mq = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(color: Colors.black45),
      child: Container(
        height: 70.0,
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: mq.width * 0.7,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                onTap: () {
                  Timer(
                      Duration(milliseconds: 300),
                      () => _controller
                          .jumpTo(_controller.position.maxScrollExtent));
                },
                controller: textEditingController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white54,
                  ),
                ),
                textInputAction: TextInputAction.send,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
                onSubmitted: (_) {
                  addChatMessage();
                },
              ),
            ),
            // Container(
            //   width: 50.0,
            //   child: InkWell(
            //     onTap: addChatMessage,
            //     child: Icon(
            //       Icons.send,
            //       color: Color(0xFFdd482a),
            //     ),
            //   ),
            // ),
            Container(
              width: mq.width * 0.2,
              child: InkWell(
                onTap: addChatMessage,
                child: const CircleAvatar(
                  backgroundColor: bgColor,
                  radius: 25,
                  child: Icon(Icons.navigate_next),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
