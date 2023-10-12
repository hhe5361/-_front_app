import 'package:flutter/material.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';

class ImageSelectPage extends StatelessWidget {
  const ImageSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myappbar2("사진 선택하기"),
      body: Container(
        color: Colors.amber,
      ),
    );
  }
}
