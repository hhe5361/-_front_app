import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trackproject/main.dart';

class CameraProvider extends ChangeNotifier {
  CameraController? controller;
  bool _isCapturing = false; //image capture
  bool _isrecording = false; //video record
  int _selectedCameraIndex = 0; //switching camera
  bool _isFrontCamera = false; //front camera
  bool _isFlashOn = false; //falsh on?
  bool _init = false; //isinit controller?
  final bool _isphoto = true; //is photo mode or video mode?

  File? _capturedImage;
  String _temppath = '';

  get isflash => _isFlashOn;
  get isfrontcam => _isFrontCamera;
  get isinit => _init;
  get isphotocam => _isphoto;
  get isgetimage => _isCapturing;
  get isrecording => _isrecording;

  void setCamera() {
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller!.initialize().then((_) {
      _init = true;
      // if (!mounted) {
      //   return;
      // }
      // setState(() {
      //   _init = true;
      // });
    });
    notifyListeners();
  }

  void disposeCamera() {
    controller!.dispose();
  }

  void toggleFlashLight() {
    if (_isFlashOn) {
      controller!.setFlashMode(FlashMode.off);
      _isFlashOn = false;
    } else {
      controller!.setFlashMode(FlashMode.torch);
      _isFlashOn = true;
    }
    notifyListeners();
  }

  void switchCamera() async {
    if (controller != null) {
      // Dispose the current controller to release the camera resource
      await controller!.dispose();
    }
    // Increment or reset the selected camera index
    _selectedCameraIndex = (_selectedCameraIndex + 1) % cameras.length;
    // Initialize the new camera
    _initCamera(_selectedCameraIndex);

    notifyListeners();
  }

  Future<void> _initCamera(int cameraIndex) async {
    controller = CameraController(cameras[cameraIndex], ResolutionPreset.max);

    try {
      await controller!.initialize();
      if (cameraIndex == 0) {
        _isFrontCamera = false;
      } else {
        _isFrontCamera = true;
      }
    } catch (e) {
      print("Error message: ${e}");
    }

    // if (mounted && controller!.value.isInitialized) {
    //   setState(() {});
    // }
    if (controller!.value.isInitialized) {
      notifyListeners();
    }
  }

  void _setCapture() {
    _isCapturing = !_isCapturing;
    notifyListeners();
  }

  void _setVideoCapture() {
    _isrecording = !_isrecording;
    notifyListeners();
  }

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
      _setCapture();

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
      _setCapture();
    }
  }

  void toggleRecording() {
    if (_isrecording) {
      stopVideoRecording();
    } else {
      startVideoRecording();
    }
  }

  void startVideoRecording() async {
    if (!controller!.value.isRecordingVideo) {
      final directory = await getTemporaryDirectory();
      final path =
          '${directory.path}./video_${DateTime.now().millisecondsSinceEpoch}.mp4';

      try {
        await controller!.initialize();

        await controller!.startVideoRecording();
        _temppath = path;
        _setVideoCapture();
      } catch (e) {
        debugPrint(e.toString());
        return;
      }
    }
  }

  void stopVideoRecording() async {
    if (!_isrecording) return;
    if (controller!.value.isRecordingVideo) {
      try {
        final XFile videoFile = await controller!.stopVideoRecording();
        //recording = false;
        _setVideoCapture();

        if (_temppath.isNotEmpty) {
          final File file = File(videoFile.path);
          await file.copy(_temppath);
          await GallerySaver.saveVideo(_temppath);
        }
      } catch (e) {
        debugPrint(e.toString());
        return;
      }
    }
  }
}
