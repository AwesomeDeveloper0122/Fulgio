import 'dart:convert';

// import 'package:allger/Models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class UserRepository {
  static String _userCollectionname = "users";

  // static Future<void> addUser(UserModel userModel) async {
  //   print("------------ Rposiosdgag--------------");
  //   final DatabaseReference _usersRef = FirebaseDatabase.instance
  //       .reference()
  //       .child('$_userCollectionname/${userModel.uid}');
  //   await _usersRef.set(userModel.toJson());
  // }

  // Get User with ID
  static Future getUserByID(String uid) async {
    DocumentSnapshot currentUser =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    print("==== current User ===========");
    print(currentUser.data());

    // return (currentUser.data() != null)
    //     ? jsonDecode(jsonEncode(currentUser.data()))
    //     : null;
    return currentUser.data();

    // DataSnapshot snap = await FirebaseDatabase.instance
    //     // ignore: deprecated_member_use
    //     .reference()
    //     .child('users')
    //     .child(uid)
    //     .get();

    // jsonEncode(snap.value);
    // print(jsonDecode(jsonEncode(snap.value)));
    // ignore: unnecessary_null_comparison
    // return (snap != null) ? jsonDecode(jsonEncode(snap.value)) : null;
  }

  // Update User
  // static Future<void> updateUser(UserModel userModel) async {
  //   print("------------ Rposiosdgag--------------");
  //   final DatabaseReference _usersRef = FirebaseDatabase.instance
  //       .reference()
  //       .child('$_userCollectionname/${userModel.uid}');
  //   await _usersRef.update(userModel.toJson());
  // }
}
