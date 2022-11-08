import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:riders_app/core/global/images.dart';

import '../../../core/global/colors.dart';

class UploadPicWidget extends StatelessWidget {
  VoidCallback onClick;
  String? image;
  UploadPicWidget({this.image, required this.onClick, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 90,
      child: Stack(
        children: [
          GestureDetector(
            onTap: onClick,
            child: Container(
              margin: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 2.0,
                    color: mPrimary,
                  ),
                  borderRadius: BorderRadius.circular(100)),
              child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 35.0,
                  backgroundImage: ((image == null)
                      ? const AssetImage(MImages.person) as ImageProvider
                      : CachedNetworkImageProvider(
                          image!,
                        ))),
            ),
          ),
          Positioned(
            top: 1,
            right: 5,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: mPrimary,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(Icons.camera_alt_outlined),
            ),
          )
        ],
      ),
    );
  }
}
