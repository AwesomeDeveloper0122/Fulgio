// ignore_for_file: sized_box_for_whitespace, prefer_final_fields

import 'package:Fuligo/model/user_modal.dart';
import 'package:Fuligo/provider/auth_provider.dart';
import 'package:Fuligo/repositories/user_repository.dart';
import 'package:Fuligo/routes/route_costant.dart';
import 'package:Fuligo/screens/achievement/achievement_detail.dart';
import 'package:Fuligo/utils/loading.dart';
import 'package:Fuligo/widgets/clear_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';

import 'package:Fuligo/widgets/subtxt.dart';
import 'package:Fuligo/widgets/fuligo_card.dart';

// import 'package:Fuligo/screens/tours.dart';

class Achievements extends StatefulWidget {
  const Achievements({Key? key}) : super(key: key);

  @override
  ArchivmentsState createState() => ArchivmentsState();
}

class ArchivmentsState extends State<Achievements> {
  List allData = [];
  bool is_load = false;
  late num user_credit;
  late num user_achieve;
  List<QueryDocumentSnapshot> doc_list = [];
  List user_achievement = [];
  List<Widget> widgets = [];
  List<Map> new_list = [];

  @override
  void initState() {
    super.initState();
    user_credit = 0;
    user_achieve = 0;
    getData();
  }

  Future<bool> getData() async {
    UserModel _userInfo = AuthProvider.of(context).userModel;
    final result = await UserRepository.getUserByID(_userInfo.uid);
    user_achievement =
        result['achievement']; // get achievement in User collection
    print('=======user achievement===========');
    print(result["achievement"]);

    CollectionReference achievements =
        FirebaseFirestore.instance.collection('achievement');

    achievements.get().then((QuerySnapshot querySnapshot) {
      doc_list = querySnapshot.docs; //get achievement in Achievement collection
      for (var element in doc_list) {
        if (user_achievement.toString().contains(element.reference.id)) {
          user_credit += element["credits"];
          user_achieve++;
          Map temp = {
            "isDone": true,
            "active": element['active'],
            "name": element['name'],
            "description": element['description'],
            // "credits": element['credits'],
            // "updatedat": element['updatedat']
          };
          new_list.add(temp);
        } else {
          Map temp = {
            "isDone": false,
            "active": element['active'],
            "name": element['name'],
            "description": element['description'],
            // "credits": element['credits'],
            // "updatedat": element['updatedat']
          };
          new_list.add(temp);
        }
      }

      is_load = true;
      setState(() {
        is_load = is_load;
      });
    });

    // Get data from docs and convert map to List
    // QuerySnapshot querySnapshot = await _collectionRef.get();
    // allData = querySnapshot.docs.map((doc) => doc.reference.id).toList();

    return is_load;
  }

  List<Widget> getArchivementsItem(List<Map> newList) {
    List<Widget> cardlist = [];
    for (var i = 0; i < newList.length; i++) {
      if (newList[i]['isDone']) {
        cardlist.add(
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  // builder: (context) => ArchivementsDetail(data: newList[i]),
                  builder: (context) => ArchivementsDetail(data: newList[i]),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              child:
                  FuligoCard(context, newList[i]["name"]["en_GB"], whiteColor),
            ),
          ),
        );
      } else {
        cardlist.add(
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  // builder: (context) => ArchivementsDetail(data: newList[i]),
                  builder: (context) => ArchivementsDetail(data: newList[i]),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              child:
                  FuligoCard(context, newList[i]["name"]["en_GB"], greyColor),
            ),
          ),
        );
      }
    }
    return cardlist;
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;

    return Builder(builder: (context) {
      return Container(
        decoration: bgDecoration,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          // appBar: AppBar(
          //   title: Text('TEST'),
          // ),
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
                      height: mq.height * 0.17,
                    ),
                    TextHeaderTest(
                      context,
                      "Archivements",
                      "Each completed achievement \n brings you credit on Flugio, ",
                    ),
                    is_load
                        ? Column(
                            children: [
                              Container(
                                height: mq.height * 0.16,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 40),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 55),
                                      child: SubTxt(context, 'Achievements',
                                          '$user_achieve of ${doc_list.length}'),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 55),
                                      child: SubTxt(context, 'Credit',
                                          '$user_credit CHF'),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: mq.width,
                                height: mq.height * 0.57,
                                // decoration: BoxDecoration(
                                //     color: Colors.white,
                                //     borderRadius: BorderRadius.circular(10)),

                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: GridView.count(
                                  padding: const EdgeInsets.all(0),
                                  crossAxisCount: 2,
                                  children: getArchivementsItem(new_list),
                                ),
                              ),
                            ],
                          )
                        : Container(
                            child: SizedBox(
                              height: mq.height * 0.3,
                              child: kLoadingFadingWidget(context),
                            ),
                          )
                  ],
                ),
              ),
              ClearButton(context),
            ],
          ),
        ),
      );
    });
  }
}
