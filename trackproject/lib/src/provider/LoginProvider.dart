import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trackproject/src/models/UserInfo.dart';
import 'package:trackproject/src/services/UserLogin.dart';

class LoginProvider with ChangeNotifier {
  final LoginApi _api = LoginApi();
  bool _islogin = false;
  User? _user;

  Future<void> login() async {
    try {
      var result = await _api.login();
      if (result != null) {
        _islogin = true;
      } else {
        //"error message handling 해야 한다." <- 요구하기.
      }
    } catch (e) {
      //error handling
    }
    notifyListeners();
  }
}
