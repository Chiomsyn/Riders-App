import 'package:flutter/material.dart';
import 'package:riders_app/core/global/images.dart';
import 'package:riders_app/presentation/widget/profile_page/profile_header.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/global/screen_navigation.dart';
import '../widget/btn.dart';
import '../widget/edit_box.dart';
import '../widget/image_bg.dart';
import '../widget/profile_page/pic_upload.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = true;

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
                  left: 20.0, right: 20, top: 15, bottom: 20),
              child: Column(
                children: [
                  ProfileHeader(
                      bkClick: () => pop(context),
                      doneClick: () async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        await preferences.setInt('initScreen', 5);
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: UploadPicWidget(
                      onClick: () {},
                    ),
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AppEditBox(
                              iconClick: () {},
                              hintText: "Enter name",
                              label: "Name",
                              controller: name,
                              validator: (val) {}),
                          AppEditBox(
                              iconClick: () {},
                              hintText: "Enter phone number",
                              label: "Phone Number",
                              controller: number,
                              validator: (val) {}),
                          AppEditBox(
                              iconClick: () {},
                              hintText: "Enter email address",
                              label: "Email Address",
                              controller: email,
                              validator: (val) {}),
                          AppEditBox(
                              iconClick: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              hintText: "Enter Password",
                              label: "Password",
                              showPassword: _showPassword,
                              isPassword: true,
                              controller: password,
                              validator: (val) {}),
                          const SizedBox(
                            height: 50,
                          ),
                          AppBtn(
                              onClick: () async {
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                await preferences.setInt('initScreen', 3);
                              },
                              txt: "Continue"),
                        ],
                      ))
                ],
              ),
            )),
          )
        ]),
      ),
    );
  }
}
