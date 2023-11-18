import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:trackproject/src/models/Album.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';
import 'package:trackproject/src/utilities/mediasize.dart';
import 'package:trackproject/src/utilities/time_convert.dart';

class SelectLocalAudio extends StatefulWidget {
  const SelectLocalAudio({super.key});

  @override
  State<SelectLocalAudio> createState() => _SelectLocalAudioState();
}

class _SelectLocalAudioState extends State<SelectLocalAudio> {
  AssetPathEntity? _path;
  final List<FavAsset> _audios = [];
  int _currentpage = 0;
  int _count = 0;

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  Future<void> checkPermission() async {
    await getAlbum();
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      await getAlbum();
    } else {
      await PhotoManager.openSetting();
    }
  }

  Future<void> getAlbum() async {
    List<AssetPathEntity> path = await PhotoManager.getAssetPathList(
        type: RequestType.audio, onlyAll: true);
    _path = path[0];
    await getaudios();
  }

  Future<void> getaudios(
      //이런 거는 그대로 쓸 수 있을 것 같은데 코드 리팩토링 때 해보면 좋을 듯..
      ) async {
    final loadImages = await _path!.getAssetListPaged(
      page: _currentpage++,
      size: 60,
    );

    var formatloadimage =
        loadImages.map((e) => FavAsset(assetinfo: e, favo: false));
    setState(() {
      _audios.addAll(formatloadimage);
    });
  }

  Widget _localrecordbox(int index) => GestureDetector(
        onTap: () {
          if (_count == 1 && _audios[index].favo == false) {
          } else {
            setState(() {
              _count = _audios[index].favo ? 0 : 1;
              _audios[index].favo = !_audios[index].favo;
            });
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          height: mediaheight * 0.115,
          decoration: box1(color: Colors.grey.shade300),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Icon(_audios[index].favo
                  ? Icons.check_circle
                  : Icons.circle_outlined),
              const SizedBox(width: 20),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _audios[index].assetinfo.title.toString(),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(_audios[index].assetinfo.createDateTime.toString()),
                      Text(formatMilliseconds(
                          _audios[index].assetinfo.duration * 1000))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Widget _renderaddbutton() => FloatingActionButton(
      backgroundColor: _count == 0 ? Colors.grey : Colors.greenAccent,
      onPressed: () {},
      child: Text(
        "$_count/1",
        style: const TextStyle(color: Colors.black),
      ));

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scroll) {
          final scrollPixels =
              scroll.metrics.pixels / scroll.metrics.maxScrollExtent;
          if (scrollPixels > 0.9) getaudios();

          return false;
        },
        child: _path == null
            ? const Center(child: CircularProgressIndicator())
            : Expanded(
                child: Stack(
                  children: [
                    ListView.builder(
                      itemCount: _audios.length,
                      itemBuilder: (context, index) {
                        return _localrecordbox(index);
                      },
                    ),
                    Positioned(bottom: 15, right: 15, child: _renderaddbutton())
                  ],
                ),
              ));
  }
}
