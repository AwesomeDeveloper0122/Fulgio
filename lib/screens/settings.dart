import 'package:Fuligo/model/user_model.dart';

import 'package:Fuligo/provider/auth_provider.dart';
import 'package:Fuligo/screens/achievement/achievements.dart';
import 'package:Fuligo/screens/chat/chat.dart';
import 'package:Fuligo/widgets/popup.dart';

import 'package:Fuligo/widgets/custom_button.dart';

import 'package:flutter/material.dart';
import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/circleimage.dart';
import 'package:accordion/accordion.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();

    // setState(() {});
  }

  bool _showContent = false;

  Widget build(BuildContext context) {
    UserModel _userInfo = AuthProvider.of(context).userModel;

    print("========= userInfo ============");

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20),
          decoration: const BoxDecoration(
            color: bgColor,
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [gradientFrom, bgColor]),
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              ListTile(
                horizontalTitleGap: 30.0,
                contentPadding: EdgeInsets.only(
                  bottom: 20,
                ),
                leading: Image(
                  image: AssetImage('assets/images/png/icon-map.png'),
                  width: 40,
                  height: 40,
                ),
                trailing: IconButton(
                  icon: Icon(_showContent
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down),
                  onPressed: () {
                    setState(() {
                      _showContent = !_showContent;
                    });
                  },
                ),
                title: Text(
                  'Language',
                  style: TextStyle(
                      color: Colors.white70, fontSize: 20, letterSpacing: 1.5),
                ),
                onTap: () => {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         ChatAgain(documentId: 'qEnncoZSqLs8QE4jS3bF'),
                  //   ),
                  // ),
                },
              ),
              _showContent
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: Text("456"),
                    )
                  : Container(),
              ListTile(
                title: Text("123"),
                trailing: IconButton(
                  icon: Icon(_showContent
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down),
                  onPressed: () {
                    setState(() {
                      _showContent = !_showContent;
                    });
                  },
                ),
              ),
              _showContent
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: Text("456"),
                    )
                  : Container()
            ],
          ),
        ),
        CrossButton(context),
      ],
    );
  }
}
