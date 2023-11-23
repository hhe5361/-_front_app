import 'package:flutter/material.dart';
import 'package:trackproject/src/utilities/Font_const.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';
import 'package:trackproject/src/utilities/mediasize.dart';

class LoadingPage extends StatelessWidget {
  LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myappbar2("영상 제작"),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            'assets/icon/progress_test.gif',
          ),
          SizedBox(
            height: mediaheight * 0.1,
          ),
          const Text(
            "영상이 제작 중입니다!",
            style: fontTitle,
          )
        ]),
      ),
    );
  }
}
