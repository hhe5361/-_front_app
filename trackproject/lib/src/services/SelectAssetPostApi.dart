import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:trackproject/src/utilities/api_endpoint.dart';

//delete cover, 두 개 api 더 연결해야 한다.
class SelectAssetPostApi {
  Future<bool?> postfiles(
      {required String imagefile,
      required String recordfile,
      required String videofile,
      required bool islink}) async {
    Uri url;
    if (islink == true) {
      url = Uri.parse(baseuri + savefile_youtube_endpoint);
    } else {
      url = Uri.parse(baseuri + savefile_endpoint);
    }

    try {
      var req = http.MultipartRequest('POST', url);
      req.files.add(await http.MultipartFile.fromPath('img', imagefile));
      req.files.add(await http.MultipartFile.fromPath('rec', recordfile));
      if (islink) {
        req.fields['url'] = videofile;
      } else {
        req.files.add(await http.MultipartFile.fromPath('vid', videofile));
      }

      var res = await req.send();

      if (res.statusCode == 200) {
        debugPrint('업로드 성공');
        return true;
      } else {
        debugPrint('업로드 실패. 응답 코드: ${res.statusCode}');
        return false;
      }
    } catch (e) {
      debugPrint('에러 발생: $e');
      return null;
    }
  }
}
