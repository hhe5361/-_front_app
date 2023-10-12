import 'package:flutter/material.dart';
import 'package:trackproject/src/View/AIPage/ImageSelectPage.dart/ImageSelectPage.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';

class CreatePage extends StatelessWidget {
  CreatePage({super.key});

  late bool isback = false;
  final _routepage = [];

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
                  Navigator.of(context).pop();
                },
                child: const Text("Yes")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("No")),
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    );
  }

  Widget _renderselect(String label, bool isselected, BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("$label을 선택해주세요!"),
      const SizedBox(height: 5),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: isselected ? Colors.green : Colors.grey,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        height: 100,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return ImageSelectPage();
              },
            ));
          },
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            alignment: Alignment.center,
            child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Expanded(child: Icon(Icons.add))),
          ),
        ),
      ),
    ]);
  }

  Widget _renderbutton() {
    return ElevatedButton(
      onPressed: () {},
      style: mybuttonstyle(color: Colors.grey),
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
                      _renderselect("사진", false, context),
                      const SizedBox(height: 20),
                      _renderselect("동영상", true, context),
                      const SizedBox(height: 20),
                      _renderselect("음성", false, context),
                      Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              child: _renderbutton()))
                    ],
                  ),
                ),
              ))),
    );
  }
}
