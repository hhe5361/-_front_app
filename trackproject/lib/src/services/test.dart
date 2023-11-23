// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import 'package:trackproject/src/utilities/api_endpoint.dart';

// void httpTest(String filepath) async {
//   var url = Uri.parse(baseuri + port_file + 'ai/temp');

//   try {
//     var req = http.MultipartRequest('POST', url);
//     req.files.add(await http.MultipartFile.fromPath('rec', filepath));

//     var res = await req.send();

//     if (res.statusCode == 200) {
//       debugPrint("성공이야 성공 나는 성공이야 우하하");
//     } else {
//       debugPrint("fuck이야 fuck!!");
//     }
//   } catch (e) {
//     debugPrint("----------------------------에러" + e.toString());
//   }
// }
