import 'package:photo_manager/photo_manager.dart';

class AlbumService {
  AlbumService({required this.requesttype});
  final RequestType requesttype;

  Future<List<AssetPathEntity>> getAlbum() async {
    return await PhotoManager.getAssetPathList(type: requesttype);
  }

  //get photos from AssetPathEntity, and return photos < data type is AssetPathEntity
  Future<List<AssetEntity>> getassets(
    AssetPathEntity path, {
    int currentpage = 0,
  }) async {
    final loadassets = await path.getAssetListPaged(
      page: currentpage,
      size: await path.assetCountAsync,
    );
    return loadassets;
  }
}
