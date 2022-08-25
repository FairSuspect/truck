import 'package:flutter/material.dart';

class OilStatusAppBarTitle extends StatelessWidget {
  const OilStatusAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            style: Theme.of(context).appBarTheme.titleTextStyle,
            children: [
          const TextSpan(text: 'Oil status'),
          TextSpan(
              text: " (Work in Progress)",
              style: TextStyle(color: Theme.of(context).errorColor))
        ]));
  }
}
