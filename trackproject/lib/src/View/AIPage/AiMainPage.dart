import 'package:flutter/material.dart';
import 'package:trackproject/src/View/AIPage/CreatePage.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';

class MainAiPage extends StatelessWidget {
  const MainAiPage({super.key});

  Widget _renderimage() => Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey),
      //padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.fromLTRB(25, 15, 25, 10),
      height: 200);

  //Widget _button() => ElevatedButton(onPressed: (){}, child: );
  Widget _renderText() => Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey),
      //padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
      height: 200);

  Widget _renderbutton(BuildContext context) => ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreatePage()));
        },
        style: mybuttonstyle(color: Colors.black),
        child: const Text(
          "Get Start",
          style: TextStyle(color: Colors.white),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[_renderimage(), _renderText(), _renderbutton(context)],
    );
  }
}
