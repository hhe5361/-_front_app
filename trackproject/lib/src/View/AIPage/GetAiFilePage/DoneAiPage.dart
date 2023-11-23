import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trackproject/src/utilities/Font_const.dart';
import 'package:trackproject/src/utilities/HexColor.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';
import 'package:trackproject/src/utilities/mediasize.dart';
import 'package:video_player/video_player.dart';

class ShowAiFilePage extends StatelessWidget {
  ShowAiFilePage({super.key, required this.filepath});

  String filepath;

  //여기 고쳐야 한다.
  Widget content() {
    return Column(
      children: [
        Text(
          "File",
          style: fontDetails(13),
        ),
        Text(
          "제작일: 2023.11.23 23.15.0000",
          style: fontDetails(13),
        ),
      ],
    );
  }

  Widget circleBox(Widget asset) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(shape: BoxShape.circle, color: ColorGrey),
      child: ClipOval(child: asset),
    );
  }

  @override
  Widget build(BuildContext context) {
    //test용
    //filepath = "assets/ex.mp4";
    return Scaffold(
        appBar: myappbar2("완료된 영상", null, false),
        body: Padding(
          padding: EdgeInsets.only(top: mediaheight * 0.05),
          child: Column(
            children: [
              const Text(
                "영상 제작 완료",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: defaultDecobox(color: ColorGrey),
                child: VideoPlayerWidget(filepath: filepath),
              ),
              Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      circleBox(
                        const Icon(
                          Icons.download_for_offline,
                          size: 40,
                        ),
                      ),
                      circleBox(
                        SvgPicture.asset(
                          "assets/icon/instagram_icon.svg",
                        ),
                      ),
                      circleBox(SvgPicture.asset(
                        "assets/icon/kakaotalk_icon.svg",
                      )),
                    ]),
              ),
              //Expanded(child: Container()),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: content())
            ],
          ),
        ));
  }
}

//filepath 받아와서 보여줄 거임.
class VideoPlayerWidget extends StatefulWidget {
  final String filepath;

  VideoPlayerWidget({required this.filepath});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _excu = false;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.filepath));
    //_controller = VideoPlayerController.asset(widget.filepath);
    _initializeVideoPlayerFuture = _controller.initialize();
    //_controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: AspectRatio(
                  aspectRatio: 16 / 13, //_controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              );
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            }
          },
        ),
        const SizedBox(
          height: 10,
        ),
        CircleAvatar(
          backgroundColor: ColorLightGrey,
          child: IconButton(
            onPressed: () {
              setState(() {
                if (_excu == false) {
                  _controller.play();
                } else {
                  _controller.pause();
                }
                _excu = !_excu;
              });
            },
            icon: Icon(
              _excu == false ? Icons.play_arrow : Icons.pause,
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
