import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton(
      {Key? key, required this.onPressed, required this.child})
      : super(key: key);
  final VoidCallback? onPressed;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      height: 56.0,
      child: Container(
        decoration: BoxDecoration(
            color: onPressed != null
                ? theme.primaryColor.withOpacity(.08)
                : theme.disabledColor,
            borderRadius: const BorderRadius.all(Radius.circular(14.0))),
        child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ).copyWith(
                foregroundColor: MaterialStateProperty.all(theme.primaryColor)),
            child: child),
      ),
    );
  }
}
