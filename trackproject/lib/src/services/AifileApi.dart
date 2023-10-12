import 'package:dio/dio.dart';
import 'package:trackproject/src/models/AiFIleModel.dart';

class AiFileService {
  final _dio = Dio();

  Future<AifileModel> getAiFile() async {
    Response rep = await _dio.get('api/ai/getFile');
    if (rep.statusCode != 200) throw "exception";

    return AifileModel.fromJson(rep.data); //aifilemodel data넘김
  }
}
