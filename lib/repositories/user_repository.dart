// import 'package:allger/Models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  static String _userCollectionname = "users";

  static Future<void> addUser(String id) async {
    DocumentReference ref;

    CollectionReference user = FirebaseFirestore.instance.collection('users');
    QuerySnapshot avatarSnapshot =
        await FirebaseFirestore.instance.collection('avatar').get();
    for (var item in avatarSnapshot.docs) {
      if (item["isDefault"] == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('defaultAvatar', item["app_img"]!);
        ref = FirebaseFirestore.instance.collection('avatar').doc(item.id);
        user
            .doc(id)
            .set({'uid': id, "avatar": ref}, SetOptions(merge: true))
            .then((value) => {})
            .catchError((error) => {});
        break;
      }
    }
  }

  // Get User with ID
  static Future getUserByID(String uid) async {
    String url;
    Map userdata;
    /////////////////////

    /////////////////////
    DocumentSnapshot currentUser =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    CollectionReference user = FirebaseFirestore.instance.collection('users');
    QuerySnapshot avatarSnapshot =
        await FirebaseFirestore.instance.collection('avatar').get();
    for (var item in avatarSnapshot.docs) {
      if (item["isDefault"] == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('defaultAvatar', item["app_img"]!);

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
