import 'package:flutter/cupertino.dart';
import 'package:trackproject/src/services/AifileApi.dart';
import 'package:flutter/material.dart';

import 'dart:async';

enum AiFileStatus { loading, success, fail }

class AiFileProvider with ChangeNotifier {
  final AiFileService _aiFileService = AiFileService();
  String? _downloadedFilePath;
  AiFileStatus? _status;
  //file 가져와야 할 때 ㅇㅇ.
  String? get downloadedFilePath => _downloadedFilePath;
  AiFileStatus? get status => _status;

  void setstatus(AiFileStatus s) {
    _status = s;
    debugPrint("sattus 변한 거 알려주는 용도임, $s");
    notifyListeners();
  }

  Future<void> startChecking() async {
    setstatus(AiFileStatus.loading);

    Timer.periodic(const Duration(seconds: 15), (timer) async {
      if (_status != AiFileStatus.fail || _status != AiFileStatus.success) {
        debugPrint("request ?");
        await checkAndDownloadFile();
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> checkAndDownloadFile() async {
    try {
      String? checkResult = await _aiFileService.checkapi();

      if (checkResult == 'True') {
        String? filePath = await _aiFileService.getfile();

        if (filePath != null) {
          _downloadedFilePath = await _aiFileService.downloadFile(filePath);
          setstatus(AiFileStatus.success);
        } else {
          setstatus(AiFileStatus.fail);
        }
      } else if (checkResult == null) {
        setstatus(AiFileStatus.fail);
      }
    } catch (e) {
      debugPrint("checkAndDownloadFile error: $e");
      setstatus(AiFileStatus.fail);
    }
  }

  Future<void> tempFileGet() async {
    setstatus(AiFileStatus.loading);
    Future.delayed(const Duration(seconds: 15));

    String? filePath = await _aiFileService.testGetFile();

    if (filePath != null) {
      _downloadedFilePath = await _aiFileService.downloadFile(filePath);
      setstatus(AiFileStatus.success);
    } else {
      setstatus(AiFileStatus.fail);
    }
  }
}
