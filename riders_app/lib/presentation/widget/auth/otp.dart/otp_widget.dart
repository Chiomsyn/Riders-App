import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riders_app/data_handler/auth.dart';

import 'opt_edit_box.dart';

class OTPWidget extends StatefulWidget {
  const OTPWidget({super.key});

  @override
  State<OTPWidget> createState() => _OTPWidgetState();
}

class _OTPWidgetState extends State<OTPWidget> {
  int numOfOtp = 6;
  late List<FocusNode?> _focusNodes;

  @override
  void initState() {
    super.initState();
    Provider.of<AuthHandler>(context, listen: false).verificationCode =
        List<String?>.filled(numOfOtp, null);
    _focusNodes = List<FocusNode?>.filled(numOfOtp, null);
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   Provider.of<AuthHandler>(context, listen: false)
  //       .textControllers
  //       .forEach((TextEditingController? controller) => controller?.dispose());
  // }

  @override
  void didUpdateWidget(covariant OTPWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    for (var controller
        in Provider.of<AuthHandler>(context, listen: false).textControllers) {
      controller.clear();

      Provider.of<AuthHandler>(context, listen: false).verificationCode =
          List<String?>.filled(numOfOtp, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthHandler>(context);

    List<OTPEditboxWidget> otpEditList = List.generate(6, (int i) {
      addFocusNodeToEachTextField(index: i);
      // addTextEditingControllerToEachTextField(
      //     index: i, textControllers: auth.textControllers);

      return OTPEditboxWidget(
        controller: auth.textControllers[i],
        focusNode: _focusNodes[i]!,
        onTyped: (String? val) {
          Provider.of<AuthHandler>(context, listen: false).verificationCode[i] =
              val;

          changeFocusToNextNodeWhenValueIsEntered(
            value: val!,
            indexOfTextField: i,
          );
          changeFocusToPreviousNodeWhenValueIsRemoved(
              value: val, indexOfTextField: i);
        },
      );
    });

    return Row(
      children: otpEditList,
    );
  }

  void changeFocusToNextNodeWhenValueIsEntered({
    required String value,
    required int indexOfTextField,
  }) {
    //only change focus to the next textField if the value entered has a length greater than one
    if (value.isNotEmpty) {
      if (indexOfTextField + 1 != numOfOtp) {
        FocusScope.of(context).requestFocus(_focusNodes[indexOfTextField + 1]);
      } else {
        _focusNodes[indexOfTextField]?.unfocus();
      }
    }
  }

  void changeFocusToPreviousNodeWhenValueIsRemoved({
    required String value,
    required int indexOfTextField,
  }) {
    //only change focus to the previous textField if the value entered has a length zero
    if (value.isEmpty) {
      if (indexOfTextField != 0) {
        FocusScope.of(context).requestFocus(_focusNodes[indexOfTextField - 1]);
      }
    }
  }

  void addFocusNodeToEachTextField({required int index}) {
    if (_focusNodes[index] == null) {
      _focusNodes[index] = FocusNode();
    }
  }

  void addTextEditingControllerToEachTextField(
      {required int index, required List textControllers}) {
    if (textControllers[index] == null) {
      textControllers[index] = TextEditingController();
    }
  }
}
