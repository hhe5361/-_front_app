import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackproject/src/View/AppThema.dart';
import 'package:trackproject/src/provider/AiFileProvider.dart';
import 'package:trackproject/src/provider/SelectAssetProvider.dart';
import 'package:trackproject/src/provider/UserProvider.dart';
import 'package:trackproject/src/provider/YoutubeLinkeProvider.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';
import 'package:trackproject/src/utilities/mediasize.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => YoutubeLinkProvider()),
      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context) => SignupProvider()),
      ChangeNotifierProvider(create: (context) => SelectAssetProvider()),
      //ChangeNotifierProvider(create: (context) => CameraProvider()),
      ChangeNotifierProvider(create: (context) => AiFileProvider()),
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
      debugShowCheckedModeBanner: false,
      title: '(주) 명 저세계 아이돌 엔터테인먼트',
      theme: mythemedata,
      home: const AppThema(),
    );
  }
}
