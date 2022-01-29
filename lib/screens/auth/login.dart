// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

import 'package:Fuligo/routes/route_costant.dart';
import 'package:Fuligo/widgets/text_header.dart';
import 'package:Fuligo/widgets/dialog.dart';

//common
import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/utils/localtext.dart';

//import firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController emailCtl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  String email = "";

  @override
  void initState() {
    super.initState();
    _initializeFirebase();

    setState(() {
      emailCtl.text = "";
    });
  }

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  void login() async {
    String email = emailCtl.text;
    String pwd = "123123123";

    // ========== Show Progress Dialog ===========

    Dialogs.showLoadingDialog(context, _keyLoader, "Please wait..");
    int _result = 0;

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pwd);
      _result = 1;

      // await getUser(userCredential.user!);
      // _result = 1;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _result = 2;
      } else if (e.code == 'wrong-password') {
        _result = 3;
      } else {
        _result = 4;
      }
    }

    // ------------ Dismiss Porgress Dialog  -------------------
    Navigator.of(_keyLoader.currentContext!, rootNavigator: false).pop();
    await toDoResult(_result);
  }

  Future<void> toDoResult(int result) async {
    switch (result) {
      case 1:
        showTopSnackBar(
          context,
          const CustomSnackBar.success(
            message: LocalText.LoginSuccess,
          ),
        );
        Navigator.of(context).pushReplacementNamed(RouteName.Verify);

        break;

      case 2:
        //---- Show Error Msg
        showTopSnackBar(
          context,
          const CustomSnackBar.error(
            message: LocalText.NotFoundUser,
          ),
        );
        break;

      case 3:
        //---- Show Error Msg
        showTopSnackBar(
          context,
          const CustomSnackBar.error(
            message: LocalText.WrongPwd,
          ),
        );
        break;
      default:
        showTopSnackBar(
          context,
          const CustomSnackBar.error(
            message: LocalText.NetError,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/discover.png"),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: _formKey,
          child: Stack(
            children: <Widget>[
              TextHeader(context, "Discover", "Enter your email to",
                  "start your experience"),
              Positioned(
                bottom: 30,
                child: SizedBox(
                  width: mq.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        child: ConstrainedBox(
                          constraints:
                              const BoxConstraints.tightFor(width: 340),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailCtl,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                            style: const TextStyle(color: Colors.grey),
                            autocorrect: true,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'Enter a email',
                              hintStyle: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                              fillColor: Colors.grey,
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2.0),
                                // borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2.0),
                                // borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 340,
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          color: bgColor,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              login();
                            }
                          },
                          textColor: bgColor,
                          child: const Text(
                            "Next",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
