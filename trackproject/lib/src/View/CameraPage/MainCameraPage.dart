import 'package:flutter/material.dart';
import 'package:trackproject/src/View/AIPage/ImageSelectPage.dart/fortest.dart';

class MainCameraPage extends StatelessWidget {
  const MainCameraPage({super.key});

  Widget _renderclickbutton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(5),
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient:
                LinearGradient(colors: [Colors.greenAccent, Colors.white])),
        child: Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white)),
      ),
    );
  }

  //gallery 연결 예정
  Widget _rendergallery(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return SampleScreen();
            },
          ));
        },
        child: Container(
          width: 60,
          height: 60,
          color: Colors.grey,
        ));
  }

  @override
  Widget build(BuildContext context) {
    double mediah = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 수직 방향으로 공간을 균등하게 분배
      children: [
        Container(
          height: mediah * 0.64,
          width: double.infinity,
          color: Colors.grey,
        ),
        Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              _rendergallery(context),
              _renderclickbutton(),
              Container(
                width: 60,
                height: 60,
              )
            ]))
      ],
    );
  }
}
