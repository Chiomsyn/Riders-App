import 'package:flutter/material.dart';
import 'package:riders_app/core/global/colors.dart';

class ProfileHeader extends StatelessWidget {
  VoidCallback bkClick;
  VoidCallback doneClick;

  ProfileHeader({required this.bkClick, required this.doneClick, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: bkClick,
          child: const Icon(
            Icons.arrow_back,
            color: mPrimary,
          ),
        ),
        const Text(
          "Profile",
          style: TextStyle(color: white, fontSize: 15),
        ),
        GestureDetector(
          onTap: doneClick,
          child: const Text(
            "Done",
            style: TextStyle(color: mPrimary),
          ),
        )
      ],
    );
  }
}
