import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:trackproject/src/View/AIPage/GridAsset.dart';
import 'package:trackproject/src/models/Album.dart';

class SelectLocalVideo extends StatefulWidget {
  const SelectLocalVideo({super.key});

  @override
  State<SelectLocalVideo> createState() => _SelectLocalVideoState();
}

class _SelectLocalVideoState extends State<SelectLocalVideo> {
  AssetPathEntity? _path;
  Album? _album;
  final List<FavAsset> _videos = [];
  int _currentpage = 0;

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  Future<void> checkPermission() async {
    await getAlbum(); //아 android 13+에서는 필요가 없다네...? ㅅㅂ
    var status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> getAlbum() async {
    List<AssetPathEntity> path = await PhotoManager.getAssetPathList(
        type: RequestType.video, onlyAll: true);
    _path = path[0];
    _album = Album(
      id: _path!.id,
      name: _path!.isAll ? '모든 동영상' : _path!.name,
    );
    await getvideos();
  }

  Future<void> getvideos(
      //이런 거는 그대로 쓸 수 있을 것 같은데 코드 리팩토링 때 해보면 좋을 듯..
      ) async {
    final loadImages = await _path!.getAssetListPaged(
      page: _currentpage++,
      size: 20,
    );
    var formatloadimage =
        loadImages.map((e) => FavAsset(assetinfo: e, favo: false));

    setState(() {
      _videos.addAll(formatloadimage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scroll) {
          final scrollPixels =
              scroll.metrics.pixels / scroll.metrics.maxScrollExtent;
          if (scrollPixels > 0.7) getvideos();

          return false;
        },
        child: _path == null
            ? const Center(child: CircularProgressIndicator())
            : GridAssets(assets: _videos));
  }
}
