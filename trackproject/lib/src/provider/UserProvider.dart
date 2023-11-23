import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trackproject/src/models/UserInfo.dart';
import 'package:trackproject/src/services/UserLogin.dart';

enum LoginStatus { isnotlogin, loading, islogin, faillogin, isauth, failauth }

class UserProvider extends ChangeNotifier {
  final LoginApi _api = LoginApi();
  LoginStatus _islogin = LoginStatus.isnotlogin;
  User? _user;

  get status => _islogin;
  get name => _user!.id;

  void setstatus(LoginStatus status) {
    _islogin = status;
    notifyListeners();
  }

  Future<void> login(String id, String password) async {
    setstatus(LoginStatus.loading);

    var result = await _api.login(id: id, password: password);
    if (result != null) {
      _user = User(id: id, password: password, token: result);
      setstatus(LoginStatus.islogin);
    } else {
      setstatus(LoginStatus.faillogin); //message 띄워야 하나?
    }
  }
}

class SignupProvider extends ChangeNotifier {
  final LoginApi _api = LoginApi();
  LoginStatus? _authpass = null;

  get status => _authpass;

  void setstatus(LoginStatus status) {
    _authpass = status;
    notifyListeners();
  }

  Future<void> trysignup(String id, String password, String email) async {
    setstatus(LoginStatus.loading);

    var result = await _api.signup(id: id, password: password, email: email);
    if (result == null) {
      setstatus(LoginStatus.failauth);
    } else if (result == true) {
      setstatus(LoginStatus.isauth); //message 띄워야 하나?
    } else {
      setstatus(LoginStatus.failauth);
    }
  }
}
