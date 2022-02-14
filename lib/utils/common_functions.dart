import 'dart:convert';

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

Future<void> showConfirm(BuildContext context, String str) async {
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
            str == "tracking" ? tracking() : changeAvatar();
          },
        ),
      ],
    ),
  );
}

changeAvatar() {
  print("Change Avatar");
}

tracking() {
  print("click evnet");
}
