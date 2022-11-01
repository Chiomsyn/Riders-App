import 'package:flutter/material.dart';

class HeaderTextWidget extends StatelessWidget {
  final String txt;
  const HeaderTextWidget({required this.txt, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: const TextStyle(
          color: Colors.blueAccent, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
