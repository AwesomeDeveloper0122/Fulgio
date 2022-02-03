import 'package:Fuligo/model/chat_model.dart';
import 'package:Fuligo/model/user_modal.dart';
import 'package:Fuligo/provider/auth_provider.dart';
import 'package:Fuligo/provider/chat_provider.dart';
import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/utils/font_style.dart';
import 'package:Fuligo/widgets/circleimage.dart';
import 'package:Fuligo/widgets/clear_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatContent extends StatelessWidget {
  final String documentId;
  final _formKey = GlobalKey<FormState>();
  String content = "";
  TextEditingController chatInput = TextEditingController();

  ChatContent(this.documentId);

  get bgDecoration => null;

  @override
  Widget build(BuildContext context) {
    UserModel _userInfo = AuthProvider.of(context).userModel;
    CollectionReference users = FirebaseFirestore.instance.collection('order');
    var mq = MediaQuery.of(context).size;
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          print(snapshot.data!.data());

          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          List test = data["chatMessages"];
          // ChatModel _chatModel;
          // test.forEach((ele) => {_chatModel = ele});

          List<Widget> widgets = [];
          test.forEach((element) {
            print(element['message']);

            widgets.add(
              Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: bgColor, borderRadius: BorderRadius.circular(20)),
                child: Text(element['message'], style: font_14_white),
              ),
            );
          });

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
                              child: CircleImage(
                                  context, _userInfo.avatar, 40, 40),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: mq.height / 6,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 500,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                              width: mq.width * 0.9,
                              // padding: EdgeInsets.all(20),
                              child: ListView(
                                children: widgets,
                              ),
                            ),
                          ),
                        ],
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
                                      send(_userInfo.username),
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

          // return Container(
          //   width: 200,
          //   child: ListView(
          //     children: widgets,
          //   ),
          // );
        }

        return Text("loading");
      },
    );
  }

  void send(username) {
    String chatContent = chatInput.text;
    print("===================================");

    print(chatContent);
    print(username);

    // setState(() {
    //   chatInput.text = "";
    // });
  }
}
