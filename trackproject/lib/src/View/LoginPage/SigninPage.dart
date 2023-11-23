import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackproject/src/View/LoginPage/WelcomePage.dart';
import 'package:trackproject/src/provider/UserProvider.dart';
import 'package:trackproject/src/utilities/Font_const.dart';
import 'package:trackproject/src/utilities/HexColor.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';
import 'package:trackproject/src/utilities/TextFormStyle.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _formKey = GlobalKey<FormState>();
  String? _id;
  String? _password;
  String? _email;

  Future<dynamic> showprogress() {
    return showDialog(
      context: context,
      builder: (context) {
        return Consumer<SignupProvider>(
          builder: (context, userProvider, child) {
            if (userProvider.status == LoginStatus.loading) {
              return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator());
            } else if (userProvider.status == LoginStatus.isauth) {
              return AlertDialog(
                content: const Text("회원가입 성공!"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => WelComePage()));
                      },
                      child: const Text("확인"))
                ],
              );
            } else {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10), // 추가: 텍스트와 버튼 사이 여백 조절
                    const Text("회원가입 실패!"),
                    const SizedBox(height: 10), // 추가: 텍스트와 버튼 사이 여백 조절
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("확인"),
                    ),
                  ],
                ),
              );
              // 로그인 실패 시 AlertDialog 표시하는 코드 추가
            }
          },
        );
      },
    );
  }

  Widget rendertextformfield() {
    return Form(
      key: _formKey,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        TextFormField(
          validator: (v) {
            if (v == null) {
              return "can't null";
            }
            return null;
          },
          onSaved: (newValue) {
            _id = newValue;
          },
          decoration: myinputdecoration(const Icon(Icons.person), "ID"),
        ),
        const SizedBox(
          height: 7,
        ),
        TextFormField(
          obscureText: true,
          validator: (v) {
            if (v == null) {
              return "can't null";
            } else if (v.length < 5) {
              return "적어도 10자 이상은 적어주세요";
            }
            return null;
          },
          onSaved: (newValue) {
            _password = newValue;
          },
          decoration: myinputdecoration(const Icon(Icons.key), "password"),
        ),
        const SizedBox(
          height: 7,
        ),
        TextFormField(
          validator: (v) {
            if (v == null) {
              return "can't null";
            } else if (!v.contains('@')) {
              return "email 형식에 맞게 적어주세요";
            } else if (v.length < 5) {
              return "적어도 10자 이상은 적어주세요";
            }
            return null;
          },
          onSaved: (newValue) {
            _email = newValue;
          },
          decoration: myinputdecoration(const Icon(Icons.email), "email"),
        ),
      ]),
    );
  }

  Widget signinbutton() {
    return TextButton(
        style: mybuttonstyle(color: ColorGrey),
        onPressed: () {
          final formkeystate = _formKey.currentState!;
          if (formkeystate.validate()) {
            formkeystate.save();
            Provider.of<SignupProvider>(context, listen: false)
                .trysignup(_id!, _password!, _email!);
            showprogress();
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            "동의하고 회원가입하기",
            style: fontmedi(13),
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
            Text(
              "표시되어 있는 것은 필수로 작성해주세요",
              style: fontDetails(10),
            ),
            const SizedBox(
              height: 15,
            ),
            rendertextformfield(),
            const SizedBox(
              height: 25,
            ),
            signinbutton()
          ],
        ),
      ),
    );
  }
}
