import 'dart:async';
import 'dart:io';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:trackproject/src/provider/SelectAssetProvider.dart';
import 'package:trackproject/src/utilities/mediasize.dart';
import 'package:trackproject/src/utilities/snackbar.dart';

typedef _Fn = void Function();

const theSource = AudioSource.microphone;

class LiveRecordPage extends StatefulWidget {
  const LiveRecordPage({Key? key}) : super(key: key);

  @override
  _LiveRecordPageState createState() => _LiveRecordPageState();
}

class _LiveRecordPageState extends State<LiveRecordPage> {
  Codec _codec = Codec.aacMP4;
  String _temppath = 'flutter_tempfile.mp4';
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  bool _havefile = false;
  Duration _recordedTime = Duration();

  @override
  void initState() {
    _mPlayer!.openPlayer().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });

    openTheRecorder().then((value) {
      setState(() {
        _mRecorderIsInited = true;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _mPlayer!.closePlayer();
    _mPlayer = null;

    _mRecorder!.closeRecorder();
    _mRecorder = null;
    super.dispose();
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder!.openRecorder();
    if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
      _codec = Codec.opusWebM;
      _temppath = 'tau_file.webm';
      if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
        _mRecorderIsInited = true;
        return;
      }
    }
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));

    _mRecorderIsInited = true;
  }

  void record() {
    _mRecorder!
        .startRecorder(
      toFile: _temppath,
      codec: _codec,
      audioSource: theSource,
    )
        .then((value) {
      setState(() {});
    });
    // if (tempFile.existsSync()) {
  }

  void stopRecorder() async {
    await _mRecorder!.stopRecorder().then((value) {
      setState(() {
        _mplaybackReady = true;
        _havefile = true;
      });
    });
  }

  void play() {
    assert(_mPlayerIsInited &&
        _mplaybackReady &&
        _mRecorder!.isStopped &&
        _mPlayer!.isStopped);
    _mPlayer!
        .startPlayer(
            fromURI: _temppath,
            whenFinished: () {
              setState(() {});
            })
        .then((value) {
      setState(() {});
    });
  }

  void stopPlayer() {
    _mPlayer!.stopPlayer().then((value) {
      setState(() {});
    });
  }

  _Fn? getRecorderFn() {
    if (!_mRecorderIsInited || !_mPlayer!.isStopped) {
      return null;
    }
    return _mRecorder!.isStopped ? record : stopRecorder;
  }

  _Fn? getPlaybackFn() {
    if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder!.isStopped) {
      return null;
    }
    return _mPlayer!.isStopped ? play : stopPlayer;
  }

  Future<String?> savefile() async {
    Directory? appDocDir = await getApplicationDocumentsDirectory();
    String saveDirectory = appDocDir.path;

    String? fileName = await _showFileNameInputDialog();
    debugPrint("appDoc: " + saveDirectory + fileName!);

    if (fileName != null && fileName.isNotEmpty) {
      String customSavePath = '$saveDirectory/$fileName.mp4';

      Directory customSaveDir = Directory(saveDirectory);
      if (!customSaveDir.existsSync()) {
        customSaveDir.createSync(recursive: true);
      }
      //_temppath에 있는 거 긁어서 저장하는 코드
      File tempFile = File(
          "/data/user/0/com.example.trackproject/cache/flutter_tempfile.mp4");
      if (tempFile.existsSync()) {
        File? savefile = await tempFile.copy(customSavePath);
        debugPrint("debug!!!!" + savefile.path + "origin:" + customSavePath);
        showSnackBar("녹음 파일이 저장됐습니다 : $customSavePath", context);

        return savefile.path;
      } else {
        print('복사할 파일이 존재하지 않습니다.');
      }
    } else {
      showSnackBar("파일명을 다시 입력해주세요.", context);
    }
  }

  Future<String?> _showFileNameInputDialog() async {
    String? filename;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('파일 이름 입력'),
          content: TextField(
            onChanged: (value) {
              filename = value;
            },
            decoration: const InputDecoration(labelText: '파일 이름'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, filename);
              },
              child: const Text('저장'),
            ),
          ],
        );
      },
    );
    return filename;
  }

  Widget recordbody() {
    Widget circlebox(IconButton childitem) => Container(
          padding: const EdgeInsets.all(3),
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: childitem,
        );

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
          height: 190,
          color: Colors.white,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              circlebox(
                IconButton(
                    onPressed: getPlaybackFn(),
                    icon: _mPlayer!.isPlaying
                        ? const Icon(
                            Icons.pause,
                            color: Colors.black,
                          )
                        : const Icon(Icons.play_arrow)),
              ),
              SizedBox(
                width: mediawidth * 0.2,
              ),
              circlebox(
                IconButton(
                  onPressed: getRecorderFn(),
                  icon: _mRecorder!.isRecording
                      ? const Icon(Icons.pause)
                      : const Icon(
                          Icons.circle,
                          color: Colors.red,
                        ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Container(
            height: 300,
            color: Colors.grey,
            child: recordbody(),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "주의 사항",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25),
          ),
          const Text(
            "최소 30분 이상 녹음 부탁드립니다\n녹음 버튼을 다시 누르시면 처음부터 녹음됩니다",
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          FilledButton(
            style: ButtonStyle(
                backgroundColor: !_havefile
                    ? MaterialStateProperty.all(Colors.grey)
                    : MaterialStateProperty.all(Color(0xFF69F0AE))),
            onPressed: () async {
              if (_havefile) {
                String? filename = await savefile();
                //예외 처리 해야 하는데 아 ~~~~~~~~~
                Provider.of<SelectAssetProvider>(context, listen: false)
                    .filesave(
                        filepath: filename!,
                        islink: false,
                        type: AssetType.audio);
                showSnackBar("file이 선택됐습니다" + filename, context);
                Navigator.pop(context);
              }
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "선택하기",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
