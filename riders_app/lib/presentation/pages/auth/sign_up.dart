import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riders_app/core/global/images.dart';
import 'package:riders_app/data_handler/firebase/auth.dart';
import 'package:riders_app/presentation/pages/auth/log_in.dart';
import 'package:riders_app/presentation/pages/verification_page.dart';
import 'package:riders_app/presentation/widget/auth/nav_log_reg.dart';
import 'package:riders_app/presentation/widget/edit_box.dart';
import 'package:riders_app/presentation/widget/image_bg.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                const HeaderTextWidget(txt: "Sign Up"),
                const SubHeaderTxt(txt: "Create your Droptaxi account"),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AppEditBox(
                            hintText: "Enter name",
                            label: "Name",
                            controller: auth.name,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter Name';
                              }
                            }),
                        AppEditBox(
                            hintText: "Enter phone number",
                            label: "Phone Number",
                            controller: auth.number,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter Phone Number';
                              } else if (val.length > 10 || val.length < 10) {
                                return 'Please enter a valid number';
                              } else if (val.startsWith("0")) {
                                return 'Number format should not start with 0';
                              }
                            }),
                        AppEditBox(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            hintText: "Enter email address",
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Password';
                              }
                              return null;
                            }),
                        ServicePolicyWidget(
                          policyClick: () {},
                          termsClick: () {},
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        AppBtn(
                            onClick: () async {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('snack'),
                                  duration: Duration(seconds: 1),
                                  // action: SnackBarAction(
                                  //   label: 'ACTION',
                                  //   onPressed: () {},
                                  // ),
                                ));

                                await auth.createUser();
                                if (auth.status == Status.userCreated) {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  await preferences.setString(
                                      'userStatus', "user created");
                                  changeScreenReplacement(
                                      context, const VerificationPage());
                                  // auth.clearControllers();
                                }
                              }
                              // auth.clearControllers();
                            },
                            txt: "Continue"),
                        const SizedBox(
                          height: 20,
                        ),
                        NavToLogRegWidget(
                            txt2: 'Log in',
                            txt1: 'Already have an account? ',
                            onClick: () {
                              changeScreenReplacement(
                                  context, const LogInPage());
                            })
                      ],
                    ))
              ]),
            )))
      ],
    )));
  }
}
