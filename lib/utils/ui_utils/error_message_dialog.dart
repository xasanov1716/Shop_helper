import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

void showErrorMessage({
  required String message,
  required BuildContext context,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Colors.white,
      title: const Text(
        "Error",
        style: TextStyle(fontWeight: FontWeight.w800),
      ),
      content: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          message,
          style:
              TextStyle(fontWeight: FontWeight.w500, color: AppColors.c_273032),
        ),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          isDefaultAction: true,
          child: const Text("ok"),
        )
      ],
    ),
  );
}

Future<void> showConfirmMessage({
  required String message,
  required BuildContext context,
}) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Colors.white,
      content: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          message,
          style:
              TextStyle(fontWeight: FontWeight.w500, color: AppColors.c_273032),
        ),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          isDefaultAction: true,
          child: const Text("ok"),
        )
      ],
    ),
  );
}


void showSnackbar(BuildContext context,String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Add your action here, e.g., navigating to another screen.
        },
      ),
    ),
  );}
