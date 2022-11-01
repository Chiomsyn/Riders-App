import 'package:flutter/material.dart';
import 'package:riders_app/core/global/images.dart';
import 'package:riders_app/presentation/pages/auth/log_in.dart';
import 'package:riders_app/presentation/widget/auth/nav_log_reg.dart';
import 'package:riders_app/presentation/widget/edit_box.dart';
import 'package:riders_app/presentation/widget/image_bg.dart';

import '../../../core/global/screen_navigation.dart';
import '../../widget/auth/header_txt.dart';
import '../../widget/auth/service_policy.dart';
import '../../widget/auth/sub_header_txt.dart';
import '../../widget/btn.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
            body: Stack(
      children: [
        ImageBgWidget(
            image: MImages.on1,
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20, top: 50, bottom: 20),
              child: Column(children: [
                const HeaderTextWidget(txt: "Sign Up"),
                const SubHeaderTxt(txt: "Create your Droptaxi account"),
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
                        ServicePolicyWidget(
                          policyClick: () {},
                          termsClick: () {},
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        AppBtn(onClick: () {}, txt: "Continue"),
                        const SizedBox(
                          height: 20,
                        ),
                        NavToLogRegWidget(
                            txt2: 'Log in',
                            txt1: 'Already have an account? ',
                            onClick: () => changeScreenReplacement(
                                context, const LogInPage()))
                      ],
                    ))
              ]),
            )))
      ],
    )));
  }
}
