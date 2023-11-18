import 'package:flutter/material.dart';
import 'package:trackproject/src/models/YoutubeLinkModel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeLinkProvider with ChangeNotifier {
  YoutubePlayerController? _controller;
  YoutubeLink? linkmodel;
  bool isset = false;

  void initcontroller(String videoid) {
    _controller = YoutubePlayerController(
      initialVideoId: videoid,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    );
    issetting(true);
  }

  void setlinkfromid(String url) {
    var id = YoutubePlayer.convertUrlToId(
          url,
        ) ??
        '';
    _controller!.load(id); //controller가 load하는 게 이상한 거면 어또카지?
    notifyListeners();
  }

  void issetting(bool v) {
    isset = v;
    notifyListeners();
  }

  void deactivatecontroller() {
    if (_controller != null) _controller!.pause();
  }

  void disposecontroller() {
    if (_controller != null) _controller!.dispose();
  }
}
