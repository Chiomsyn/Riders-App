import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:riders_app/core/global/colors.dart';

class NavToLogRegWidget extends StatelessWidget {
  VoidCallback onClick;
  String txt1;
  String txt2;
  NavToLogRegWidget(
      {required this.txt2,
      required this.txt1,
      required this.onClick,
      super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: txt1,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
          children: <TextSpan>[
            TextSpan(
                text: txt2,
                style: const TextStyle(color: mPrimary, fontSize: 13),
                recognizer: TapGestureRecognizer()..onTap = onClick)
          ]),
    );
  }
}
