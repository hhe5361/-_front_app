import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:trackproject/src/View/AIPage/GridAsset.dart';
import 'package:trackproject/src/models/Album.dart';
import 'package:trackproject/src/utilities/permission_handler.dart';

class SelectLocalVideo extends StatefulWidget {
  const SelectLocalVideo({super.key});

  @override
  State<SelectLocalVideo> createState() => _SelectLocalVideoState();
}

class _SelectLocalVideoState extends State<SelectLocalVideo> {
  AssetPathEntity? _path;
  final List<FavAsset> _videos = [];
  int _currentpage = 0;

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  //permission 부분 고칠 거임.. ㅇㅇ
  Future<void> checkPermission() async {
    var status = await Permission.photos.request();
    debugPrint(status.toString());
    await getAlbum();
    // var status = await Permission.manageExternalStorage.request();
    // if (status.isGranted) {
    // } else if (status.isPermanentlyDenied) {
    //   openAppSettings();
    // }
  }

  Future<void> getAlbum() async {
    List<AssetPathEntity> path = await PhotoManager.getAssetPathList(
        type: RequestType.video, hasAll: true, onlyAll: true);
    debugPrint("this it the path!" + _path.toString());

    _path = path[0];
    await getvideos();
  }

  Future<void> getvideos() async {
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
            : GridAssets(
                assets: _videos,
                type: AssetType.video,
              ));
  }
}
