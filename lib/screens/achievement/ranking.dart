// ignore_for_file: sized_box_for_whitespace

import 'dart:typed_data';

import 'package:Fuligo/model/user_model.dart';
import 'package:Fuligo/provider/auth_provider.dart';
import 'package:Fuligo/utils/loading.dart';
import 'package:Fuligo/widgets/clear_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:Fuligo/screens/tours.dart';

class Ranking extends StatefulWidget {
  const Ranking({Key? key}) : super(key: key);

  @override
  RankingState createState() => RankingState();
}

class RankingState extends State<Ranking> {
  void initState() {
    super.initState();
    getData();
  }

  bool loading = true;
  List<Map> _users = [];
  List<Uint8List> imageList = [];

  Future<void> getData() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final prefs = await SharedPreferences.getInstance();
    String avatar = "";

    users.get().then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        for (var user in querySnapshot.docs) {
          final prefs = await SharedPreferences.getInstance();
          int achievementNum = 0;
          String name = "Anonymous User";
          Map _userdata = user.data() as Map<String, dynamic>;

          if (_userdata.containsKey("avatar")) {
            var refId = user.get("avatar");

            refId.get().then((DocumentSnapshot documentSnapshot) async {
              if (documentSnapshot.exists) {
                avatar = await getDownImageUrl(documentSnapshot.get('img'));
              }
            });
          } else {
            String defaultavatar = prefs.getString('defaultAvatar') ?? "";
            avatar = await getDownImageUrl(defaultavatar);
          }
          Uint8List uint8image =
              (await NetworkAssetBundle(Uri.parse(avatar)).load(""))
                  .buffer
                  .asUint8List();

          imageList.add(uint8image);
          if (_userdata.containsKey("achievement")) {
            achievementNum = _userdata["achievement"].length;
          }

          if (_userdata.containsKey("name")) {
            name = _userdata["name"]["first"].toString() +
                " " +
                _userdata["name"]["last"].toString();
          }
          print("userAvatars");
          print(avatar);
          _users.add({
            "avatar": avatar,
            "name": name,
            "num": achievementNum,
            "uid": _userdata["uid"]
          });
        }

        loading = false;
        setState(() {});
      } else {}
    });
  }

  Future<String> getDownImageUrl(location) async {
    Reference ref = FirebaseStorage.instance.ref().child(location);
    String url = await ref.getDownloadURL();

    return url;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> usersRanking = [];
    var mq = MediaQuery.of(context).size;
    _users.sort((a, b) => b["num"].compareTo(a["num"]));
    print("users is");
    print(_users);
    print(_users.length);
    UserModel _userInfo = AuthProvider.of(context).userModel;
    if (_users.isNotEmpty) {
      for (var i = 0; i < _users.length; i++) {
        var item = _users[i];
        usersRanking.add(
          Container(
            margin: EdgeInsets.only(bottom: 20),
            decoration: _userInfo.uid != item["uid"]
                ? BoxDecoration(
                    color: bgColor,
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [bgColor, gradientFrom]),
                    borderRadius: BorderRadius.circular(25.0),
                  )
                : BoxDecoration(
                    color: bgColor,
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.white10, bgColor]),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              // leading: CircleImage(context, imageList[i], 80, 80, "ranking"),
              leading: Container(
                child: InkWell(
                  onTap: () {},
                  child: ClipOval(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: MemoryImage(imageList[i], scale: 0.5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              title: Text(
                item["name"],
                style: TextStyle(
                    color: _userInfo.uid != item["uid"]
                        ? Colors.white38
                        : whiteColor,
                    fontSize: 16),
              ),
              // trailing: CircleImage(context, item["avatar"], 80, 80, "ranking"),
              trailing: Text('${i + 1}'),
              subtitle: Text(
                item["num"].toString() + '  achievements',
                style: TextStyle(color: Colors.white38, fontSize: 14),
              ),
              onTap: () => {
                // Navigator.pushNamed(context, RouteName.Startour),
              },
            ),
          ),
        );
      }
    } else {
      usersRanking.add(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: mq.height * 0.2,
          ),
          Text(
            "No User data",
            style: TextStyle(fontSize: 30, color: Colors.white30),
          ),
        ],
      ));
    }

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
        body: Stack(
          children: [
            Container(
              width: mq.width,
              height: mq.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.17,
                  ),
                  PageHeader(
                    context,
                    "Ranking",
                    "So where do you stand? Let's see...",
                  ),
                  !loading
                      ? Container(
                          // decoration: BoxDecoration(color: whiteColor),
                          height: mq.height - 210,
                          padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                          child: Scrollbar(
                            child: ListView(
                              padding: EdgeInsets.all(0),
                              shrinkWrap: true,
                              children: usersRanking,
                            ),
                          ),
                        )
                      : Container(
                          child: SizedBox(
                            height: mq.height * 0.4,
                            child: kRingWidget(context),
                          ),
                        )
                ],
              ),
            ),
            SecondaryButton(context)
          ],
        ),
      ),
    );
  }
}
