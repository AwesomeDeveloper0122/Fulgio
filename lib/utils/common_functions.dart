import 'dart:convert';

import 'package:Fuligo/model/user_modal.dart';
import 'package:Fuligo/provider/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>> getTitle(pageName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String headerList = prefs.getString('headerlist').toString();
  var header = jsonDecode(headerList)![pageName];
  var title = header['title'];
  var subtitle = header['subtitle'];
  List<String> a = [title, subtitle];

  return a;
}

Future<void> showConfirm(BuildContext context, String str, String url) async {
  showPlatformDialog(
    context: context,
    builder: (_) => BasicDialogAlert(
      title:
          str == "tracking" ? Text("Enable tracking?") : Text("Change avatar?"),
      content: Text("Are you really?"),
      actions: <Widget>[
        BasicDialogAction(
          title: Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        BasicDialogAction(
          title: Text("Confirm"),
          onPressed: () {
            str == "tracking" ? tracking() : changeAvatar(context, url);
          },
        ),
      ],
    ),
  );
}

changeAvatar(BuildContext context, String url) {
  print("Change Avatar");
  UserModel _userInfo = AuthProvider.of(context).userModel;
  _userInfo.avatar = url;
  AuthProvider.of(context).setUserModel(_userInfo);
  print("_userInfo.avatar");
  print(_userInfo.avatar);
}

tracking() {
  print("click evnet");
}
