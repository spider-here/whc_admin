import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';

class ConfirmationDialog extends StatelessWidget {
  final String message;
  final String confirmButtonLabel;
  final VoidCallback onConfirm;
  final Color confirmButtonColor;

  const ConfirmationDialog({
    super.key,
    required this.message,
    String? confirmButtonLabel,
    required this.onConfirm,
  })  : confirmButtonColor = kPrimaryColor,
        confirmButtonLabel = confirmButtonLabel ?? 'Yes';

  const ConfirmationDialog.delete({
    super.key,
    required this.message,
    required this.confirmButtonLabel,
    required this.onConfirm,
  }) : confirmButtonColor = kRed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: kWhite,
      surfaceTintColor: kWhite,
      title: const Text("Confirm"),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          style: ButtonStyle(foregroundColor: MaterialStateProperty.all(kGrey)),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: onConfirm,
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(confirmButtonColor)),
          child: Text(confirmButtonLabel),
        )
      ],
    );
  }
}
