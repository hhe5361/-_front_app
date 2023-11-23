import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trackproject/main.dart';
import 'package:trackproject/src/View/AIPage/ImageSelectPage/SelectLocalImage.dart';
import 'package:trackproject/src/utilities/Font_const.dart';
//Camera Provider로 분리는 해놨는데 조금 엉켜서 일단 여기에 다 정의해놓겠음.

class MainCameraPage extends StatefulWidget {
  MainCameraPage();

  @override
  State<MainCameraPage> createState() => _MainCameraPageState();
}

class _MainCameraPageState extends State<MainCameraPage> {
  CameraController? controller;
  bool isCapturing = false;
  bool _isrecording = false;
  //For switching Camera
  int _selectedCameraIndex = 0;
  bool _isFrontCamera = false;
  //For Flash
  bool _init = false;
  File? _capturedImage;
  String _temppath = '';

  List<bool> _togglebutton = [false, true];
  bool _isphoto = true; //AssetType으로 바꿀거임.
  bool _showYouAreBestGood = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = null;
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _init = true;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller!.dispose();
    super.dispose();
  }

  void _switchCamera() async {
    if (controller != null) {
      // Dispose the current controller to release the camera resource
      await controller!.dispose();
    }
    // Increment or reset the selected camera index
    _selectedCameraIndex = (_selectedCameraIndex + 1) % cameras.length;
    // Initialize the new camera
    _initCamera(_selectedCameraIndex);
  }

  Future<void> _initCamera(int cameraIndex) async {
    controller = CameraController(cameras[cameraIndex], ResolutionPreset.max);

    try {
      await controller!.initialize();
      setState(() {
        if (cameraIndex == 0) {
          _isFrontCamera = false;
        } else {
          _isFrontCamera = true;
        }
      });
    } catch (e) {
      print("Error message: ${e}");
    }

    if (mounted && controller!.value.isInitialized) {
      setState(() {});
    }
  }

  //image take and capture
  void capturePhoto() async {
    if (!controller!.value.isInitialized) {
      return;
    }

    final Directory appDir = await getApplicationSupportDirectory();
    final String capturePath = join(appDir.path, '${DateTime.now()}.jpg');

    if (controller!.value.isTakingPicture) {
      return;
    }

    try {
      setState(() {
        isCapturing = true;
        _showYouAreBestGoodImage();
      });

      final XFile capturedImage = await controller!.takePicture();
      String imagePath = capturedImage.path;
      await GallerySaver.saveImage(imagePath);
      print("Photo captured and saved to the gallery");

      //For showing Image
      final String filePath =
          '$capturePath/${DateTime.now().millisecondsSinceEpoch}.jpg';

      _capturedImage = File(capturedImage.path);
      _capturedImage!.renameSync(filePath);
    } catch (e) {
      print("Error capturing photo: $e");
    } finally {
      setState(() {
        isCapturing = false;
      });
    }
  }

  void _toggleRecording() {
    if (_isrecording) {
      _stopVideoRecording();
    } else {
      _startVideoRecording();
    }
  }

  void _startVideoRecording() async {
    if (!controller!.value.isRecordingVideo) {
      final directory = await getTemporaryDirectory();
      final path =
          '${directory.path}./video_${DateTime.now().millisecondsSinceEpoch}.mp4';

      try {
        await controller!.initialize();

        await controller!.startVideoRecording();
        setState(() {
          _isrecording = true;
          _temppath = path;
        });
      } catch (e) {
        print(e);
        return;
      }
    }
  }

  void _stopVideoRecording() async {
    if (!_isrecording) return;
    if (controller!.value.isRecordingVideo) {
      try {
        final XFile videoFile = await controller!.stopVideoRecording();
        setState(() {
          _isrecording = false;
        });

        if (_temppath.isNotEmpty) {
          final File file = File(videoFile.path);
          await file.copy(_temppath);
          await GallerySaver.saveVideo(_temppath);
        }
      } catch (e) {
        print(e);
        return;
      }
    }
  }

  Widget _renderclickbutton() {
    return GestureDetector(
      onTap: () {
        if (_isphoto) {
          capturePhoto();
        } else {
          _toggleRecording();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        width: 55,
        height: 55,
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient:
                LinearGradient(colors: [Colors.greenAccent, Colors.white])),
        child: Container(
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: _isphoto
              ? null
              : Icon(
                  color: Colors.red,
                  !_isrecording ? Icons.circle : Icons.rectangle_rounded),
        ),
      ),
    );
  }

  Widget _rendergallery(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return LocalImageSelectPage(
                isjustshow: true,
              );
            },
          ));
        },
        child: Container(
          width: 55,
          height: 55,
          color: Colors.grey.shade300,
          child: _capturedImage == null
              ? null
              : Image.file(
                  _capturedImage!,
                  fit: BoxFit.cover,
                ),
        ));
  }

  Widget _renderSwitchIcon() {
    return GestureDetector(
      onTap: () {
        _switchCamera();
      },
      child: const Icon(
        Icons.flip_camera_ios_outlined,
        color: Colors.grey,
        size: 37,
      ),
    );
  }

  Widget _toggleButton() {
    return ToggleButtons(
      isSelected: _togglebutton,
      onPressed: (index) {
        setState(() {
          _togglebutton[index] = true;

          if (index == 1) {
            _togglebutton[0] = false;
            _stopVideoRecording(); //찍고 있던 record 멈추고
            _isphoto = true;
          } else {
            //video부분
            _togglebutton[1] = false;
            _isphoto = false;
          }
        });
      },
      renderBorder: true,
      borderRadius: BorderRadius.circular(15),
      children: [
        Text(
          "Video",
          style: fontDetails(8),
        ),
        Text(
          "Photo",
          style: fontDetails(8),
        )
      ],
    );
  }

  void _showYouAreBestGoodImage() {
    setState(() {
      _showYouAreBestGood = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showYouAreBestGood = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || _init == false) {
      //permission handler도 해줘야 한다.
      return const Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircularProgressIndicator(),
          //Text("not connected")
        ],
      ));
    } else {
      double mediah = MediaQuery.of(context).size.height;
      return Column(
        children: [
          Container(
              height: mediah * 0.66,
              width: double.infinity,
              color: Colors.grey,
              child: Stack(children: [
                SizedBox(
                  height: mediah * 0.66,
                  width: double.infinity,
                  child: CameraPreview(
                    controller!,
                  ),
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    child: AnimatedOpacity(
                      opacity: _showYouAreBestGood ? 1.0 : 0.0,
                      duration: const Duration(seconds: 1),
                      child: SizedBox(
                        height: mediah * 0.3,
                        child: Image.asset(
                          'assets/image/youarebestgood.png',
                        ),
                      ),
                    ))
              ])),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(flex: 2, child: _toggleButton()),
              Expanded(
                flex: 7,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Expanded(child: _rendergallery(context)),
                  Expanded(child: _renderclickbutton()),
                  Expanded(child: _renderSwitchIcon())
                ]),
              ),
            ]),
          ))
        ],
      );
    }
  }
}
