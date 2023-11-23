import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:trackproject/src/View/LoginPage/LoginPage.dart';
import 'package:trackproject/src/provider/UserProvider.dart';
import 'package:trackproject/src/utilities/Font_const.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';
import 'package:trackproject/src/utilities/mediasize.dart';

class MainUserPage extends StatelessWidget {
  MainUserPage({super.key});

  //login 되어 있는지 shared preference에서 확인하고 해야 할 듯? ㅇㅇ
  @override
  Widget build(BuildContext context) {
    UserProvider _provider = Provider.of<UserProvider>(context, listen: true);
    return _provider.status != LoginStatus.islogin
        ? const LoginPage()
        : myPage(context);
  }

  Widget showMyinfo(BuildContext context) {
    String myname = Provider.of<UserProvider>(context, listen: false).name;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/icon/welcomeuser.svg",
          height: mediawidth * 0.5,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const Text("오늘부터 아이돌이 될"), Text("$myname님!")],
        )
      ],
    );
  }

  Widget recentvideo() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: mediawidth * 0.6,
          height: mediaheight * 0.13,
          decoration: defaultDecobox(),
        );
      },
    );
  }

  Widget myPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 3,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: showMyinfo(context))),
          const Divider(
            color: Colors.black,
          ),
          const Text(
            "최근 제작 영상",
          ),
          Text(
            "최대 15개의 영상만 저장합니다.",
            style: fontDetails(11),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(flex: 9, child: recentvideo())
        ],
      ),
    );
  }
}
