import 'package:flutter/material.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';
import 'package:trackproject/src/utilities/TextFormStyle.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _formKey = GlobalKey<FormState>();

  Widget rendertextformfield() {
    return Form(
      key: _formKey,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        TextFormField(
          validator: (v) {},
          decoration: myinputdecoration(const Icon(Icons.person), "ID"),
        ),
        const SizedBox(
          height: 7,
        ),
        TextFormField(
          validator: (v) {},
          decoration: myinputdecoration(const Icon(Icons.key), "password"),
        ),
        const SizedBox(
          height: 7,
        ),
        TextFormField(
          validator: (v) {},
          decoration: myinputdecoration(const Icon(Icons.email), "email"),
        ),
        const SizedBox(
          height: 7,
        ),
        TextFormField(
          validator: (v) {},
          decoration: myinputdecoration(
              const Icon(Icons.phone_android), "phone number"),
        ),
      ]),
    );
  }

  Widget signinbutton() {
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
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: const Text(
            "동의하고 회원가입하기",
            style: TextStyle(color: Colors.black),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myappbar2("회원가입"),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 5),
        child: ListView(
          children: [
            const Text("회원정보를 입력해주세요"),
            const Text("표시되어 있는 것은 필수로 작성해주세요"),
            rendertextformfield(),
            signinbutton()
          ],
        ),
      ),
    );
  }
}
