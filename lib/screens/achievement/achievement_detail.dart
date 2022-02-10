// ignore_for_file: sized_box_for_whitespace

import 'package:Fuligo/widgets/clear_button.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';
// import 'package:Fuligo/widgets/button.dart';
// import 'package:Fuligo/widgets/imagedetail.dart';
import 'package:Fuligo/widgets/subtxt.dart';
import 'package:Fuligo/widgets/fuligo_card.dart';

// import 'package:Fuligo/screens/tours.dart';

class ArchivementsDetail extends StatefulWidget {
  final Map data;
  ArchivementsDetail({
    Key? key,
    required this.data,
  }) : super(key: key);
// SecondScreenWithData({Key key, @required this.person}) : super(key: key);
  @override
  ArchivementsDetailState createState() => ArchivementsDetailState();
}

class ArchivementsDetailState extends State<ArchivementsDetail> {
  @override
  Widget build(BuildContext context) {
    print("123123");
    print(widget.data);

    var mq = MediaQuery.of(context).size;
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
                    "Red Light",
                    "Complete the digital city tour \n 'Red Light' in Amsterdam",
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 60),
                          child: SubTxt(context, 'Achieved on', '24-10-2020'),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 60),
                          child: SubTxt(context, 'Reward', "aaaa"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ClearButton(context),
          ],
        ),
      ),
    );
  }
}
