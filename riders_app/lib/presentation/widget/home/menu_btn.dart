import 'package:flutter/material.dart';

import '../../../core/global/colors.dart';

class MenuBtn extends StatelessWidget {
  const MenuBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: white, borderRadius: BorderRadius.circular(100)),
        child: const Center(
          child: Icon(
            Icons.menu,
            color: black,
            size: 25,
          ),
        ),
      ),
    );
  }
}
