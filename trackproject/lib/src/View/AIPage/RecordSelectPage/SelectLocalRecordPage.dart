import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:trackproject/src/models/Album.dart';
import 'package:trackproject/src/provider/SelectAssetProvider.dart';
import 'package:trackproject/src/utilities/Font_const.dart';
import 'package:trackproject/src/utilities/HexColor.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';
import 'package:trackproject/src/utilities/mediasize.dart';
import 'package:trackproject/src/utilities/snackbar.dart';
import 'package:trackproject/src/utilities/time_convert.dart';

class SelectLocalAudio extends StatefulWidget {
  const SelectLocalAudio({super.key});

  @override
  State<SelectLocalAudio> createState() => _SelectLocalAudioState();
}

class _SelectLocalAudioState extends State<SelectLocalAudio> {
  AssetPathEntity? _path;
  final List<FavAsset> _audios = [];
  AssetEntity? _selectaudio;
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
            if (_count == 0) {
              _selectaudio = _audios[index].assetinfo;
            }
            setState(() {
              _count = _audios[index].favo ? 0 : 1;
              _audios[index].favo = !_audios[index].favo;
            });
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          height: mediaheight * 0.115,
          decoration: defaultDecobox(color: Colors.grey.shade200),
          child: Row(
            children: [
              const SizedBox(width: 20),
              _audios[index].favo
                  ? const Icon(
                      Icons.check_circle,
                    )
                  : const Icon(
                      Icons.circle_outlined,
                      color: Colors.black26,
                    ),
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
                      const Divider(),
                      Text(
                        "녹음 날짜 : " +
                            _audios[index].assetinfo.createDateTime.toString(),
                        style: fontDetails(8),
                      ),
                      Text(
                        "녹음 시간 :" +
                            formatMilliseconds(
                                _audios[index].assetinfo.duration * 1000),
                        style: fontDetails(8),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Widget _renderaddbutton() => FloatingActionButton(
      elevation: 30,
      backgroundColor: _count == 0 ? ColorGrey : ColorGreenLight,
      onPressed: () async {
        File? file = await _selectaudio?.file;
        Provider.of<SelectAssetProvider>(context, listen: false).filesave(
            filepath: file!.path, islink: false, type: AssetType.audio);
        debugPrint("선택한 asset의 절대 경로 의미함" + file!.path.toString());
        showSnackBar("file이 선택됐습니다!", context);
        Navigator.pop(context);
      },
      child: Text(
        "$_count/1",
        style: const TextStyle(color: Colors.black26),
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
