import 'package:trackproject/src/models/AiFIleModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:trackproject/src/services/AifileApi.dart';
import 'package:flutter/material.dart';

class AiFileProvider extends ChangeNotifier {
  late bool isloading = false;
  late AifileModel _aifile;
  final AiFileService service = AiFileService();

  Future<void> getfile() async {
    try {
      isloading = false;
      notifyListeners();
      _aifile = await service.getAiFile();
      isloading = true;
      notifyListeners();
    } catch (error) {
      throw error; //error 발생하면 받음.
    }
  }
}
