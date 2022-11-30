import 'package:flutter/material.dart';

class HeaderTextWidget extends StatelessWidget {
  final String txt;
  const HeaderTextWidget({required this.txt, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(txt, style: Theme.of(context).textTheme.titleLarge);
  }
}
