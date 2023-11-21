import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathProvider;

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class PhotoScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  PhotoScreen(this.cameras);

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  CameraController? controller;
  bool isCapturing = false;
  bool _isrecording = false;
  //For switching Camera
  int _selectedCameraIndex = 0;
  bool _isFrontCamera = false;
  //For Flash
  bool _isFlashOn = false;
  bool _init = false;
  File? _capturedImage;
  String _temppath = '';

  List<bool> _togglebutton = [false, true];
  bool _isphoto = false; //AssetType으로 바꿀거임.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = null;
    controller = CameraController(widget.cameras[0], ResolutionPreset.max);
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

  void _toggleFlashLight() {
    if (_isFlashOn) {
      controller!.setFlashMode(FlashMode.off);
      setState(() {
        _isFlashOn = false;
      });
    } else {
      controller!.setFlashMode(FlashMode.torch);
      setState(() {
        _isFlashOn = true;
      });
    }
  }

  void _switchCamera() async {
    if (controller != null) {
      // Dispose the current controller to release the camera resource
      await controller!.dispose();
    }
    // Increment or reset the selected camera index
    _selectedCameraIndex = (_selectedCameraIndex + 1) % widget.cameras.length;
    // Initialize the new camera
    _initCamera(_selectedCameraIndex);
  }

  Future<void> _initCamera(int cameraIndex) async {
    controller =
        CameraController(widget.cameras[cameraIndex], ResolutionPreset.max);

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

    final Directory appDir =
        await pathProvider.getApplicationSupportDirectory();
    final String capturePath = path.join(appDir.path, '${DateTime.now()}.jpg');

    if (controller!.value.isTakingPicture) {
      return;
    }

    try {
      setState(() {
        isCapturing = true;
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
      final directory = await pathProvider.getTemporaryDirectory();
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

  @override
  Widget build(BuildContext context) {
    if (controller == null || _init == false) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return SafeArea(child: Scaffold(body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        //카메라 필드 aspectratio2임
        // var aspectRatio2 = AspectRatio(
        //     aspectRatio: controller!.value.aspectRatio,
        //     child: CameraPreview(controller!));

        return Stack(
          children: [
            //flash
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GestureDetector(
                            onTap: () {
                              _toggleFlashLight();
                            },
                            child: _isFlashOn == false
                                ? Icon(
                                    Icons.flash_off,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.flash_on,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GestureDetector(),
                        ),
                      ]),
                )),

            //이거는 카메라 비추는 부분 채우는 거임. 나머지 화면 채우도록 되어 있는 거 확인 하시고
            Positioned.fill(
                top: 50,
                bottom: _isFrontCamera == false ? 0 : 150,
                child: CameraPreview(controller!)),

            //하단 부분 채우는 부분 같네
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(color: Colors.black),
                  child: Column(
                    children: [
                      ToggleButtons(
                        isSelected: _togglebutton,
                        onPressed: (index) {
                          setState(() {
                            _togglebutton[index] = true;

                            if (index == 1) {
                              _togglebutton[0] = false;
                              _isphoto = true;
                              //controller video 로 반환하는 함수 필요하다
                            } else {
                              //controller video 로 반환하는 함수 필요함.
                              _togglebutton[1] = false;
                              _isphoto = false;
                            }
                          });
                        },
                        selectedColor: Colors.red,
                        renderBorder: true,
                        borderRadius: BorderRadius.circular(15),
                        children: [const Text("Video"), const Text("Photo")],
                      ),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //찍은 이미지 사진 보여주는 거네 이건 걍 무조건 사진으로 하셈 귀찮으니깐
                                  _capturedImage != null
                                      ? Container(
                                          width: 50,
                                          height: 50,
                                          child: Image.file(
                                            _capturedImage!,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Container()
                                ],
                              )),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    //photo 냐? video 에 따라서 다르게 구현 해야 할 부분
                                    capturePhoto();
                                  },
                                  child: Center(
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            width: 4,
                                            color: Colors.white,
                                            style: BorderStyle.solid,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    _switchCamera();
                                  },
                                  child: const Icon(
                                    Icons.cameraswitch_sharp,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                    ],
                  ),
                )),
          ],
        );
      })));
    }
  }
}
