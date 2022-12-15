import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riders_app/core/global/colors.dart';
import 'package:riders_app/core/global/size.dart';
import 'package:riders_app/data_handler/firebase/auth.dart';
import 'package:riders_app/presentation/widget/divider.dart';

import '../profile_page/pic_upload.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthHandler>(context);

    return Container(
      width: size(context).width * 0.8,
      decoration: BoxDecoration(
          color: bgColor(context),
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                UploadPicWidget(
                  onClick: () {},
                  ringColor: drawerProfileBgColor(context),
                  bgColor: drawerProfileBgColor(context),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.user.name ?? '',
                      style: TextStyle(
                          color: textColor(context),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Edit Profile",
                      style: TextStyle(color: grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            const DividerWidget(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
              child: Text(
                "Payment",
                style: TextStyle(color: textColor(context), fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Promotions",
                    style: TextStyle(color: textColor(context), fontSize: 16),
                  ),
                  const Text(
                    "Enter promo code",
                    style: TextStyle(color: grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Promotions",
                style: TextStyle(color: textColor(context), fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
