import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trackproject/src/utilities/api_endpoint.dart';

class LoginApi {
  Future<String?> login({required String id, required String password}) async {
    final Uri uri = Uri.parse(baseuri + port_user + login_endpoint);
    final Map<String, String> data = {'id': id, 'password': password};
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http
          .post(
            uri,
            headers: headers,
            body: jsonEncode(data),
          )
          .timeout(const Duration(seconds: 3));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData['token'];
      } else {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        debugPrint("login error : network success but error  " +
            responseData['error']);
        return null;
      }
    } catch (e) {
      debugPrint("login error : " + e.toString());
      return null;
    }
  }

  Future<bool?> signup(
      {required String id,
      required String password,
      required String email}) async {
    final Uri uri = Uri.parse(baseuri + port_user + sign_endpoint);
    final Map<String, String> formatdata = {
      'id': id,
      'password': password,
      'email': email
    };
    final headers = {'Content-Type': 'application/json'};

    try {
      final res = await http
          .post(uri, body: jsonEncode(formatdata), headers: headers)
          .timeout(const Duration(seconds: 3));

      if (res.statusCode == 200) {
        debugPrint("signup success");
        //final resdata = jsonDecode(res.body);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("login error : " + e.toString());
      return null;
    }
  }
}
