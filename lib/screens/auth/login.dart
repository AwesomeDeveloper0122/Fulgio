// ignore_for_file: unused_local_variable
import 'dart:convert';

import 'package:Fuligo/model/user_modal.dart';
import 'package:Fuligo/provider/auth_provider.dart';
import 'package:Fuligo/screens/verify_test.dart';
import 'package:Fuligo/utils/common_functions.dart';
import 'package:Fuligo/utils/common_header_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:Fuligo/repositories/user_repository.dart';
import 'package:Fuligo/widgets/custom_button.dart';
import 'package:Fuligo/widgets/logo.dart';

import 'package:Fuligo/routes/route_costant.dart';
import 'package:Fuligo/widgets/text_header.dart';
// import 'package:Fuligo/widgets/dialog.dart';

//common
// import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/utils/localtext.dart';

//import firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:top_snackbar_flutter/custom_snack_bar.dart';
// import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  String page = HeaderList.discover;
  String title = '';
  String subtitle = '';
  List<String> headerList = [];
  TextEditingController emailCtl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String email = "";
  @override
  void initState() {
    super.initState();
    getData(page);
    _initializeFirebase();
    setState(() {
      emailCtl.text = "";
    });

    // setState(() {});
  }

  void getData(pageName) async {
    headerList = await getTitle(pageName);
    print("-------------headerList-----------------");
    print(headerList);
    title = headerList[0];
    subtitle = headerList[1];
    setState(() {});
  }

  Future<void> getUser(User user) async {
    print("===========get user================");
    // await UserRepository.addUser(userModel)
    final result = await UserRepository.getUserByID(user.uid);
    print(user.uid);
    print("========= result ===============");
    print(result["achievement"].runtimeType);
    print(result["achievement"]);
    // List<dynamic> test = result["achievement"];
    // List<Map<String, dynamic>> json;
    // test.forEach((element) {
    //   // Map<String, dynamic> ele = element;
    //   print("=== element ===");
    //   print(element.runtimeType);
    //   print(element);
    // });

    if (result != null) {
      UserModel _userModel = UserModel.fromJson(result);
      // _userModel.getAchievement(result);
      // print(_userModel.);
      print("========= usermodel ===============");
      AuthProvider.of(context).setUserModel(_userModel);
    }
  }

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    return firebaseApp;
  }

  void login() async {
    String email = emailCtl.text;
    String pwd = "123123123";

    bool isValid = EmailValidator.validate(email);
    if (!isValid) {
      SmartDialog.showToast("email invalid");
      return;
    } else {
      SmartDialog.showLoading(
          backDismiss: false, background: Colors.transparent);

      int _result = 0;

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: pwd);
        print("--------------signInWithEmailAndPassword-----------------");
        print(userCredential.user!);
        await getUser(userCredential.user!);
        _result = 1;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          // UserCredential userCredential = await FirebaseAuth.instance
          //     .createUserWithEmailAndPassword(email: email, password: pwd);
          // print("================  create new user============== ");
          // print(userCredential.user!);
          // _result = 2;
        } else if (e.code == 'wrong-password') {
          _result = 3;
        } else {
          _result = 4;
        }
      }
      SmartDialog.dismiss();

      await toDoResult(_result);
    }
  }

  Future<void> toDoResult(int result) async {
    switch (result) {
      case 1:
        SmartDialog.showToast(
          LocalText.LoginSuccess,
        );
        // Navigator.of(context).pushReplacementNamed(RouteName.Verify);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const VerifyTest(),
          ),
        );

        break;

      case 2:
        SmartDialog.showToast(
          LocalText.SignupandLogin,
        );
        Navigator.of(context).pushReplacementNamed(RouteName.Verify);
        break;

      case 3:
        SmartDialog.showToast(LocalText.WrongPwd);
        break;
      default:
        SmartDialog.showToast(
          LocalText.NetError,
          alignment: Alignment.topCenter,
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
              Positioned(
                bottom: 80,
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(width: 340),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailCtl,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      },
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                      autocorrect: true,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Enter a email',
                        hintStyle: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white60,
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
              ),
              LoginButton(
                  context,
                  () => {
                        if (_formKey.currentState!.validate()) {login()}
                      },
                  "Next")
            ],
          ),
        ),
      ),
    );
  }
}
