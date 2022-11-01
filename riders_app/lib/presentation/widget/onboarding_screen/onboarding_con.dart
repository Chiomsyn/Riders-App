import 'package:flutter/material.dart';
import 'package:riders_app/core/global/colors.dart';
import 'package:riders_app/presentation/widget/btn.dart';
import 'package:riders_app/presentation/widget/image_bg.dart';

import '../../../core/global/images.dart';
import 'build_dots.dart';

class BoardingContainer extends StatelessWidget {
  final List<String> images = [
    MImages.on1,
    MImages.on2,
    MImages.on3,
  ];

  final List<String> word1 = [
    "Advanced hailing",
    "Global Operation",
    "Multi-platform software",
  ];

  final List<String> word2 = [
    "Droptaxi is technically advanced yet simple to use. We have dedicated so much time and effort in developing Droptaxi using the best software tools in the business.",
    "Droptaxi operates in most cities in the world. With support for most countries, currencies and languages including (Right-to-left languages)",
    "Droptaxi operates in most cities in the world. With support for most countries, currencies and languages including (Right-to-left languages)"
  ];

  BoardingContainer({
    Key? key,
    required this.selectedIndex,
    required this.index,
    required this.bkClick,
    required this.nxtClick,
    required this.skipClick,
  }) : super(key: key);

  int selectedIndex;
  int index;
  VoidCallback nxtClick;
  VoidCallback bkClick;
  VoidCallback skipClick;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          ImageBgWidget(
            image: MImages.on4,
            child: Stack(
              children: [
                Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25.0, 0, 25, 0),
                      child: Column(
                        children: [
                          BuildDots(
                            index: index,
                            selectedIndex: selectedIndex,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(word1[index],
                              style: const TextStyle(
                                  fontSize: 25,
                                  color: white,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(word2[index],
                              style:
                                  const TextStyle(fontSize: 16, color: white),
                              textAlign: TextAlign.center),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 50,
                            child: Row(
                                mainAxisAlignment: selectedIndex == 1
                                    ? MainAxisAlignment.spaceBetween
                                    : MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: bkClick,
                                    child: Visibility(
                                        visible: selectedIndex > 0,
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: white,
                                              size: 12,
                                            ),
                                            Text('Back',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        )),
                                  ),
                                  GestureDetector(
                                    onTap: nxtClick,
                                    child: Visibility(
                                        visible: selectedIndex < 2,
                                        child: Row(
                                          children: const [
                                            Text('Next',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: white,
                                              size: 12,
                                            )
                                          ],
                                        )),
                                  ),
                                ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AppBtn(
                              onClick: skipClick,
                              txt: selectedIndex < 2 ? "Skip" : "Get Started")
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
