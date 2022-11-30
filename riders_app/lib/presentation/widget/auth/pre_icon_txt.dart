import 'package:flutter/material.dart';

class PrefixIconTxt extends StatelessWidget {
  VoidCallback onClick;
  String lbl;
  Color color;
  IconData icon;
  PrefixIconTxt(
      {required this.icon,
      required this.color,
      required this.lbl,
      required this.onClick,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Row(
        children: [
          Text(lbl,
              style: TextStyle(
                  fontSize: 13, color: color, fontWeight: FontWeight.bold)),
          const SizedBox(
            width: 2,
          ),
          Icon(
            icon,
            color: color,
            size: 12,
          )
        ],
      ),
    );
  }
}
