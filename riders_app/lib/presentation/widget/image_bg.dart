import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/global/size.dart';

class ImageBgWidget extends StatelessWidget {
  Widget child;
  String image;
  ImageBgWidget({super.key, required this.child, required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Image.asset(
          image,
          fit: BoxFit.fill,
        )),
        SizedBox(
            height: size(context).height,
            width: size(context).width,
            child: child),
      ],
    );
  }
}
