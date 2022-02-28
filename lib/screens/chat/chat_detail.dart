// ignore_for_file: sized_box_for_whitespace

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
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class ChatDetail extends StatefulWidget {
  String docId;
  ChatDetail({Key? key, required this.docId}) : super(key: key);

  @override
  ChatDetailState createState() => ChatDetailState();
}

class ChatDetailState extends State<ChatDetail> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  String content = "";
  TextEditingController chatInput = TextEditingController();
  List chatList = [];

  @override
  void initState() {
    super.initState();
    getChatData(widget.docId);
    setState(() {
      chatInput.text = "";
    });
  }

  void send() {
    String chatContent = chatInput.text;
    addChat(chatContent);
  }

  Future<List> getChatData(id) async {
    try {
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('order').doc(id).get();

      chatList = snapshot['chatMessages'];
      loading = true;
      setState(() {});
    } catch (e) {
      CollectionReference order =
          FirebaseFirestore.instance.collection('order');
      order
          .doc(widget.docId)
          .set({'chatMessages': []}, SetOptions(merge: true))
          .then((value) => print("ChatMessages Field Added"))
          .catchError((error) => print("Failed to add user: $error"));
      loading = true;

      setState(() {});
    }
    return chatList;
  }

  Future<void> addChat(content) async {
    print("send click");
    CollectionReference order = FirebaseFirestore.instance.collection('order');
    ChatModel _chat = ChatModel(
      author: "user",
      message: content,
    );

    List chatdata = [];
    SmartDialog.showLoading(backDismiss: false, background: Colors.transparent);
    chatdata = await getChatData(widget.docId);
    SmartDialog.dismiss();

    // setState(() {});

    chatdata.add(_chat.toJson());
    chatInput.text = "";

    return order
        .doc(widget.docId)
        .set({'chatMessages': chatdata}, SetOptions(merge: true))
        .then((value) => print("Chat Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    UserModel userInfo = AuthProvider.of(context).userModel;

    List<Widget> chatItems = [];
    if (chatList.isNotEmpty) {
      for (var element in chatList) {
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
    } else {
      chatItems.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: mq.height * 0.3,
            ),
            Text(
              "No display Chat",
              style: TextStyle(
                color: greyColor,
                fontSize: 20,
              ),
            )
          ],
        ),
      );
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
                  decoration: const BoxDecoration(
                    color: chatTitleColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 0, top: 20),
                        child: Text(
                          userInfo.username["first"].toString(),
                          style: font_18_white,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20, top: 20),
                        child: CircleImage(
                            context, userInfo.avatar, 40, 40, "chat"),
                      ),
                    ],
                  ),
                ),
              ),
              loading
                  ? Positioned(
                      top: mq.height / 7,
                      // top: 0,
                      // bottom: 70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: mq.height * 0.8,
                            decoration: bgDecoration,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              width: mq.width * 0.9,
                              // padding: EdgeInsets.all(20),
                              child: Scrollbar(
                                // isAlwaysShown: true,
                                controller: _scrollController,
                                child: ListView(
                                  scrollDirection: Axis.vertical,
                                  children: chatItems,
                                  padding: const EdgeInsets.all(10),
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
                  padding: const EdgeInsets.fromLTRB(20, 15, 10, 15),
                  decoration: const BoxDecoration(
                    color: chatTitleColor,
                  ),
                  child: Row(
                    children: [
                      Container(
                        // margin: EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                send(),
                              },
                          },
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
              ),
              SecondaryButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
