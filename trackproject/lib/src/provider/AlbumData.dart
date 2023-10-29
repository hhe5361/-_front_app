import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:trackproject/src/models/Album.dart';
import 'package:trackproject/src/services/albumApi.dart';

class ImageAlbumProvider with ChangeNotifier {
  final _albumapi = AlbumService();
  List<Album>? _albums; //앨범 목록
  int? _currentpage;
  Album? _currentalbum;
  List<AssetEntity> _images = [];

  List<Album>? get allabum => _albums;
  get currentalbum => _currentalbum;
  get images => _images;

  Future<void> getAlbum() async {
    List<AssetPathEntity>? paths = await _albumapi.getAlbum();

    _albums = paths
        .map((e) => Album(id: e.id, path: e, name: e.isAll ? '모든 사진' : e.name))
        .toList();

    _currentalbum = _albums![0];
  }

  Future<void> changealbum(Album album) async {
    _currentalbum = album;
    _currentpage = 0;
    _images.clear();

    await getimages();
  }

  Future getimages() async {
    _images += await _albumapi.getPhotos(_currentalbum!.path,
        currentpage: _currentpage!);
    notifyListeners();
  }

  Future<void> scrollon() async {
    _currentpage = _currentpage! + 1;
    await getimages();
  }

  Future<void> checkPermission() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      await getAlbum();
      await getimages();
    } else {
      await PhotoManager.openSetting();
    }
  }
}
