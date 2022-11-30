import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MImages {
  static const String logo = "assets/images/logo.PNG";
  static const String logo1 = "assets/images/logo1.png";
  static const String on1 = "assets/images/image1.png";
  static const String on2 = "assets/images/image2.png";
  static const String on3 = "assets/images/image3.png";
  static const String on4 = "assets/images/image4.png";
  static const String person = "assets/images/person.png";

  static String selBgImg(context) {
    String img = Theme.of(context).brightness == Brightness.light ? on4 : on1;

    return img;
  }
}
