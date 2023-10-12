import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';

class Album {
  String id;
  String name;

  Album({
    required this.id,
    required this.name,
  });
}

class SampleScreen extends StatefulWidget {
  const SampleScreen({Key? key}) : super(key: key);

  @override
  State<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  List<AssetPathEntity>? _paths;
  List<Album> _albums = [];
  late List<AssetEntity> _images;
  int _currentPage = 0;
  late Album _currentAlbum;

  Future<void> checkPermission() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      await getAlbum();
    } else {
      await PhotoManager.openSetting();
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

    setState(() {
      if (albumChange) {
        _images = loadImages;
      } else {
        _images.addAll(loadImages);
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
            ? DropdownButton(
                value: _currentAlbum,
                items: _albums
                    .map((e) => DropdownMenuItem(
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text("사진 선택",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 0.5,
          backgroundColor: Colors.white,
          actions: [_dropalbums()],
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scroll) {
            final scrollPixels =
                scroll.metrics.pixels / scroll.metrics.maxScrollExtent;
            if (scrollPixels > 0.7) getPhotos(_currentAlbum);
            return false;
          },
          child: SafeArea(
            child: _paths == null
                ? const Center(child: CircularProgressIndicator())
                : GridPhoto(images: _images),
          ),
        ),
      ),
    );
  }
}

class GridPhoto extends StatefulWidget {
  List<AssetEntity> images;

  GridPhoto({
    required this.images,
    Key? key,
  }) : super(key: key);

  @override
  State<GridPhoto> createState() => _GridPhotoState();
}

//check도 가능하게 만들거임.
class _GridPhotoState extends State<GridPhoto> {
  //이거는 render만 하는 거임.
  bool ischecked = false;
  Widget _rendercheckbox(AssetEntity e) {
    return GestureDetector(
      onTap: () {
        setState(() {
          ischecked = true;
        });
      },
      child: Stack(alignment: Alignment.topRight, children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(6),
          child: AssetEntityImage(
            e,
            isOriginal: false,
            fit: BoxFit.fill,
          ),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
            child: ischecked
                ? const Icon(
                    Icons.circle,
                    color: Colors.white,
                  )
                : const Icon(Icons.check_circle_outline_outlined))
      ]),
    );
  }

  Widget _renderimage(AssetEntity e) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: AssetEntityImage(
        e,
        isOriginal: false,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomRight, children: [
      GridView(
        physics: const BouncingScrollPhysics(),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        children: widget.images.map((e) {
          return _rendercheckbox(e);
        }).toList(),
      ),
      ElevatedButton(
          onPressed: () {},
          child: Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
            child: Text("1/1"),
          ))
    ]);
  }
}
