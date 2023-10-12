import 'package:dio/dio.dart';

//select data들 api 정리
class ApiService {
  final String _uri = ""; // uri 먼저 정의해야 함.
  final Dio _dio = Dio();

  //data 쏘는 거 잘되면
  Future<void> postimage(FormData image) async {
    Response rep = await _dio.post(_uri + "api/image/saveImage",
        data: image,
        options: Options(contentType: Headers.multipartFormDataContentType));
    statuscheck(rep);
  }

  Future<void> deletedata({required String path}) async {
    final rep = await _dio.delete(_uri + path);
    statuscheck(rep);
  }

  void statuscheck(Response rep) {
    switch (rep.statusCode) {
      case 200:
        return;
      case 301:
      case 400:
      default:
        throw "error";
    }
  }
}
