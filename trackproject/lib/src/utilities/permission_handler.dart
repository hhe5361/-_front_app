import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

//permission handler는 조금 더 봐야할 듯..
class PermissionHandlerService {
  Future<bool> handlePhotosPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      return false;
    }
  }
}
