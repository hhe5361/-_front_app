import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trackproject/src/utilities/Font_const.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';

class WelComePage extends StatelessWidget {
  const WelComePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myappbar2("회원가입"),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            flex: 6,
            child: SvgPicture.asset(
              'assets/icon/welcomeuser.svg',
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(children: [
              Text(
                "저세계 아이돌의 연습생이 되신\n 당신을 진심으로 환영합니다!",
                textAlign: TextAlign.center,
                style: fontmedi(17),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("로그인 하러가기"),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
