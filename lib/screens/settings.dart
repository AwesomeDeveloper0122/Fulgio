import 'package:Fuligo/model/user_model.dart';

import 'package:Fuligo/provider/auth_provider.dart';
import 'package:Fuligo/widgets/popup.dart';

import 'package:Fuligo/widgets/custom_button.dart';

import 'package:flutter/material.dart';
import 'package:Fuligo/utils/common_colors.dart';
import 'package:accordion/accordion.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();

    // setState(() {});
  }

  Future<void> saveLang(value) async {
    switch (value) {
      case lang.en_GB:
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('lang', "en_GB");

        break;
      case lang.de_CH:
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('lang', "de_CH");
        break;

      case lang.nl_NL:
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('lang', "nl_NL");
        break;

      default:
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('lang', "en_GB");
    }

    SmartDialog.showToast("changed language");
  }

  final _headerStyle = const TextStyle(
      decoration: TextDecoration.none,
      color: Color(0xffffffff),
      fontSize: 20,
      fontWeight: FontWeight.bold);
  final _contentStyleHeader = const TextStyle(
      decoration: TextDecoration.none,
      color: Color(0xff999999),
      fontSize: 14,
      fontWeight: FontWeight.w700);
  final _contentStyle = const TextStyle(
      decoration: TextDecoration.none,
      color: Color(0xff999999),
      fontSize: 14,
      fontWeight: FontWeight.normal);
  String currentLang = "";

  lang? _mitem;

  Widget build(BuildContext context) {
    UserModel _userInfo = AuthProvider.of(context).userModel;

    print("========= userInfo ============");

    return Container(
      decoration: const BoxDecoration(
        color: bgColor,
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [gradientFrom, bgColor]),
      ),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Accordion(
              paddingListTop: 150,
              maxOpenSections: 1,
              headerBackgroundColorOpened: Colors.black54,
              headerPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              children: [
                AccordionSection(
                  isOpen: false,
                  leftIcon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 30,
                  ),
                  headerBackgroundColor: bgColor,
                  // headerBackgroundColorOpened: Colors.red,
                  header: Text('Language', style: _headerStyle),

                  content: Container(
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(color: whiteColor),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          minVerticalPadding: 0,
                          title: const Text(
                            'Germany',
                            style: TextStyle(color: Colors.black),
                          ),
                          trailing: Radio<lang>(
                            activeColor: Colors.black,
                            value: lang.de_CH,
                            groupValue: _mitem,
                            onChanged: (lang? value) {
                              saveLang(value);
                              setState(() {
                                _mitem = value;
                              });
                            },
                          ),
                        ),
                        // const Divider(
                        //   thickness: 2,
                        //   color: Colors.grey,
                        // ),
                        ListTile(
                          title: const Text(
                            'English',
                            style: TextStyle(color: Colors.black),
                          ),
                          trailing: Radio<lang>(
                            value: lang.en_GB,
                            activeColor: Colors.black,
                            groupValue: _mitem,
                            onChanged: (lang? value) {
                              saveLang(value);
                              setState(() {
                                _mitem = value;
                              });
                            },
                          ),
                        ),

                        ListTile(
                          title: const Text(
                            'Detch',
                            style: TextStyle(color: Colors.black),
                          ),
                          trailing: Radio<lang>(
                            activeColor: Colors.black,
                            value: lang.nl_NL,
                            groupValue: _mitem,
                            onChanged: (lang? value) {
                              saveLang(value);
                              setState(() {
                                _mitem = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                  // sectionClosingHapticFeedback: SectionHapticFeedback.vibrate,
                ),
              ],
            ),
          ),
          CrossButton(context),
        ],
      ),
    );
  }
}
