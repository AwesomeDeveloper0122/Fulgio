// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:Fuligo/utils/common_colors.dart';
//Screens
import 'package:Fuligo/screens/first.dart';
import 'package:Fuligo/screens/verify.dart';
//Widgets
import 'package:Fuligo/widgets/button.dart';
import 'package:Fuligo/widgets/textheader.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => new LoginState();
}

class LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: hintColor,
        // appBar: AppBar(
        //   title: Text('TEST'),
        // ),
        body: Stack(
          children: <Widget>[
            TextHeader(context, "Discover", "Enter your email to",
                "start your experience"),
            Positioned(
              bottom: 50,
              child: SizedBox(
                width: mq.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(width: 340),
                        child: const TextField(
                          style: TextStyle(color: Colors.white),
                          autocorrect: true,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Enter a search term',
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                            fillColor: Colors.white,
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.0),
                              // borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 350,
                      height: 50,
                      child: CustomButton(context, Verify(), "Next"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
