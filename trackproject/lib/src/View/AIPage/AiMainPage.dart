import 'package:flutter/material.dart';
import 'package:trackproject/src/View/AIPage/CreatePage.dart';
import 'package:trackproject/src/utilities/Font_const.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';
import 'package:trackproject/src/utilities/mediasize.dart';

class MainAiPage extends StatelessWidget {
  const MainAiPage({super.key});
  get spacer => Text(
        '   ',
        style: mystyle,
      );
  Widget _renderimage() => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.grey),
        //padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.fromLTRB(25, 15, 25, 10),
        height: mediaheight * 0.2,
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage('assets/image/DancingTrump.gif'),
                fit: BoxFit.cover,
              )),
        ),
      );

  //Widget _button() => ElevatedButton(onPressed: (){}, child: );
  Widget _renderText() => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.black),
        //padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
        padding: const EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              spacer,
              Text(
                '나는.. 춤도 못추고..',
                style: mystyle,
              ),
              Text(
                '나는.. 노래도 못부르고..',
                style: mystyle,
              ),
              Text(
                '아이돌처럼 춤도 잘 추고\n 노래도 잘 부를 순 없을까..?',
                textAlign: TextAlign.center,
                style: mystyle,
              ),
              Text(
                '트럼프가 춤을 잘 추는 것처럼 어쩌면 나도..!',
                style: mystyle,
              ),
              spacer,
              Text(
                '생성 모델을 활용하여 노래 커버부터\n 춤 커버 영상 제작 서비스!!!',
                textAlign: TextAlign.center,
                style: mystyle,
              ),
              spacer,
              Text(
                '아이돌이 되고 싶은 사람의 전신 사진',
                style: mystyle,
              ),
              Text(
                textAlign: TextAlign.center,
                '잘 추고 싶은 춤의 영상',
                style: mystyle,
              ),
              Text(
                '되고 싶은 목소리만 있다면..!',
                style: mystyle,
              ),
              spacer,
              const Text(
                '누. 구. 나. 아이돌이 될 수 있어요~!',
                style: TextStyle(
                  color: Colors.lightGreen,
                  fontSize: 18.0,
                ),
              ),
              spacer,
            ],
          ),
        ),
      );

  Widget _renderbutton(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 100),
        child: FilledButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CreatePage()));
          },
          style: mybuttonstyle(color: Colors.black87),
          child: const Text(
            "Get Start",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ListView(
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[_renderimage(), _renderText(), _renderbutton(context)],
    );
  }
}
