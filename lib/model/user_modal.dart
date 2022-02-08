import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserModel {
  String uid;
  String username;

  String avatar;
  String email;
  // List<Reference>? archievement;

  UserModel({
    this.uid = "",
    this.username = "",
    this.avatar = "",
    this.email = "",
    // this.archievement,
  });

  UserModel.fromJson(Map json)
      : uid = (json['uid'] != null) ? json['uid'] : "",
        username = (json['username'] != null) ? json['username'] : "",
        avatar = (json['avatar'] != null) ? json['avatar'] : "",
        email = (json['email'] != null) ? json['email'] : "";

  Map<String, dynamic> toJson() {
    return {
      "uid": (uid == null) ? "" : uid,
      "username": (username == null) ? "" : username,
      "avatar": (avatar == null) ? "" : avatar,
      "email": (email == null) ? "" : email,
      // "archievement": (archievement == null) ? [] : convertList(archievement!),
    };
  }

  List convertList(List<Reference> list) {
    return list.map((item) {
      return {
        item,
      };
    }).toList();
  }
}
