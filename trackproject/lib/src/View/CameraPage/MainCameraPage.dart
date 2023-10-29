import 'package:flutter/material.dart';

class MainCameraPage extends StatelessWidget {
  const MainCameraPage({super.key});

  Widget renderclickbutton() {
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

  @override
  Widget build(BuildContext context) {
    double mediah = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          height: mediah * 0.64,
          width: double.infinity,
          color: Colors.grey,
        ),
        renderclickbutton(),
      ],
    );
  }
}
