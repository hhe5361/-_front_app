import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:trackproject/src/View/AIPage/AlertDialog/AlertDialogF.dart';
import 'package:trackproject/src/View/AIPage/GetAiFilePage/GetFile.dart';
import 'package:trackproject/src/View/AIPage/ImageSelectPage/SelectLocalImage.dart';
import 'package:trackproject/src/View/AIPage/RecordSelectPage/RecordSelectPage.dart';
import 'package:trackproject/src/View/AIPage/VideoSelectPage.dart/VideoSelectPage.dart';
import 'package:trackproject/src/provider/SelectAssetProvider.dart';
import 'package:trackproject/src/utilities/Font_const.dart';
import 'package:trackproject/src/utilities/HexColor.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';
import 'package:trackproject/src/utilities/mediasize.dart';

class CreatePage extends StatelessWidget {
  CreatePage({super.key});

  late bool isback = false;
  final List<dynamic> pages = [
    LocalImageSelectPage(isjustshow: false),
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
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No")),
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
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: ispost ? ColorGreenLight : ColorGrey,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            height: 100,
            child: GestureDetector(
              onTap: () async {
                //permission check하고 가야 들어가야 하는 부분..
                // await Provider.of<ImageAlbumProvider>(context, listen: false)
                //     .checkPermission(); //이미 데이터가 다 들어가 있어야 하는 거 아님?
                var callbackf = () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return pages[index];
                    },
                  ));
                };
                switch (assettype[index]) {
                  case AssetType.image:
                    ImageAlert().showAiAlertDailog(context, callbackf);
                    break;
                  case AssetType.video:
                    VideoAlert().showAiAlertDailog(context, callbackf);
                    break;
                  case AssetType.audio:
                    AudioAlert().showAiAlertDailog(context, callbackf);
                    break;
                  default:
                }
              },
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                alignment: Alignment.center,
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Icon(
                      ispost ? Icons.check : Icons.add,
                      size: 40,
                      color: Colors.black45,
                    )),
              ),
            ),
          ),
        ]);
      },
    );
  }

  Widget _renderbutton(BuildContext context) {
    SelectAssetProvider _provider =
        Provider.of<SelectAssetProvider>(context, listen: true);

    bool istrue = _provider.ispost(AssetType.image) &&
        _provider.ispost(AssetType.audio) &&
        _provider.ispost(AssetType.video);

    return ElevatedButton(
      onPressed: () async {
        if (istrue) {
          _provider.postfilepath();
          showprogress(context);

          // if (_provider.status == AssetpostStatus.success) {
          //   Navigator.pushReplacement(context, MaterialPageRoute(
          //     builder: (context) {
          //       Navigator.pop(context);
          //       return LoadingGetFilePage();
          //     },
          //   ));
          // } else {
          //   showprogress(context, _provider.status);
          // }
          // if (provider.status == AssetpostStatus.success) {
          //   Navigator.pushReplacement(context, MaterialPageRoute(
          //     builder: (context) {
          //       return LoadingGetFilePage();
          //     },
          //   ));
          // } else {}
        }
      },
      style: mybuttonstyle(color: istrue ? const Color(0xff60FDBB) : ColorGrey),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: mediawidth * 0.2, vertical: 10),
        child: const Text(
          "Create!",
          style: TextStyle(color: Colors.black54, fontSize: 18),
        ),
      ),
    );
  }

  Future<dynamic> showprogress(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Consumer<SelectAssetProvider>(
          builder: (context, userProvider, child) {
            if (userProvider.status == AssetpostStatus.loading) {
              return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator());
            } else if (userProvider.status == AssetpostStatus.success) {
              return AlertDialog(
                content: Column(children: [
                  const SizedBox(height: 10),
                  const Text("upload Success!"),
                  const SizedBox(height: 10),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return LoadingGetFilePage();
                          },
                        ));
                      },
                      child: const Text("확인"))
                ]), //다음페이지로바바로 가도 될 것 같고..응..
              );
            } else {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    const Text("upload failed!"),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("확인"),
                    ),
                  ],
                ),
              );
              // 로그인 실패 시 AlertDialog 표시하는 코드 추가
            }
          },
        );
      },
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
                title: const Text("작업하기", style: fontTitle),
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
