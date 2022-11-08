import 'package:flutter/material.dart';

class AppBtn extends StatelessWidget {
  VoidCallback onClick;
  bool? borderSide;
  String txt;
  AppBtn(
      {this.borderSide, super.key, required this.onClick, required this.txt});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
          backgroundColor: (borderSide != null) ? Colors.transparent : null,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: const BorderSide(color: Color(0xff2196F3)))),
      child: SizedBox(
        height: 40.0,
        child: Center(
          child: Text(
            txt,
            style: const TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}
