// import 'package:allger/Models/user_model.dart';
import 'package:Fuligo/model/user_model.dart';
import 'package:Fuligo/provider/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  static String _userCollectionname = "users";

  static Future<void> addUser(String id) async {
    String result;
    String defaultImgId;
    DocumentReference ref;
    print("------------ Add user--------------");
    CollectionReference user = FirebaseFirestore.instance.collection('users');
    QuerySnapshot avatarSnapshot =
        await FirebaseFirestore.instance.collection('avatar').get();
    for (var item in avatarSnapshot.docs) {
      if (item["isDefault"] == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('defaultAvatar', item["img"]!);
        ref = FirebaseFirestore.instance.collection('avatar').doc(item.id);
        user
            .doc(id)
            .set({'uid': id, "avatar": ref}, SetOptions(merge: true))
            .then((value) => result = "success")
            .catchError((error) => result = "error");
        break;
      }
    }
  }

  // Get User with ID
  static Future getUserByID(String uid) async {
    String url;
    Map userdata;
    DocumentSnapshot currentUser =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    print("==== current User ===========");
    CollectionReference user = FirebaseFirestore.instance.collection('users');
    QuerySnapshot avatarSnapshot =
        await FirebaseFirestore.instance.collection('avatar').get();
    for (var item in avatarSnapshot.docs) {
      if (item["isDefault"] == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('defaultAvatar', item["img"]!);

        break;
      }
    }
    return currentUser.data();
  }

  // static Future<void> getUserByUid(String id) async {
  //   final result = await UserRepository.getUserByID(id);
  //   print("getUser");
  //   print(result);
  //   if (result != null) {
  //     UserModel _userModel = UserModel.fromJson(result);
  //     AuthProvider.of(context).setUserModel(_userModel);
  //   }
  // }
}
