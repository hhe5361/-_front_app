import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trackproject/src/View/LoginPage/LoginPage.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';
import 'package:trackproject/src/utilities/mediasize.dart';

class MainUserPage extends StatelessWidget {
  MainUserPage({super.key});
  bool _ischecked = true;
  //login 되어 있는지 shared preference에서 확인하고 해야 할 듯? ㅇㅇ
  @override
  Widget build(BuildContext context) {
    return _ischecked ? LoginPage() : MyPage();
  }

  Widget showMyinfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/icon/welcomeuser.svg",
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("오늘부터 아이돌이 될"), Text("***님!")],
        )
      ],
    );
  }

  Widget recentvideo() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: mediawidth * 0.6,
          height: mediaheight * 0.13,
          decoration: box1(),
        );
      },
    );
  }

  Widget MyPage() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 3,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: showMyinfo())),
          const Divider(
            color: Colors.black,
          ),
          Text(
            "최근 제작 영상",
          ),
          Text("최대 15개의 영상만 저장합니다."),
          Expanded(flex: 8, child: recentvideo())
        ],
      ),
    );
  }
}
