import 'package:flutter/material.dart';

class QrCodeBody extends StatelessWidget {
  const QrCodeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(30.0),
          )),
      padding: const EdgeInsets.all(13.0),
      child: const Placeholder(
        fallbackHeight: 274,
        fallbackWidth: 274,
      ),
    );
  }
}
