// ignore_for_file: sized_box_for_whitespace

import 'package:Fuligo/utils/font_style.dart';
import 'package:Fuligo/widgets/logo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';
// import 'package:Fuligo/widgets/button.dart';
// import 'package:Fuligo/widgets/imagedetail.dart';
import 'package:Fuligo/widgets/subtxt.dart';
import 'package:Fuligo/widgets/fuligo_card.dart';

// import 'package:Fuligo/screens/tours.dart';

class DocumentDetail extends StatefulWidget {
  List citydetail;
  DocumentDetail({Key? key, required this.citydetail}) : super(key: key);

  @override
  DocumentDetailState createState() => DocumentDetailState();
}

class DocumentDetailState extends State<DocumentDetail> {
  Future<String> getDownloadDoc(location) async {
    Reference ref = FirebaseStorage.instance.ref().child(location);
    String url = await ref.getDownloadURL();

    return url;
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    List<Widget> detaildata = [];
    for (var each in widget.citydetail) {
      for (var item in each) {
        detaildata.add(
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [gradientFrom, bgColor]),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
              leading: Icon(Icons.cloud_download_outlined,
                  color: Colors.white, size: 32),
              title: Text(
                item["label"],
                style: font_14_white,
              ),
              subtitle: Text(
                item["type"],
                style: font_14_grey,
              ),
              onTap: () => {
                // Navigator.pushNamed(context, RouteName.Startour),
                print("object"),
                print(getDownloadDoc(item["location"])),
              },
            ),
          ),
        );
      }
      print("123123");
      print(widget.citydetail);
    }
    return Container(
      decoration: bgDecoration,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/project-flugio.appspot.com/o/assets%2F1623336600707_9955.jpg?alt=media&token=75cc95c4-c371-4528-9c0f-b8ef2b73f855"),
                    fit: BoxFit.fill),
              ),
              width: mq.width,
              height: mq.height,
              alignment: Alignment.center,
              child: Container(
                width: mq.width,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [gradientFrom, bgColor]),
                    color: bgColor.withOpacity(0.8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Logo_test,
                    Container(
                      height: mq.height * 0.8,
                      width: mq.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.all(0),
                        children: detaildata,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 60,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
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
}
