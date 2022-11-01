import 'package:flutter/material.dart';

class AppBtn extends StatelessWidget {
  VoidCallback onClick;
  bool borderSide = false;
  String txt;
  AppBtn({super.key, required this.onClick, required this.txt});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: borderSide ? null : Color(0xff2196F3),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: const BorderSide(color: Color(0xff2196F3)))),
      onPressed: onClick,
      child: SizedBox(
        height: 40.0,
        child: Center(
          child: Text(
            txt,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}
