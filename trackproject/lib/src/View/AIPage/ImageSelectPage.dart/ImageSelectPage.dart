import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:trackproject/src/models/Album.dart';
import 'package:trackproject/src/provider/AlbumData.dart';

class ShowImage extends StatefulWidget {
  const ShowImage({super.key});

  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  late ImageAlbumProvider _imageAlbumProvider;

  Widget _dropalbums() {
    return Container(
        child: _imageAlbumProvider.allabum != null
            ? DropdownButton<Album>(
                value: _imageAlbumProvider.currentalbum,
                items: _imageAlbumProvider.allabum!
                    .map((e) => DropdownMenuItem<Album>(
                          value: e,
                          child: Text(e.name),
                        ))
                    .toList(),
                onChanged: (Album? value) =>
                    _imageAlbumProvider.changealbum(value!),
              )
            : null);
  }

  @override
  Widget build(BuildContext context) {
    _imageAlbumProvider = Provider.of<ImageAlbumProvider>(context);
    _imageAlbumProvider.checkPermission();
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              title: const Text("사진 선택",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              centerTitle: true,
              elevation: 0.5,
              backgroundColor: Colors.white,
              actions: [_dropalbums()],
            ),
            body: _imageAlbumProvider.allabum != null
                ? GridPhoto(
                    images: _imageAlbumProvider.images,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  )));
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
