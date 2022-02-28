// ignore_for_file: sized_box_for_whitespace

import 'dart:typed_data';

import 'package:Fuligo/utils/loading.dart';
import 'package:Fuligo/widgets/circleimage.dart';
import 'package:Fuligo/widgets/clear_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';
import 'package:flutter/services.dart';

class AvatarScreen extends StatefulWidget {
  const AvatarScreen({Key? key}) : super(key: key);

  @override
  AvatarScreenState createState() => AvatarScreenState();
}

class AvatarScreenState extends State<AvatarScreen> {
  @override
  List<Map> avatars = [];
  List<Uint8List> imageList = [];

  bool loading = true;
  void initState() {
    getAvatars();
    super.initState();
  }

  Future<void> getAvatars() async {
    QuerySnapshot orderSnapshot =
        await FirebaseFirestore.instance.collection('avatar').get();
    Reference ref;
    String url;
    Map temp;
    if (orderSnapshot.docs.isNotEmpty) {
      Uint8List uint8image;
      for (var item in orderSnapshot.docs) {
        ref = FirebaseStorage.instance.ref().child(item["img"]);
        url = await ref.getDownloadURL();
        Uint8List uint8image =
            (await NetworkAssetBundle(Uri.parse(url)).load(""))
                .buffer
                .asUint8List();
        imageList.add(uint8image);
        temp = {
          "id": item.id,
          "img": url,
          "isDefault": item["isDefault"],
        };
        avatars.add(temp);
      }

      loading = false;
    }
    setState(() {
      avatars = avatars;
      loading = loading;
    });
  }

  Widget build(BuildContext context) {
    List<Widget> avatarList = [];
    for (var i = 0; i < avatars.length; i++) {
      var item = avatars[i];

      avatarList.add(
          AvatarMenu(context, imageList[i], item["img"], item["id"], 80, 80));
    }

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
          children: [
            Container(
                padding: const EdgeInsets.only(right: 0, left: 0),
                // width: 400,
                // height: mq.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    PageHeader(
                      context,
                      "Avatar",
                      "Choose your avatar",
                    ),
                    !loading && avatars.isNotEmpty
                        ? Container(
                            width: mq.width,
                            height: mq.height * 0.7,
                            margin: const EdgeInsets.only(bottom: 10, top: 10),
                            child: GridView.count(
                                padding: const EdgeInsets.all(60),
                                crossAxisCount: 2,
                                children: avatarList),
                          )
                        : Container(
                            margin: EdgeInsets.only(top: mq.height * 0.3),
                            child: kLoadingFadingWidget(context),
                          )
                  ],
                )),
            SecondaryButton(context)
          ],
        ),
      ),
    );
  }
}
