import 'package:flutter/material.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer({Key? key, required this.message}) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(.16),
            borderRadius: const BorderRadius.all(Radius.circular(16.0))),
        child: Text(
          message,
          style:
              theme.textTheme.bodyLarge?.copyWith(color: theme.backgroundColor),
        ));
  }
}
