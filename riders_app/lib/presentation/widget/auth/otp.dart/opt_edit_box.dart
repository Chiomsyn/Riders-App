import 'package:flutter/material.dart';

import '../../../../core/global/colors.dart';

class OTPEditboxWidget extends StatelessWidget {
  TextEditingController? controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  Function(String?) onTyped;
  OTPEditboxWidget(
      {required this.onTyped,
      this.controller,
      required this.focusNode,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      height: 40,
      width: 40,
      child: TextFormField(
        style: const TextStyle(
          color: white,
        ),
        cursorColor: grey,
        autofocus: true,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        onChanged: (String? value) => onTyped(value),
        focusNode: focusNode,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.blue[300]!.withOpacity(0.2),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue[900]!),
                borderRadius: BorderRadius.circular(10.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue[900]!),
                borderRadius: BorderRadius.circular(10.0))),
      ),
    );
  }
}
