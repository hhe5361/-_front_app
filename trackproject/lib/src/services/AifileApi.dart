import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:trackproject/src/utilities/api_endpoint.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class AiFileService {
  Future<String?> checkapi() async {
    var url = Uri.parse(baseuri + port_file + checkfile_endpoint);

    try {
      var res = await http.get(url);

      if (res.statusCode == 200) {
        debugPrint("reponse ~!!" + res.body.toString());
        return res.body;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("checkfile error : $e");
      return null;
    }
  }

  Future<String?> getfile() async {
    var url = Uri.parse(baseuri + port_file + getfile_endpoint);

    try {
      var res = await http.get(url).timeout(const Duration(seconds: 4));
      if (res.statusCode == 200) {
        return res.body;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("getfile error :  $e");
      return null;
    }
  }

  //path 반환함.
  Future<String?> testGetFile() async {
    var url = Uri.parse(baseuri + port_file + '/ai/temp');
    debugPrint("기다리셈");
    await Future.delayed(Duration(minutes: 1));
    try {
      //time 해야 하는 부분
      var res = await http.get(url).timeout(const Duration(minutes: 1));
      if (res.statusCode == 200) {
        return res.body;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("getfile error :  $e");
      return null;
    }
  }

  Future<String?> downloadFile(String path) async {
    try {
      var res =
          await http.get(Uri.parse(path)).timeout(const Duration(minutes: 20));

      if (res.statusCode == 200) {
        String filepath = await saveFile(res.bodyBytes);
        debugPrint("파일 다운로드 성공!");
        return filepath;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("downloadFIle error : $e");
      return null;
    }
  }

  //app 데이터 공
  Future<String> saveFile(Uint8List data) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String filePath = '$appDocPath/video.mp4'; //이름은 임의로 일단 하나로 통일함.

    File file = File(filePath);
    await file.writeAsBytes(data);

    return filePath;
  }
}
