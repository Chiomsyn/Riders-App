import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riders_app/core/global/app_var.dart';
import 'package:riders_app/core/global/colors.dart';
import 'package:riders_app/presentation/pages/auth/sign_up.dart';
import 'package:riders_app/presentation/pages/profile_page.dart';
import 'package:riders_app/presentation/widget/auth/header_txt.dart';
import 'package:riders_app/presentation/widget/auth/pre_icon_txt.dart';
import 'package:riders_app/presentation/widget/auth/sub_header_txt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/global/images.dart';
import '../../../core/global/screen_navigation.dart';
import '../../../data_handler/firebase/auth.dart';
import '../../widget/auth/nav_log_reg.dart';
import '../../widget/auth/rem_me.dart';
import '../../widget/btn.dart';
import '../../widget/edit_box.dart';
import '../../widget/image_bg.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthHandler>(context);
    return SafeArea(
        child: Scaffold(
            body: Stack(
      children: [
        ImageBgWidget(
            image: MImages.selBgImg(context),
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20, top: 50, bottom: 20),
              child: Column(children: [
                const HeaderTextWidget(txt: "Log in"),
                const SubHeaderTxt(txt: "Enter your login credentials"),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AppEditBox(
                            hintText: "Enter Email",
                            label: "Email Address",
                            controller: auth.email,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter Email Address';
                              }
                            }),
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
                            controller: auth.password,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter Password';
                              }
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RememberWidget(
                              onClick: (bool? val) {},
                              val: false,
                            ),
                            PrefixIconTxt(
                              color: mPrimary(context),
                              lbl: "Forget Password",
                              onClick: () {},
                              icon: Icons.question_mark,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        AppBtn(
                            onClick: () async {
                              if (_formKey.currentState!.validate()) {
                                if (await auth.logUserIn()) {
                                  print("yess123");
                                  if (currentFirebaseUser!.displayName ==
                                      "user verified") {
                                    print("yess");
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    await preferences.setInt('initScreen', 4);
                                    auth.clearControllers();
                                    changeScreen(context, ProfilePage());
                                  }
                                } else if (currentFirebaseUser!.displayName ==
                                        "profileFullyUpdated" ||
                                    currentFirebaseUser!.displayName ==
                                        "profileUpdated") {
                                } else {
                                  print("user does not exist");
                                }
                              }
                            },
                            txt: "Continue"),
                        const SizedBox(
                          height: 20,
                        ),
                        NavToLogRegWidget(
                            txt2: 'Sign up',
                            txt1: 'Don\'t have an account? ',
                            onClick: () => changeScreenReplacement(
                                context, const SignUpPage()))
                      ],
                    ))
              ]),
            )))
      ],
    )));
  }
}
