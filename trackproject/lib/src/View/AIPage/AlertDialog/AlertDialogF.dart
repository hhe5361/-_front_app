import 'package:flutter/material.dart';
import 'package:trackproject/src/utilities/Font_const.dart';
import 'package:trackproject/src/utilities/HexColor.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';
import 'package:trackproject/src/utilities/mediasize.dart';

abstract class AssetAlert {
  //각 자식 위젯에서 정의해야 하는 부분
  final String correctpath = '', incorrectpath = '';
  bool _ischecked = false;
  double size = mediaheight * 0.5;
  //abstract method
  Widget contents();
  Widget currentAsset(String path);

  Widget assetInsert(String path, Icon icon) {
    return Column(children: [
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        child: currentAsset(path),
      ),
      const SizedBox(height: 10),
      icon
    ]);
  }

  Widget explanation(String explanation) => Row(
        children: [
          const Icon(
            Icons.circle,
            size: 8.0,
          ),
          const SizedBox(
            width: 5.0,
          ),
          Expanded(
            child: Text(
              explanation,
              style: fontDetails(13),
            ),
          ),
        ],
      );
  void showAiAlertDailog(BuildContext context, void callback()) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          alignment: Alignment.center,
          child: AlertDialog(
            title: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: defaultDecobox(color: ColorGrey),
              child: const Text(
                '주의사항',
                textAlign: TextAlign.center,
              ),
            ),
            backgroundColor: Colors.grey.shade100,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            content: SizedBox(
              height: size,
              width: mediawidth * 0.7,
              child: ListView(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  correctpath != ''
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                              assetInsert(
                                  correctpath,
                                  const Icon(
                                    Icons.circle_outlined,
                                    color: Colors.blue,
                                  )),
                              assetInsert(
                                  incorrectpath,
                                  const Icon(
                                    Icons.not_interested_sharp,
                                    color: Colors.red,
                                  )),
                            ])
                      : Container(),
                  contents(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: _ischecked,
                        onChanged: (bool? value) {
                          _ischecked = value ?? false;
                          _ischecked = false;
                        },
                      ),
                      const Text(
                        '다시 보지 않기',
                        style: TextStyle(
                            fontFamily: 'BaseFont',
                            fontWeight: FontWeight.w200,
                            color: Colors.grey,
                            fontSize: 11),
                      )
                    ],
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    callback();
                  },
                  child: const Center(child: Text('확인')))
            ],
          ),
        );
      },
    );
  }
}

class ImageAlert extends AssetAlert {
  @override
  final String correctpath = 'assets/image/image_x.png';
  @override
  final String incorrectpath = 'assets/image/image_o.png';

  @override
  Widget contents() {
    return Column(
      children: [
        const SizedBox(
          height: 10.0,
        ),
        const Text(
          '좋은 예시 (*^▽^*)',
        ),
        Divider(),
        explanation('전신이 정확하게 나온 사진'),
        explanation('몸의 각도가 정면을 향하고 있는 사진'),
        explanation('화질이 좋은 사진'),
        const SizedBox(
          height: 20.0,
        ),
        const Text(
          '나쁜 예시 (┬﹏┬)',
        ),
        Divider(),
        explanation('몸의 일부가 가려진 사진'),
        explanation('몸의 각도가 측면이나 후면을 향하고 있는 사진'),
        explanation('얼굴이 명확하게 나오지 않은 사진'),
        const SizedBox(
          height: 25.0,
        ),
        Text(
          '업로드한 사진은, AI 커버 영상 생성 이후 서버에서 즉시 삭제됩니다!',
          style: fontCaution,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20.0,
        ),
      ],
    );
  }

  @override
  Widget currentAsset(String path) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(path),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class VideoAlert extends AssetAlert {
  @override
  final String correctpath = 'assets/image/video_o.jpg';
  @override
  final String incorrectpath = 'assets/image/video_x.jpg';
  @override
  Widget contents() {
    return Column(
      children: [
        SizedBox(
          height: 10.0,
        ),
        Text(
          '좋은 예시 (*^▽^*)',
        ),
        Divider(),
        explanation('노래가 음원인 영상'),
        explanation('한 명의 사람만 나온 영상'),
        explanation('전신이 모두 나온 영상'),
        SizedBox(
          height: 20.0,
        ),
        Text(
          '나쁜 예시 (┬﹏┬)',
        ),
        Divider(),
        explanation('환호성이나 다른 잡음이 들어간 영상'),
        explanation('여러 명의 사람이 나오는 영상'),
        explanation('19금 영상'),
        explanation('춤을 추지 않는 상태의 화면 전환이 자주 일어나는 영상'),
        const SizedBox(
          height: 25.0,
        ),
        Text(
          '업로드한 영상은, AI 커버 영상 생성 이후 서버에서 즉시 삭제됩니다!',
          style: fontCaution,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget currentAsset(String path) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(path),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class AudioAlert extends AssetAlert {
  @override
  double size = mediaheight * 0.3;
  @override
  Widget contents() {
    return Column(
      children: [
        const SizedBox(
          height: 20.0,
        ),
        const Text(
          '좋은 예시 (*^▽^*)',
        ),
        Divider(),
        explanation('잡음없이 목소리만 녹음된 음성'),
        explanation('10분 이상 녹음된 음성 '),
        explanation('다양한 높낮이가 녹음된 음성 '),
        const SizedBox(
          height: 20.0,
        ),
        const Text(
          '나쁜 예시 (┬﹏┬)',
        ),
        Divider(),
        explanation('주변의 소음이 많이 들리는 음성'),
        const SizedBox(
          height: 25.0,
        ),
        Text(
          '업로드한 음성은, AI 커버 영상 생성 이후 서버에서 즉시 삭제됩니다!',
          style: fontCaution,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }

  @override
  Widget currentAsset(String path) {
    return Container();
  }
}
