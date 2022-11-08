import 'package:flutter/material.dart';

void showMessage(String errorMessage, context) {
  showDialog(
      context: context,
      builder: (BuildContext builderContext) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              child: Text("Ok"),
              onPressed: () async {
                Navigator.of(builderContext).pop();
              },
            )
          ],
        );
      }).then((value) {
    // setState(() {
    //   isLoading = false;
    // });
  });
}
