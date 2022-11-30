import 'package:flutter/material.dart';

import '../../core/global/colors.dart';

class AppEditBox extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  Function(String?) validator;
  String label;
  String hintText;
  bool? showPassword;
  VoidCallback? iconClick;
  bool? isPassword;

  AppEditBox(
      {super.key,
      this.showPassword,
      this.iconClick,
      required this.hintText,
      required this.label,
      required this.controller,
      required this.validator,
      this.isPassword});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 45,
            child: TextFormField(
              style: const TextStyle(color: white),
              cursorColor: grey,
              obscureText: showPassword ?? false,
              autofocus: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller,
              validator: (String? value) => validator(value),
              decoration: InputDecoration(
                filled: true,
                fillColor: fillColor(context),
                suffixIcon: isPassword != null
                    ? GestureDetector(
                        onTap: iconClick,
                        child: Icon(
                          showPassword ?? false
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.blue[300],
                          size: 15,
                        ),
                      )
                    : null,
                enabledBorder: OutlineInputBorder(
                    borderSide: border(context),
                    borderRadius: BorderRadius.circular(10.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: border(context),
                    borderRadius: BorderRadius.circular(10.0)),
                hintText: hintText, //hint text
                hintStyle:
                    Theme.of(context).textTheme.labelMedium, //hint text style
                hintMaxLines: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
