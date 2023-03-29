import 'package:flutter/material.dart';

void show_snackbar_notification(BuildContext context, String notification,
    String snackbar_action, VoidCallback onPressed) {
  final snackBar = SnackBar(
    content: Text(notification),
    action: SnackBarAction(
      label: snackbar_action,
      onPressed: () {
        onPressed();
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
