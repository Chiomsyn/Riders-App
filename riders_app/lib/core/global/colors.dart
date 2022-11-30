import 'package:flutter/material.dart';

const red = Colors.red;
const black = Colors.black;
const white = Colors.white;
const grey = Colors.grey;
const blue = Colors.blue;
const Color mTransparent = Color(0x00FFFFFF);
const primary = Colors.blueAccent;

Color mPrimary(context) {
  return Theme.of(context).primaryColor;
}

Color bgColor(context) {
  return Theme.of(context).backgroundColor;
}

Color fillColor(context) {
  return (Theme.of(context).brightness == Brightness.dark)
      ? Colors.blue[300]!.withOpacity(0.2)
      : white;
}

BorderSide border(context) {
  return (Theme.of(context).brightness == Brightness.dark)
      ? BorderSide(color: Colors.blue[900]!)
      : BorderSide.none;
}

// Color secondary(context) {
//   return Theme.of(context).primaryColor;
// }

