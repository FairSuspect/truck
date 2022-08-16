import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {super.key,
      this.padding = const EdgeInsets.all(16.0),
      required this.child});
  final EdgeInsets padding;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(14.0),
        ),
      ),
      child: child,
    );
  }
}
