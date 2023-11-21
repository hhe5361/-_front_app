import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackproject/src/View/LoginPage/SigninPage.dart';
import 'package:trackproject/src/provider/UserProvider.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';
import 'package:trackproject/src/utilities/TextFormStyle.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String? _id;
  late String? _password;

  Future<dynamic> showprogress() {
    return showDialog(
      context: context,
      builder: (context) {
        return Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            if (userProvider.status == LoginStatus.loading) {
              return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator());
            } else if (userProvider.status == LoginStatus.islogin) {
              return const AlertDialog(
                content: Text("로그인 성공!"),
              );
            } else {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10), // 추가: 텍스트와 버튼 사이 여백 조절
                    const Text("로그인 실패!"),
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

  Widget loginbutton() {
    return TextButton(
      style: mybuttonstyle(color: Colors.grey),
      onPressed: () {
        final formkeystate = _formKey.currentState!;
        if (formkeystate.validate()) {
          formkeystate.save();
          Provider.of<UserProvider>(context, listen: false)
              .login(_id!, _password!);
          showprogress();
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 70),
        child: const Text(
          "로그인",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
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
    var idtextform = TextFormField(
      validator: (v) {
        if (v == null) {
          return "최소 5자 이상으로 입력해주세요";
        }
        return null;
      },
      onSaved: (newValue) => _id = newValue,
      decoration: myinputdecoration(const Icon(Icons.person), "ID"),
    );

    var passwordtextform = TextFormField(
      validator: (v) {
        if (v == null) {
          return "password를 입력해주세요";
        }
        return null;
      },
      onSaved: (newValue) => _password = newValue,
      decoration: myinputdecoration(const Icon(Icons.key), "password"),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 45, 50, 0),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(children: [idtextform, passwordtextform]),
          ),
          const SizedBox(height: 20),
          loginbutton(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              renderdetail(const SigninPage(), "아이디 찾기"),
              renderdetail(const SigninPage(), "비밀번호 찾기"),
              renderdetail(const SigninPage(), "회원가입"),
            ],
          ),
          const SizedBox(height: 20),
          // Consumer<UserProvider>(
          //   builder: (context, userProvider, child) {
          //     if (userProvider.status == LoginStatus.loading) {
          //       // 로딩 화면을 표시하는 코드 추가
          //       return const CircularProgressIndicator();
          //     } else if (userProvider.status == LoginStatus.islogin) {
          //       return const Text("로그인 성공!");
          //     } else {
          //       // 로그인 실패 시 AlertDialog 표시하는 코드 추가
          //       return const Text("로그인 실패!");
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}
