import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:trackproject/src/provider/SelectAssetProvider.dart';
import 'package:trackproject/src/utilities/HexColor.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';
import 'package:trackproject/src/utilities/mediasize.dart';
import 'package:trackproject/src/utilities/snackbar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeLinkPage extends StatefulWidget {
  @override
  _YoutubeLinkPageState createState() => _YoutubeLinkPageState();
}

class _YoutubeLinkPageState extends State<YoutubeLinkPage> {
  late TextEditingController _idController;
  YoutubePlayerController? _linkcontroller;
  bool _isinit = false;

  @override
  void initState() {
    _idController = TextEditingController();
    super.initState();
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    if (_linkcontroller != null) _linkcontroller!.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    if (_linkcontroller != null) _linkcontroller!.dispose();
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(children: [
          const Text("Youtube Link 입력"),
          _space,
          Container(
            //반응형으로 바꾸어야 할 부분
            height: mediaheight * 0.35,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.all(7),
            decoration: defaultDecobox(color: ColorGrey),
            child: Column(children: [
              Expanded(
                child: !_isinit
                    ? Container(
                        decoration: defaultDecobox(color: Colors.black45),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: YoutubePlayer(controller: _linkcontroller!)),
              ),
              _space,
              _rendertextbox(),
            ]),
          ),
          _space,
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [_loadButton(), _postbutton(context)]),
        ]),
      ),
    );
  }

  //최초 1회 실행
  void _setinitcontroller(String id) {
    setState(() {
      _linkcontroller = YoutubePlayerController(
        initialVideoId: id,
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
      _isinit = true;
    });
  }

  void _loadyoutube(String id) {
    setState(() {
      _linkcontroller!.load(id);
    });
  }

  Widget _rendertextbox() => TextField(
        style: const TextStyle(fontFamily: 'BaseFont', fontSize: 12),
        enableInteractiveSelection: true,
        controller: _idController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none),
          prefixIcon: const Icon(Icons.text_fields),
          hintText: 'URL',
          fillColor: Colors.white,
          filled: true,
          hintStyle: const TextStyle(fontWeight: FontWeight.w100, fontSize: 12),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => _idController.clear(),
          ),
        ),
      );

  Widget get _space => const SizedBox(height: 10);

  Widget _loadButton() {
    return ElevatedButton(
      style: mybuttonstyle(color: ColorGreenLight),
      onPressed: () {
        if (_idController.text.isNotEmpty) {
          var id = YoutubePlayer.convertUrlToId(
                _idController.text,
              ) ??
              '';
          if (id == '') {
            showSnackBar("잘못된 url입니다", context);
            return;
          }
          if (!_isinit) {
            _setinitcontroller(id);
          } else {
            _loadyoutube(id);
          }
          //FocusScope.of(context).requestFocus(FocusNode());
        }
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Text(
          "불러오기",
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _postbutton(BuildContext context) {
    return ElevatedButton(
      style: mybuttonstyle(
        color: _isinit ? ColorGreenLight : ColorGrey,
      ),
      onPressed: () {
        if (_isinit) {
          Provider.of<SelectAssetProvider>(context, listen: false).filesave(
              filepath: _idController.text,
              islink: true,
              type: AssetType.video);

          Navigator.pop(context);
          showSnackBar("file이 추가됐습니다", context);
        }
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Text(
          "선택하기",
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
