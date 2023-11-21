import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<File> _getFile(String fileName) async {
  // 앱의 디렉토리 경로를 가져옴
  final directory = await getApplicationDocumentsDirectory();
  // 파일 경로와 파일 이름을 합쳐서 전체 파일 경로를 만듬
  return File('${directory.path}/$fileName');
}

// 파일을 저장하는 함수
Future<void> saveToFile(String fileName, String content) async {
  // 파일 경로를 생성함
  final file = await _getFile(fileName);
  // 파일에 내용을 저장함
  await file.writeAsString(content);
}

//파일을 불러오는 함수
Future<String> _loadFile(String fileName) async {
  try {
    //파일을 불러옴
    final file = await _getFile(fileName);
    //불러온 파일의 데이터를 읽어옴
    String fileContents = await file.readAsString();
    return fileContents;
  } catch (e) {
    return '';
  }
}
