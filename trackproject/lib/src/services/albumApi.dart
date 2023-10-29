import 'package:photo_manager/photo_manager.dart';

//album data get post하는 거
class AlbumService {
  //get all the albums. and return album list
  Future<List<AssetPathEntity>> getAlbum() async {
    return await PhotoManager.getAssetPathList(
      type: RequestType.image,
    );
  }

  //get photos from AssetPathEntity, and return photos < data type is AssetPathEntity
  Future<List<AssetEntity>> getPhotos(
    AssetPathEntity path, {
    int currentpage = 0,
  }) async {
    final loadimgaes = await path.getAssetListPaged(
      page: currentpage,
      size: 20,
    );
    return loadimgaes;
  }
}
