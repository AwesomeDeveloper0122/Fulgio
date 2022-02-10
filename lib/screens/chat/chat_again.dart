// ignore_for_file: sized_box_for_whitespace

import 'package:Fuligo/model/chat_model.dart';
import 'package:Fuligo/model/user_modal.dart';
import 'package:Fuligo/provider/auth_provider.dart';
import 'package:Fuligo/utils/font_style.dart';
import 'package:Fuligo/utils/loading.dart';
import 'package:Fuligo/widgets/circleimage.dart';
import 'package:Fuligo/widgets/clear_button.dart';
import 'package:Fuligo/widgets/logo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';
import 'package:Fuligo/widgets/custom_image.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class ChatAgain extends StatefulWidget {
  ChatAgain({Key? key, required String documentId}) : super(key: key);

  @override
  ChatAgainState createState() => ChatAgainState();
}

class ChatAgainState extends State<ChatAgain> {
  bool is_load = false;
  @override
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
  List chat_list = [];

  @override
  Future<List> getChatData() async {
    DocumentSnapshot chatData = await FirebaseFirestore.instance
        .collection('order')
        .doc('qEnncoZSqLs8QE4jS3bF')
        .get();

    chat_list = chatData['chatMessages'];
    is_load = true;
    setState(() {});
    return chat_list;
  }

  Future<void> addChat(username, content) async {
    print("send click");
    CollectionReference order = FirebaseFirestore.instance.collection('order');
    ChatModel _chat = ChatModel(
      author: username,
      message: content,
    );
    // SmartDialog.showLoading(backDismiss: false, background: Colors.transparent);
    // await FirebaseFirestore.instance
    //     .collection('order')
    //     .doc('qEnncoZSqLs8QE4jS3bF')
    //     .set(_chat.toJson());

    // SmartDialog.dismiss();
    // await getChatData();

    List chatdata = [];
    SmartDialog.showLoading(backDismiss: false, background: Colors.transparent);
    chatdata = await getChatData();
    SmartDialog.dismiss();

    setState(() {});

    print("============== Chat Data ==============");
    print(chatdata);
    chatdata.add(_chat.toJson());
    chatInput.text = "";
    print("======== chatdata ========");
    print(chatdata);
    // final position = _scrollController.position.maxScrollExtent;

    // _scrollController.jumpTo(position);
    // print("+++++++++++++++position++++++++++++++");
    // print(position);

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
    List<Widget> widgets = [];
    for (var element in chat_list) {
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
                borderRadius: BorderRadius.circular(15)),
            child: Text(element['message'], style: font_14_white),
          ),
        ],
      ));
    }

    return Container(
      decoration: bgDecoration,
      child: Scaffold(
        backgroundColor: chatContentColor,
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
                    color: chatTitleColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 0, top: 20),
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
              is_load
                  ? Positioned(
                      top: mq.height / 6,
                      // top: 0,
                      // bottom: 70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: mq.height * 0.7,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              width: mq.width * 0.9,
                              // padding: EdgeInsets.all(20),
                              child: Scrollbar(
                                // isAlwaysShown: true,
                                controller: _scrollController,
                                child: ListView(
                                  scrollDirection: Axis.vertical,
                                  children: widgets,
                                  padding: EdgeInsets.all(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : kLoadingFadingWidget(context),
              Positioned(
                bottom: 0,
                width: mq.width,
                child: Container(
                  // height: mq.height * 0.1,
                  padding: EdgeInsets.fromLTRB(20, 15, 10, 15),
                  decoration: BoxDecoration(
                    color: chatTitleColor,
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
