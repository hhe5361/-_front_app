import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:trackproject/src/View/AIPage/ImageSelectPage.dart/SelectLocalImage.dart';
import 'package:trackproject/src/View/AIPage/RecordSelectPage/RecordSelectPage.dart';
import 'package:trackproject/src/View/AIPage/VideoSelectPage.dart/VideoSelectPage.dart';
import 'package:trackproject/src/provider/SelectAssetProvider.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';

class CreatePage extends StatelessWidget {
  CreatePage({super.key});

  late bool isback = false;
  final List<dynamic> pages = [
    const LocalImageSelectPage(),
    const SelectVideoPage(),
    const RecordSelectPage()
  ];
  final List<AssetType> assettype = [
    AssetType.image,
    AssetType.video,
    AssetType.audio
  ];

  List<String> label = ["사진", "동영상", "음성"];
  Future<void> _rendercaution(BuildContext ctx) {
    return showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          content: const Text("작업이 저장되지 않습니다.\n 종료하시겠습니까?",
              textAlign: TextAlign.center),
          actions: [
            TextButton(
                onPressed: () {
                  isback = true;
                  Provider.of<SelectAssetProvider>(context, listen: false)
                      .clear();
                  Navigator.of(context).pop();
                },
                child: const Text("Yes")),
            TextButton(onPressed: () {}, child: const Text("No")),
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    );
  }

  Widget _renderselect(int index, BuildContext context) {
    String thislabel = label[index];

    return Consumer<SelectAssetProvider>(
      builder: (context, value, child) {
        bool ispost = value.ispost(assettype[index]);

        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("$thislabel을 선택해주세요!"),
          const SizedBox(height: 5),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: ispost ? Colors.green : Colors.grey,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            height: 100,
            child: GestureDetector(
              onTap: () async {
                //permission check하고 가야 들어가야 하는 부분..
                // await Provider.of<ImageAlbumProvider>(context, listen: false)
                //     .checkPermission(); //이미 데이터가 다 들어가 있어야 하는 거 아님?
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return pages[index];
                  },
                ));
              },
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                alignment: Alignment.center,
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Icon(ispost ? Icons.check : Icons.add)),
              ),
            ),
          ),
        ]);
      },
    );
  }

  Widget _renderbutton(BuildContext context) {
    SelectAssetProvider provider =
        Provider.of<SelectAssetProvider>(context, listen: true);
    bool istrue = provider.ispost(AssetType.image) &&
        provider.ispost(AssetType.audio) &&
        provider.ispost(AssetType.video);

    return ElevatedButton(
      onPressed: () {
        if (istrue) {
          debugPrint("yeah 성공했습니다 여러분 드디어 황ㅇ효은이 !!! 축배를 들엉라 우호효훃효 ");
        }
      },
      style: mybuttonstyle(color: istrue ? Colors.greenAccent : Colors.grey),
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          "Create!",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _rendercaution(context);
        return isback;
      },
      child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () async {
                    await _rendercaution(context);
                    if (isback) {
                      Navigator.of(context).pop();
                    }
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.black,
                ),
                title: const Text(
                  "작업하기",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                elevation: 0.5,
                backgroundColor: Colors.white,
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _renderselect(0, context),
                      const SizedBox(height: 20),
                      _renderselect(1, context),
                      const SizedBox(height: 20),
                      _renderselect(2, context),
                      Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              child: _renderbutton(context)))
                    ],
                  ),
                ),
              ))),
    );
  }
}
