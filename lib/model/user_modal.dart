import 'dart:convert';

class UserModel {
  String uid;
  String username;

  String avatar;
  String email;

  UserModel({
    this.uid = "",
    this.username = "",
    this.avatar = "",
    this.email = "",
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
    };
  }
}
