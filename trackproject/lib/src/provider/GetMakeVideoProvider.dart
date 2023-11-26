import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trackproject/src/services/AifileApi.dart';

class MyFileDetailProvider extends ChangeNotifier {
  List<File> _files = [];
  List<dynamic> _date = [];
  List<String> _filename = [];
  bool _isdone = false;

  get length => _files.length;
  get date => _date;
  get name => _filename;
  get status => _isdone;
  get file => _files;
  void changestatus(bool v) {
    _isdone = v;
    notifyListeners();
  }

  Future<void> getAllFiles() async {
    //changestatus(false);
    Directory mydirec = await getApplicationDocumentsDirectory();
    mydirec = Directory("${mydirec.path}/$subfolderName");
    if (await mydirec.exists()) {
      List<FileSystemEntity> recentvideo = mydirec.listSync();
      _files = recentvideo.whereType<File>().toList();

      getData();
      notifyListeners();
    }
    return;
  }

  Future<void> getData() async {
    debugPrint(_files[0].path + "\n두번째 :: ${_files[1].path}");
    _date.clear(); // 기존 데이터를 초기화
    _filename.clear(); // 기존 데이터를 초기화

    for (File file in _files) {
      FileStat fileStat = file.statSync();
      _date.add(fileStat.changed);
      _filename.add(file.uri.pathSegments.last);
      debugPrint(">>>>>>>check plz $_date[1] , $_filename[1]");
    }
  }
}
