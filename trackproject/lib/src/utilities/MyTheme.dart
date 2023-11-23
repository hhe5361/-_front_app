import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trackproject/src/utilities/Font_const.dart';

AppBar myappbar = AppBar(
  title: Row(
    children: [
      const Text("저세계 아이돌", style: fontTitle),
      const SizedBox(
        width: 10,
      ),
      SvgPicture.asset(
        "assets/icon/app_logo.svg",
      ),
    ],
  ),
  centerTitle: false,
  elevation: 0.5,
  backgroundColor: Colors.white,
);

AppBar myappbar2(String title, [List<Widget>? actions, bool ishide = true]) =>
    AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(title, style: fontTitle),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.white,
        actions: actions == null ? null : actions,
        automaticallyImplyLeading: ishide);

AppBarTheme appbartheme = const AppBarTheme(
    color: Colors.white,
    titleTextStyle: fontTitle,
    centerTitle: true,
    elevation: 20,
    iconTheme: IconThemeData(color: Colors.black));

BoxDecoration defaultDecobox({Color color = Colors.grey}) {
  return BoxDecoration(borderRadius: BorderRadius.circular(20), color: color);
}

ButtonStyle mybuttonstyle({required Color color}) {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all(color),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
  );
}

ThemeData mythemedata = ThemeData(
  primaryColor: Colors.white,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
  appBarTheme: appbartheme,
  fontFamily: 'BaseFont',
  //useMaterial3: true,
);
