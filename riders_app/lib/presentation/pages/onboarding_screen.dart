import 'package:flutter/material.dart';
import 'package:riders_app/core/global/screen_navigation.dart';
import 'package:riders_app/presentation/pages/auth/sign_up.dart';
import 'package:riders_app/presentation/widget/onboarding_screen/onboarding_con.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _selectedIndex = 0;
  PageController _controller = PageController();

  @override
  void initState() {
    super.initState();

    // startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: _controller,
          itemCount: 3,
          itemBuilder: (context, index) => BoardingContainer(
            index: index,
            selectedIndex: _selectedIndex,
            bkClick: () {
              if (_selectedIndex >= 0) {
                setState(() {
                  _controller.previousPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.bounceIn);
                });
              }
            },
            nxtClick: () {
              if (_selectedIndex < 2) {
                setState(() {
                  _controller.nextPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.bounceIn);
                });
              }
            },
            skipClick: () {
              changeScreenReplacement(context, const SignUpPage());
            },
          ),
          onPageChanged: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
        ),
      ],
    );
  }
}
