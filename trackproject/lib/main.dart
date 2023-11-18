import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackproject/src/View/AppThema.dart';
import 'package:trackproject/src/provider/YoutubeLinkeProvider.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';
import 'package:trackproject/src/utilities/mediasize.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      //ChangeNotifierProvider(create: (context) => ImageAlbumProvider()),
      ChangeNotifierProvider(create: (context) => YoutubeLinkProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    mediaheight = MediaQuery.of(context).size.height;
    mediawidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: mythemedata,
      home: const AppThema(),
    );
  }
}
