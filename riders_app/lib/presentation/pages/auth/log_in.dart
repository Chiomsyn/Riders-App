import 'package:flutter/material.dart';
import 'package:riders_app/presentation/pages/auth/sign_up.dart';
import 'package:riders_app/presentation/widget/auth/header_txt.dart';
import 'package:riders_app/presentation/widget/auth/pre_icon_txt.dart';
import 'package:riders_app/presentation/widget/auth/sub_header_txt.dart';

import '../../../core/global/images.dart';
import '../../../core/global/screen_navigation.dart';
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
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Stack(
      children: [
        ImageBgWidget(
            image: MImages.on1,
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
                            iconClick: () {},
                            hintText: "Enter phone number",
                            label: "Phone Number",
                            controller: number,
                            validator: (val) {}),
                        AppEditBox(
                            iconClick: () {},
                            hintText: "Enter Password",
                            label: "Password",
                            isPassword: true,
                            controller: password,
                            validator: (val) {}),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RememberWidget(
                              onClick: (bool? val) {},
                              val: false,
                            ),
                            PrefixIconTxt(
                              color: Colors.blueAccent,
                              lbl: "Forget Password",
                              onClick: () {},
                              icon: Icons.question_mark,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        AppBtn(onClick: () {}, txt: "Continue"),
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
