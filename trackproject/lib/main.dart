import 'package:flutter/material.dart';
import 'package:trackproject/src/View/AppThema.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: mythemedata,
      home: const AppThema(),
    );
  }
}
