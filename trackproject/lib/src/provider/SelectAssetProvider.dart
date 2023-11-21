import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:trackproject/src/services/SelectAssetPostApi.dart';

enum AssetpostStatus { success, failed, loading, nothing }

class SelectAssetProvider extends ChangeNotifier {
  final SelectAssetPostApi _api = SelectAssetPostApi();

//post 하고나서 상황관찰 용 status도 필요할 듯하다 그냥 loading으로만 할 게 아닌 것 같다 ㅎ fail 이런거 상태 관리해야 함.

  String? _imagefile;
  String? _videofile;
  String? _recordfile;
  bool _selectyoutubelink = false;

  bool _selectedimage = false;
  bool _selectedvideo = false;
  bool _selectedrecord = false;

  AssetpostStatus _status = AssetpostStatus.nothing;

  get status => _status;
  bool ispost(AssetType type) {
    switch (type) {
      case AssetType.image:
        return _selectedimage;
      case AssetType.video:
        return _selectedvideo;
      case AssetType.audio:
        return _selectedrecord;
      default:
        return false;
    }
  }

  void setimagepost() {
    _selectedimage = true;
    notifyListeners();
  }

  void setvideopost() {
    _selectedvideo = true;
    notifyListeners();
  }

  void setrecordpost() {
    _selectedrecord = true;
    notifyListeners();
  }

  void convertstatus(AssetpostStatus status) {
    _status = status;
    notifyListeners();
  }

  void clear() {
    _selectedimage = false;
    _selectedvideo = false;
    _selectedrecord = false;
    _status = AssetpostStatus.nothing;
    notifyListeners();
  }

  void filesave(
      {required String filepath,
      required bool islink,
      required AssetType type}) {
    switch (type) {
      case AssetType.image:
        _imagefile = filepath;
        setimagepost();
        break;
      case AssetType.video:
        _videofile = filepath;
        _selectyoutubelink = islink;

        setvideopost();
        break;
      case AssetType.audio:
        _recordfile = filepath;
        setrecordpost();
        break;
      default:
    }
  }

//여기 response로 그거 와야 하는 거 아닌가 응답 와야 하는 거 아닌가? 근데 그러면 계속
  Future<void> postfilepath() async {
    convertstatus(AssetpostStatus.loading);
    bool? iscorrect = await _api.postfiles(
        imagefile: _imagefile!,
        recordfile: _recordfile!,
        videofile: _videofile!,
        islink: _selectyoutubelink);

    if (iscorrect == null) {
      convertstatus(AssetpostStatus.failed);
    } else if (iscorrect) {
      convertstatus(AssetpostStatus.success);
    } else {
      convertstatus(AssetpostStatus.failed);
    }
  }
}
