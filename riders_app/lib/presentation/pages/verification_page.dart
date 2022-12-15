import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riders_app/core/global/screen_navigation.dart';
import 'package:riders_app/presentation/pages/auth/log_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/global/images.dart';
import '../../data_handler/firebase/auth.dart';
import '../widget/auth/edit_num_widget.dart';
import '../widget/auth/header_txt.dart';
import '../widget/auth/otp.dart/otp_widget.dart';
import '../widget/auth/sub_header_txt.dart';
import '../widget/btn.dart';
import '../widget/image_bg.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthHandler>(context);

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
                child: Column(
                  children: [
                    const HeaderTextWidget(txt: "Verification"),
                    SubHeaderTxt(
                        txt:
                            "We have sent verification code to +234${auth.number.text}. Kindly verify your phone number"),
                    Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 20),
                      child: EditNumWidget(
                        txt: "+234${auth.number.text}",
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: OTPWidget(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppBtn(
                        onClick: () async {
                          print("huuh");
                          if (await auth.onOtpCodeSubmit()) {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            await preferences.setString(
                                'userStatus', "user verified");
                            changeScreenReplacement(context, const LogInPage());
                            auth.textControllers.clear();
                          }
                        },
                        txt: "Submit"),
                    const SizedBox(
                      height: 20,
                    ),
                    AppBtn(
                      onClick: () async {
                        auth.resendCode();
                      },
                      txt: "Resend Code",
                      borderSide: true,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
