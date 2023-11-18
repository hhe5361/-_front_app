import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

AppBar myappbar = AppBar(
  title: Row(
    children: [
      const Text(
        "저세계 아이돌",
        style: TextStyle(color: Colors.black),
      ),
      const SizedBox(
        width: 10,
      ),
      SvgPicture.asset(
        "assets/icon/logo.svg",
      ),
    ],
  ),
  centerTitle: false,
  elevation: 0.5,
  backgroundColor: Colors.white,
);

AppBar myappbar2(String title) => AppBar(
      iconTheme: const IconThemeData(
        color: Colors.black, //change your color here
      ),
      title: Text(title,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold)),
      centerTitle: true,
      elevation: 0.5,
      backgroundColor: Colors.white,
    );

AppBarTheme appbartheme = const AppBarTheme(
    color: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w300,
      fontSize: 20,
    ),
    centerTitle: true,
    elevation: 0.5,
    iconTheme: IconThemeData(color: Colors.black));

BoxDecoration box1({Color color = Colors.grey}) {
  return BoxDecoration(borderRadius: BorderRadius.circular(10), color: color);
}

ButtonStyle mybuttonstyle({Color color = Colors.black}) {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all(color),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
  );
}

ThemeData mythemedata = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
    appBarTheme: appbartheme,
    fontFamily: 'PretendBold');
