import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:trackproject/src/View/AIPage/GridAsset.dart';
import 'package:trackproject/src/models/Album.dart';

class SampleScreen extends StatefulWidget {
  const SampleScreen({Key? key}) : super(key: key);

  @override
  State<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  List<AssetPathEntity>? _paths;
  List<Album> _albums = [];
  late List<FavAsset> _images;
  int _currentPage = 0;
  late Album _currentAlbum;

  Future<void> checkPermission() async {
    await getAlbum(); //아 android 13+에서는 필요가 없다네...? ㅅㅂ
    var status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> getAlbum() async {
    _paths = await PhotoManager.getAssetPathList(
      type: RequestType.image,
    );

    _albums = _paths!.map((e) {
      return Album(
        id: e.id,
        name: e.isAll ? '모든 사진' : e.name,
      );
    }).toList();

    await getPhotos(_albums[0], albumChange: true);
  }

  Future<void> getPhotos(
    Album album, {
    bool albumChange = false,
  }) async {
    _currentAlbum = album;
    albumChange ? _currentPage = 0 : _currentPage++;

    final loadImages = await _paths!
        .singleWhere((element) => element.id == album.id)
        .getAssetListPaged(
          page: _currentPage,
          size: 20,
        );
    var formatloadimage =
        loadImages.map((e) => FavAsset(assetinfo: e, favo: false));

    setState(() {
      if (albumChange) {
        _images = formatloadimage.toList();
      } else {
        _images.addAll(formatloadimage);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  Widget _dropalbums() {
    return Container(
        child: _albums.isNotEmpty
            ? DropdownButton<Album>(
                value: _currentAlbum,
                items: _albums
                    .map((e) => DropdownMenuItem<Album>(
                          value: e,
                          child: Text(e.name),
                        ))
                    .toList(),
                onChanged: (value) => getPhotos(value!, albumChange: true),
              )
            : const SizedBox());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("사진 선택",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.white,
        actions: [_dropalbums()],
      ),
      //floatingActionButton: _renderaddbutton(),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scroll) {
          final scrollPixels =
              scroll.metrics.pixels / scroll.metrics.maxScrollExtent;
          if (scrollPixels > 0.9) getPhotos(_currentAlbum);

          return false;
        },
        child: SafeArea(
          child: _paths == null
              ? const Center(child: CircularProgressIndicator())
              : GridAssets(assets: _images),
        ),
      ),
    );
  }
}
