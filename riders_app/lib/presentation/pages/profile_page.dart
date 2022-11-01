import 'package:flutter/material.dart';
import 'package:riders_app/core/global/images.dart';

import '../widget/image_bg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          ImageBgWidget(
            image: MImages.on1,
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20, top: 50, bottom: 20),
              child: Column(
                children: [],
              ),
            )),
          )
        ]),
      ),
    );
  }
}
