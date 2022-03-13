import 'package:Fuligo/screens/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:Fuligo/utils/common_colors.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

// ignore: non_constant_identifier_names
Widget PrimaryButton(context, StatefulWidget page, String txt) => Positioned(
      bottom: 30,
      child: Center(
        child: SizedBox(
          height: 50,
          width: 360,
          // ignore: deprecated_member_use
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            color: bgColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => page,
                ),
              );
              //  Navigator.of(context).pushReplacementNamed(page);
            },
            textColor: bgColor,
            child: Text(
              txt,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
// ignore: non_constant_identifier_names
Widget CancelButton(context, String txt) => Positioned(
      bottom: 30,
      child: Center(
        child: SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.85,
          // ignore: deprecated_member_use
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
              side: BorderSide(color: Colors.white70, width: 2),
            ),
            color: Colors.transparent,
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: whiteColor,
            child: Text(
              txt,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
// ignore: non_constant_identifier_names
Widget LoginButton(context, Function func, String txt) => Positioned(
      bottom: 30,
      child: Center(
        child: SizedBox(
          height: 50,
          width: 340,
          // ignore: deprecated_member_use
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            color: bgColor,
            onPressed: () {
              func();
            },
            textColor: bgColor,
            child: Text(
              txt,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );

Widget CustomButton(context, StatefulWidget page, String txt) => SizedBox(
      height: 50,
      width: 340,
      // ignore: deprecated_member_use
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        color: bgColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ),
          );
          //  Navigator.of(context).pushReplacementNamed(page);
        },
        textColor: bgColor,
        child: Text(
          txt,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );

Widget CanelButton(context, StatefulWidget page, String txt) => SizedBox(
      height: 50,
      width: 340,
      // ignore: deprecated_member_use
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
          side: BorderSide(color: whiteColor, width: 2),
        ),
        color: Colors.transparent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ),
          );
          //  Navigator.of(context).pushReplacementNamed(page);
        },
        textColor: whiteColor,
        child: Text(
          txt,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
Widget MenuButton(context) => Positioned(
      top: 50,
      left: 20,
      child: GestureDetector(
        onTap: () => {_show()},
        child: Image.asset(
          'assets/images/png/icon-menu-small.png',
          scale: 0.8,
        ),
      ),
      // child: const Icon(
      //   Icons.menu,
      //   size: 50,
      //   color: Colors.white,
      // ),
    );
Widget CrossButton(context) => Positioned(
      top: 50,
      left: 20,
      child: GestureDetector(
        onTap: () => {(SmartDialog.dismiss())},
        child: Image.asset(
          'assets/images/png/icon-cross.png',
          scale: 0.8,
        ),
      ),
    );
void _show() {
  SmartDialog.show(
    widget: MenuScreen(),
  );
}
