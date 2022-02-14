import 'package:Fuligo/utils/common_functions.dart';
import 'package:Fuligo/utils/common_header_list.dart';
import 'package:flutter/material.dart';
import 'package:Fuligo/screens/auth/login.dart';
import 'package:Fuligo/widgets/custom_button.dart';
import 'package:Fuligo/widgets/text_header.dart';
import 'package:Fuligo/widgets/logo.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  String page = HeaderList.explorer;
  String title = '';
  String subtitle = '';
  List<String> headerList = [];
  @override
  void initState() {
    super.initState();
    getData(page);
  }

  void getData(pageName) async {
    headerList = await getTitle(pageName);
    title = headerList[0];
    subtitle = headerList[1];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/explore.png"),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Logo_test,
                  TextHeaderTest(context, title, subtitle),
                ],
              ),
            ),
            CustomButtonTest(context, const Login(), "Next")
          ],
        ),
      ),

      // body: Stack(
      //   children: <Widget>[
      //     Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         TextHeader(
      //           context,
      //           "Explore",
      //           "Exploer the city through digital city \nguids and exciting video content",
      //         ),
      //       ],
      //     ),
      //     Positioned(
      //       bottom: 30,
      //       child: SizedBox(
      //         width: mq.width,
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: [
      //             Container(
      //               child: CustomButton(context, const Login(), "Next"),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
