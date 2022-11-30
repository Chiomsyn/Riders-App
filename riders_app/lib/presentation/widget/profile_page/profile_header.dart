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
          child: Icon(
            Icons.arrow_back,
            color: mPrimary(context),
          ),
        ),
        Text(
          "Profile",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        GestureDetector(
          onTap: doneClick,
          child: Text(
            "Done",
            style: TextStyle(color: mPrimary(context)),
          ),
        )
      ],
    );
  }
}
