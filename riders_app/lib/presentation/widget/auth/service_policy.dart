import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ServicePolicyWidget extends StatelessWidget {
  VoidCallback termsClick;
  VoidCallback policyClick;

  ServicePolicyWidget(
      {required this.policyClick, required this.termsClick, super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: 'By continuing it means you have read and agreed to ',
          style: const TextStyle(color: Colors.white70, fontSize: 13),
          children: <TextSpan>[
            TextSpan(
                text: 'Terms of Service ',
                style: const TextStyle(color: Colors.blueAccent, fontSize: 13),
                recognizer: TapGestureRecognizer()..onTap = termsClick),
            const TextSpan(
              text: 'and ',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
            TextSpan(
                text: 'Privacy Policy',
                style: const TextStyle(color: Colors.blueAccent, fontSize: 13),
                recognizer: TapGestureRecognizer()..onTap = policyClick),
          ]),
    );
  }
}
