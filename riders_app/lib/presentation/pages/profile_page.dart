import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riders_app/core/global/app_var.dart';
import 'package:riders_app/core/global/images.dart';
import 'package:riders_app/data_handler/firebase/auth.dart';
import 'package:riders_app/presentation/pages/home.dart';
import 'package:riders_app/presentation/widget/profile_page/profile_header.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/global/colors.dart';
import '../../core/global/screen_navigation.dart';
import '../../data_handler/firebase/user_provider.dart';
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
  void initState() {
    super.initState();

    final user = Provider.of<AuthHandler>(context, listen: false);

    name.text = user.user.name ?? '';
    email.text = user.user.email ?? '';
    number.text = user.user.phone ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserServiceProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          ImageBgWidget(
            image: MImages.selBgImg(context),
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
                        await preferences.setInt('initScreen', 4);
                        user.updateUserStatus1(currentFirebaseUser!.uid);
                        changeScreen(context, HomePage());
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: UploadPicWidget(
                      ringColor: bgColor(context),
                      showCameraIcon: true,
                      onClick: () {},
                      bgColor: profileBgColor(context),
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
                                await preferences.setInt('initScreen', 4);

                                if (await user.updateUserStatus1(
                                    currentFirebaseUser!.uid)) {
                                  changeScreen(context, HomePage());
                                }
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
