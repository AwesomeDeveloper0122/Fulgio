// ignore_for_file: sized_box_for_whitespace

// import 'package:Fuligo/widgets/button.dart';
// import 'package:Fuligo/widgets/login_button.dart';
// import 'package:Fuligo/screens/verify.dart';
import 'package:Fuligo/localtext/localtext.dart';
import 'package:Fuligo/routes/route_costant.dart';
// import 'package:Fuligo/routes/route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
// import 'package:another_flushbar/flushbar.dart';
// import 'package:another_flushbar/flushbar_helper.dart';
// import 'package:another_flushbar/flushbar_route.dart';
//Screens
// import 'package:Fuligo/screens/verify.dart';
//Widgets
// import 'package:Fuligo/widgets/login_button.dart';
import 'package:Fuligo/widgets/text_header.dart';
import 'package:Fuligo/widgets/dialog.dart';
import 'package:Fuligo/utils/common_colors.dart';
// import 'package:Fuligo/routes/route.dart';
// import 'package:Fuligo/screens/verify.dart';
// import 'package:Fuligo/route.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  // ignore: prefer_final_fields, unused_field
  TextEditingController emailCtl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  String email = "";

  // FirebaseAuth auth = FirebaseAuth.instance;
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

    // String password = passwordCtl.text;

    // ========== Show Progress Dialog ===========

    Dialogs.showLoadingDialog(context, _keyLoader, "Please wait..");
    int _result = 0;

    try {
      // ignore: avoid_print
      print(email);
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pwd);
      // ignore: avoid_print
      print('_______ Logined Successfully ______________ \r\n');

      _result = 1;

      // await getUser(userCredential.user!);
      // _result = 1;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        _result = 2;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        _result = 3;
      } else {
        print("fail");
        _result = 4;
      }
    }

    // ------------ Dismiss Porgress Dialog  -------------------
    Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    await toDoResult(_result);
  }

  Future<void> toDoResult(int result) async {
    switch (result) {
      case 1:
        //---- Show Error Msg
        showTopSnackBar(
          context,
          const CustomSnackBar.success(
            message: LocalText.success,
          ),
        );

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const Verify()),
        // );
        Navigator.of(context).pushReplacementNamed(RouteName.Verify);
        // Navigator.pushNamed(context, Routes.verify);

        // Navigator.pushReplacementNamed(context, Routes.verify);

        break;

      case 2:
        //---- Show Error Msg
        showTopSnackBar(
          context,
          const CustomSnackBar.error(
            message: "Wrong password",
          ),
        );
        break;

      case 3:
        //---- Show Error Msg
        showTopSnackBar(
          context,
          const CustomSnackBar.error(
            message: "Woring password",
          ),
        );
        break;
      default:
        showTopSnackBar(
          context,
          const CustomSnackBar.error(
            message: "Error",
          ),
        );
      //---- Show Error Msg

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

        // appBar: AppBar(
        //   title: Text('TEST'),
        // ),
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
                            // onChanged: (value) {
                            //   // ignore: avoid_print
                            //   print(value);
                            //   email = value;
                            // },
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
                            // It returns true if the form is valid, otherwise returns false
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, display a Snackbar.
                              // ignore: deprecated_member_use
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const Verify(),
                              //   ),
                              // );
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
                      // Container(
                      //     padding:
                      //         const EdgeInsets.only(left: 150.0, top: 40.0),
                      //     child: RaisedButton(
                      //       child: const Text('Submit'),
                      //       onPressed: () {
                      //         // It returns true if the form is valid, otherwise returns false
                      //         if (_formKey.currentState!.validate()) {
                      //           // If the form is valid, display a Snackbar.
                      //           // ignore: deprecated_member_use
                      //           Scaffold.of(context).showSnackBar(
                      //               const SnackBar(
                      //                   content:
                      //                       Text('Data is in processing.')));
                      //         }
                      //       },
                      //     )),
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
