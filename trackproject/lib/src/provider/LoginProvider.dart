import 'package:flutter/material.dart';
import 'package:trackproject/src/models/UserInfo.dart';
import 'package:trackproject/src/services/UserLogin.dart';

class LoginProvider with ChangeNotifier {
  LoginApi _api = LoginApi();
  User? _user;

  Future<bool> login() async {
    try {
      await _api.trylogin();
      return true;
    } catch (e) {
      return false;
    }
  }
}
