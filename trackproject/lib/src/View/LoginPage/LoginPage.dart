import 'package:flutter/material.dart';
import 'package:trackproject/src/View/LoginPage/SigninPage.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';
import 'package:trackproject/src/utilities/TextFormStyle.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  Widget rendertextformfield() {
    return Form(
      key: _formKey,
      child: Column(children: [
        TextFormField(
          validator: (v) {},
          decoration: myinputdecoration(const Icon(Icons.person), "ID"),
        ),
        TextFormField(
          validator: (v) {},
          decoration: myinputdecoration(const Icon(Icons.key), "password"),
        )
      ]),
    );
  }

  Widget loginbutton() {
    return TextButton(
        style: mybuttonstyle(color: Colors.grey),
        onPressed: () {
          final formkeystate = _formKey.currentState!;
          if (formkeystate.validate()) {
            formkeystate.save();
            //다음 페이지로 넘어가는 거거
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 70),
          child: const Text(
            "로그인",
            style: TextStyle(color: Colors.black),
          ),
        ));
  }

  Widget renderdetail(Widget A, String? des) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => A));
      },
      child: Text(des!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 45, 50, 0),
      child: Column(
        children: [
          rendertextformfield(),
          const SizedBox(height: 30),
          loginbutton(),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              renderdetail(const SigninPage(), "아이디 찾기"),
              renderdetail(const SigninPage(), "비밀번호 찾기"),
              renderdetail(const SigninPage(), "회원가입"),
            ],
          )
        ],
      ),
    );
  }
}
