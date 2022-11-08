import 'package:flutter/material.dart';

import '../../../core/global/colors.dart';

class EditNumWidget extends StatelessWidget {
  String txt;
  EditNumWidget({required this.txt, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          txt,
          style: TextStyle(color: grey),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 7, 40, 90),
              borderRadius: BorderRadius.circular(5)),
          height: 17,
          width: 17,
          child: const Icon(
            Icons.edit_outlined,
            size: 14,
            color: mPrimary,
          ),
        )
      ],
    );
  }
}
