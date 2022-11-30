import 'package:flutter/material.dart';
import 'package:riders_app/core/global/colors.dart';

class RememberWidget extends StatelessWidget {
  Function(bool?) onClick;
  bool val;
  RememberWidget({required this.onClick, required this.val, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 10,
          width: 20,
          child: Checkbox(
              checkColor: Colors.blueAccent,
              fillColor: MaterialStateProperty.all<Color>(mPrimary(context)),
              value: val,
              onChanged: (bool? value) => onClick),
        ),
        Text(
          "Remember me",
          style: TextStyle(
              color: mPrimary(context),
              fontSize: 13,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
