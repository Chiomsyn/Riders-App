import 'package:flutter/material.dart';
import 'package:riders_app/core/global/colors.dart';
import 'package:riders_app/presentation/widget/divider.dart';

import '../profile_page/pic_upload.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            UploadPicWidget(
              onClick: () {},
            ),
            Column(
              children: const [
                Text(
                  "",
                  style: TextStyle(color: white, fontSize: 16),
                ),
                Text(
                  "",
                  style: TextStyle(color: grey, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
        const DividerWidget(),
        const Text(
          "Payment",
          style: TextStyle(color: grey, fontSize: 16),
        ),
        Column(
          children: const [
            Text(
              "Promotions",
              style: TextStyle(color: grey, fontSize: 16),
            ),
            Text(
              "Enter promo code",
              style: TextStyle(color: grey, fontSize: 16),
            ),
          ],
        ),
        const Text(
          "",
          style: TextStyle(color: grey, fontSize: 16),
        ),
      ],
    );
  }
}
