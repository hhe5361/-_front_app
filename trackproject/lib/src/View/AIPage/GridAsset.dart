import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:trackproject/src/models/Album.dart';
import 'package:trackproject/src/utilities/snackbar.dart';

class GridAssets extends StatefulWidget {
  List<FavAsset> assets;

  GridAssets({
    required this.assets,
    Key? key,
  }) : super(key: key);

  @override
  State<GridAssets> createState() => _GridAssetsState();
}

//여기에다가 image picker 추가해야 한다.
class _GridAssetsState extends State<GridAssets> {
  int _count = 0;

  Widget _renderimage(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_count == 1 && widget.assets[index].favo == false) {
          } else {
            setState(() {
              _count = widget.assets[index].favo ? 0 : 1;
              widget.assets[index].favo = !widget.assets[index].favo;
            });
          }
        });
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
      onPressed: () {},
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
