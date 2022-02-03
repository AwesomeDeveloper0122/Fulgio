// ignore_for_file: sized_box_for_whitespace

import 'dart:ffi';

import 'package:Fuligo/model/chat_model.dart';
import 'package:Fuligo/model/user_modal.dart';
import 'package:Fuligo/provider/auth_provider.dart';
import 'package:Fuligo/utils/font_style.dart';
import 'package:Fuligo/widgets/circleimage.dart';
import 'package:Fuligo/widgets/clear_button.dart';
import 'package:Fuligo/widgets/logo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';
import 'package:Fuligo/widgets/custom_image.dart';

class ChatAgain extends StatefulWidget {
  ChatAgain({Key? key, required String documentId}) : super(key: key);

  @override
  ChatAgainState createState() => ChatAgainState();
}

class ChatAgainState extends State<ChatAgain> {
  void initState() {
    super.initState();
    getChatData();
    setState(() {
      chatInput.text = "";
    });
  }

  void send(name) {
    String chatContent = chatInput.text;
    addChat(name, chatContent);
  }

  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  String content = "";
  TextEditingController chatInput = TextEditingController();
  // ignore: non_constant_identifier_names
  List chat_list = [];

  @override

// Get data in firebase
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('order');
  // Stream documentStream =
  //     FirebaseFirestore.instance.collection('order').doc('ABC123').snapshots();

  Future<List> getChatData() async {
    var chatData = await FirebaseFirestore.instance
        .collection('order')
        .doc('qEnncoZSqLs8QE4jS3bF')
        .get();
    chat_list = chatData['chatMessages'];
    setState(() {});
    return chat_list;
  }

  Future<void> addChat(username, content) async {
    CollectionReference order = FirebaseFirestore.instance.collection('order');
    print("object");
    ChatModel _chat = ChatModel(
      author: username,
      message: content,
    );
    List chatdata = [];
    chatdata = await getChatData();
    setState(() {});

    print("============== Chat Data ==============");
    // print(chatdata);
    chatdata.add(_chat.toJson());
    chatInput.text = "";

    return order
        .doc('qEnncoZSqLs8QE4jS3bF')
        .set(
          {'chatMessages': chatdata},
        )
        .then((value) => print("Chat Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    UserModel _userInfo = AuthProvider.of(context).userModel;
    CollectionReference users = FirebaseFirestore.instance.collection('order');
    List<Widget> widgets = [];
    chat_list.forEach((element) {
      print(element['message']);

      widgets.add(Column(
        crossAxisAlignment: element["author"] == _userInfo.username
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          Container(
            width: 250,
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: element["author"] == _userInfo.username
                    ? bgColor
                    : hintColor,
                borderRadius: BorderRadius.circular(20)),
            child: Text(element['message'], style: font_14_white),
          ),
        ],
      ));
    });

    print("=======================");
    print(chat_list);
    return Container(
      decoration: bgDecoration,
      child: Scaffold(
        backgroundColor: Colors.green,
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: Container(
                  height: mq.height * 0.15,
                  width: mq.width,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 20, top: 20),
                        child: Text(
                          _userInfo.username,
                          style: font_18_white,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20, top: 20),
                        child: CircleImage(context, _userInfo.avatar, 40, 40),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: mq.height / 6,
                child: Container(
                  height: 600,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: mq.width * 0.9,
                    // padding: EdgeInsets.all(20),
                    child: Scrollbar(
                      isAlwaysShown: true,
                      controller: _scrollController,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: widgets,
                        padding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                width: mq.width,
                child: Container(
                  // height: mq.height * 0.1,
                  padding: EdgeInsets.fromLTRB(20, 15, 10, 15),
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Row(
                    children: [
                      Container(
                        // margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: mq.width * 0.7,
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          controller: chatInput,
                          style: font_14_white,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Input chat',
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white54,
                            ),
                            // focusedBorder: UnderlineInputBorder(
                            //   borderSide: BorderSide(
                            //       color: Colors.transparent, width: 2.0),
                            //   // borderRadius: BorderRadius.circular(25.0),
                            // ),
                          ),
                        ),
                      ),
                      Container(
                        width: mq.width * 0.2,
                        child: GestureDetector(
                          onTap: () => {
                            if (_formKey.currentState!.validate())
                              {
                                this.send(_userInfo.username),
                              },
                          },
                          child: CircleAvatar(
                            backgroundColor: bgColor,
                            radius: 25,
                            child: Icon(Icons.navigate_next),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ClearButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
