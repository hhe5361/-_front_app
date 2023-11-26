import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackproject/src/View/AIPage/GetAiFilePage/ShowAiFile.dart';
import 'package:trackproject/src/View/AIPage/GetAiFilePage/loadingPage.dart';
import 'package:trackproject/src/provider/AiFileProvider.dart';

class LoadingGetFilePage extends StatelessWidget {
  LoadingGetFilePage({super.key});

  late AiFileProvider _provider;
  bool _isinit = false;
  @override
  Widget build(BuildContext context) {
    if (_isinit == false) {
      _isinit = true;
      _provider = Provider.of<AiFileProvider>(context, listen: true);
      _provider.tempFileGet();
    }
    if (_provider.status == AiFileStatus.loading) {
      return LoadingPage();
    } else if (_provider.status == AiFileStatus.success) {
      debugPrint("file 경로 : ~~~~~~${_provider.downloadedFilePath!}");
      return ShowAiFilePage(filepath: _provider.downloadedFilePath!);
    } else {
      debugPrint("여기서 뻑남");
      return const Placeholder(
          //error page 하나 만들어야 할 듯..
          );
    }
  }
}
