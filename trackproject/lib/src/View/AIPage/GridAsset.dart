import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:trackproject/src/models/Album.dart';
import 'package:trackproject/src/provider/SelectAssetProvider.dart';
import 'package:trackproject/src/utilities/snackbar.dart';

class GridAssets extends StatefulWidget {
  final List<FavAsset> assets;
  AssetType type;
  late AssetEntity? selectasset;

  GridAssets({
    required this.type,
    required this.assets,
    Key? key,
  }) : super(key: key);

  @override
  State<GridAssets> createState() => _GridAssetsState();
}

class _GridAssetsState extends State<GridAssets> {
  int _count = 0;

  Widget _renderimage(int index) {
    return GestureDetector(
      onTap: () {
        if (_count == 1 && widget.assets[index].favo == false) {
        } else {
          if (_count == 0) {
            //count 0 에서 추가될 때마다 .. ㅇㅇ
            widget.selectasset = widget.assets[index].assetinfo;
          }
          setState(() {
            _count = widget.assets[index].favo ? 0 : 1;
            widget.assets[index].favo = !widget.assets[index].favo;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Stack(children: [
          SizedBox(
            //color: Colors.grey,
            //padding: const EdgeInsets.all(3),
            width: double.infinity,
            height: double.infinity,
            child: AssetEntityImage(
              widget.assets[index].assetinfo,
              //isOriginal: false,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              top: 5,
              right: 5,
              child: Icon(!widget.assets[index].favo
                  ? Icons.circle_outlined
                  : Icons.check_circle)),
        ]),
      ),
    );
  }

  Widget _renderaddbutton() => FloatingActionButton(
      backgroundColor: _count == 0 ? Colors.grey : Colors.greenAccent,
      onPressed: () async {
        if (_count == 1 && widget.selectasset != null) {
          File? file = await widget.selectasset?.file;
          Provider.of<SelectAssetProvider>(context, listen: false)
              .filesave(filepath: file!.path, islink: false, type: widget.type);
          debugPrint("선택한 asset의 절대 경로 의미함" + file!.path.toString());
          Navigator.pop(context);
          showSnackBar("file이 선택됐습니다!", context);
        }
      },
      child: Text(
        "$_count/1",
        style: const TextStyle(color: Colors.black),
      ));

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: widget.assets.length,
        itemBuilder: (context, index) {
          return _renderimage(index);
        },
      ),
      Positioned(bottom: 15, right: 15, child: _renderaddbutton())
    ]);
  }
}
