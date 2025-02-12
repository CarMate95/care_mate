import 'package:flutter/material.dart';

void showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String actionText,
  required VoidCallback onConfirm,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff650000)),
          child: Text(actionText),
        ),
      ],
    ),
  );
}
