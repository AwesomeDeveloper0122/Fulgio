import 'package:flutter/material.dart';
import 'package:Fuligo/utils/common_colors.dart';

// ignore: non_constant_identifier_names
Widget CustomButtonTest(context, StatefulWidget page, String txt) => Positioned(
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
Widget CancelButtonTest(context, StatefulWidget page, String txt) => Positioned(
      bottom: 30,
      child: Center(
        child: SizedBox(
          height: 50,
          width: 360,
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
