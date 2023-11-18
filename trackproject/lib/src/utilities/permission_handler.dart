import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

//permission handler는 조금 더 봐야할 듯..
class PermissionHandlerService {
  Future<bool> handlePhotosPermission(Permission permission) async {
    var status = await Permission.audio.request();
    debugPrint("current 스테이터스" + status.toString());
    if (status.isGranted) {
      return true;
    } else {
      openAppSettings();
      return true;
    }
  }
}
