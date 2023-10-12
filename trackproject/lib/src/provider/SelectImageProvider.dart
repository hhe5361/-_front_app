// import 'package:flutter/cupertino.dart';
// import 'package:trackproject/src/services/selectApi.dart';
// import 'package:dio/dio.dart';

// class SelectData extends ChangeNotifier {
//   ApiService apiservice = ApiService();

//   int imageid = 0;
//   int videoid = 0;
//   int recordid = 0;

//   bool imagedata = false;
//   bool videodata = false;
//   bool recorddata = false;

//   Future<void> saveImage(int id) async {
//     try {
//       await apiservice.postdata(
//           path: 'image/saveImage', content: {"photoId": id}, options: Option);
//     } catch (error) {
//       throw Exception('Failed to save image: $error');
//     }
//   }

//   Future<void> savevideo(int id) async {
//     try {
//       await _dio.post('api/image/saveImage', data: {'photoId': photoId});
//     } catch (error) {
//       throw Exception('Failed to save image: $error');
//     }
//   }

//   Future<void> saveyoutubelink(int id) async {
//     try {
//       await _dio.post('api/image/saveImage', data: {'photoId': photoId});
//     } catch (error) {
//       throw Exception('Failed to save image: $error');
//     }
//   }
// }
