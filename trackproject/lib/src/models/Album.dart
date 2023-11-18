import 'package:photo_manager/photo_manager.dart';

class Album {
  String id;
  String name;

  Album({
    required this.id,
    required this.name,
  });
}

//assetentity 뜯뜯 -> 다 적용해야 하는데 코드 리팩토링 때 고려해보겠음.
class FavAsset {
  AssetEntity assetinfo;
  bool favo;

  FavAsset({required this.assetinfo, required this.favo});
}
