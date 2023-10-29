import 'package:dio/dio.dart';
import 'package:trackproject/src/models/UserInfo.dart';

class LoginApi {
  late User user;

  Future trylogin() async {
    var dio = Dio();

    return await dio.request('path',
        data: {}, options: Options(method: 'POST'));
  }
}
