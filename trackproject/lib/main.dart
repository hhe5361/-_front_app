import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackproject/src/View/AppThema.dart';
import 'package:trackproject/src/provider/AlbumData.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ImageAlbumProvider(), child: MyApp()));
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
