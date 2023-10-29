import 'package:flutter/material.dart';

AppBar myappbar = AppBar(
  title: const Text(
    "저세계 아이돌",
    style: TextStyle(color: Colors.black),
  ),
  elevation: 0.5,
  backgroundColor: Colors.white,
);

AppBar myappbar2(String title) => AppBar(
      title: Text(title,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold)),
      centerTitle: true,
      elevation: 0.5,
      backgroundColor: Colors.white,
    );

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

ThemeData mythemedata =
    ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.white));
