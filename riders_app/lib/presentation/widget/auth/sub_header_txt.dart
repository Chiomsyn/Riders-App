import 'package:flutter/material.dart';

import '../../../core/global/size.dart';

class SubHeaderTxt extends StatelessWidget {
  final String txt;
  const SubHeaderTxt({required this.txt, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: size(context).height * 0.10),
      child: Text(
        txt,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}
