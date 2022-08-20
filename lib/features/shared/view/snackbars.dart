import 'package:flutter/material.dart';

class SnackBars {
  static SnackBar info(String content) => SnackBar(
        content: Container(
            alignment: Alignment.center, height: 30, child: Text(content)),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 40.0),
        behavior: SnackBarBehavior.floating,
      );
}
