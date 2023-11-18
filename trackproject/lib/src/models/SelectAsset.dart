import 'package:photo_manager/photo_manager.dart';

class SelectAsset {
  AssetEntity selectimage;
  AssetEntity selectvideo;
  AssetEntity selectaudio;

  SelectAsset(
      {required this.selectimage,
      required this.selectvideo,
      required this.selectaudio});
  //to json 작성 예정
}
