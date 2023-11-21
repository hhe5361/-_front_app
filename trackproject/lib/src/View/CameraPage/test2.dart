import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:trackproject/src/View/CameraPage/test.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras(); //camera 권한 얻어오는 거 맞나?
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: PhotoScreen(cameras),
    );
  }
}
