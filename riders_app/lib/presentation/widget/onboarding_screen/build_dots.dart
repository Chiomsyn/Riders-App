import 'package:flutter/material.dart';

import '../../../core/global/colors.dart';

class BuildDots extends StatelessWidget {
  int selectedIndex;
  int index;
  BuildDots({required this.index, required this.selectedIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 10,
        width: 50,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: 10,
                  width: selectedIndex == index ? 20 : 7,
                  decoration: BoxDecoration(
                    color: selectedIndex == index ? white : grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            }));
  }
}
