import 'package:flutter/material.dart';

///十六进制转为颜色
class CMColorTools {
  static Color cmColor(String hexStr, {double alpha = 1}) {
    int? val;
    if (hexStr.toUpperCase().contains("#")) {
      hexStr = hexStr.substring(1);
    }
    if (hexStr.toUpperCase().contains("0X")) {
      String desString = hexStr.substring(2);
      val = int.tryParse("0x$desString");
    } else {
      val = int.tryParse("0x$hexStr");
    }

    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }

    return Color.fromRGBO((val! & 0xFF0000) >> 16, (val & 0x00FF00) >> 8,
        (val & 0x0000FF) >> 0, alpha);
  }

  static Color cmYellow = cmColor("#E1F062");
}




