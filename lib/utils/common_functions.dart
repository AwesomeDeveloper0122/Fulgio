import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>> getTitle(pageName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String headerList = prefs.getString('headerlist').toString();
  var header = jsonDecode(headerList)[pageName];
  var title = header['title'];
  var subtitle = header['subtitle'];
  List<String> a = [title, subtitle];

  return a;
}
