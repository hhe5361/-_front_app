import 'package:flutter/material.dart';
import 'package:trackproject/src/utilities/Font_const.dart';
import 'package:trackproject/src/utilities/HexColor.dart';

void showSnackBar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 700),
      behavior: SnackBarBehavior.floating,
      content: Text(message, textAlign: TextAlign.center, style: fontmedi(15)),
      backgroundColor: ColorGrey,
      //behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
  );
}
