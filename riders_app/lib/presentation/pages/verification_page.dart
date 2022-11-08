import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/global/images.dart';
import '../../data_handler/auth.dart';
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
                    const SubHeaderTxt(
                        txt:
                            "We have sent verification code to 08166879923. Kindly verify your phone number"),
                    Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 20),
                      child: EditNumWidget(
                        txt: "+2348166879923",
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: OTPWidget(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppBtn(onClick: () {}, txt: "Submit"),
                    const SizedBox(
                      height: 20,
                    ),
                    AppBtn(
                      onClick: () {},
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
