import 'package:flutter/material.dart';
import 'package:trackproject/src/utilities/Font_const.dart';

InputDecoration myinputdecoration(Icon icon, String msg) => InputDecoration(
      prefixIcon: icon,
      hintText: msg,
      hintStyle: fontDetails(11),
      labelStyle: fontmedi(13),
      focusColor: Colors.red,
    );
