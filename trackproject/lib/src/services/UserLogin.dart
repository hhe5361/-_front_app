import 'package:dio/dio.dart';
import 'package:trackproject/src/models/UserInfo.dart';

class LoginApi {
  late User user;

  Future login() async {
    var dio = Dio();

    Response response =
        await dio.request('path', data: {}, options: Options(method: 'POST'));
    if (response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }
}
