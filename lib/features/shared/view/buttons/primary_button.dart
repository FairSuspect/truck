import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({Key? key, required this.onPressed, required this.child})
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
            color: onPressed != null ? theme.primaryColor : theme.disabledColor,
            borderRadius: const BorderRadius.all(Radius.circular(14.0))),
        child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              primary: Theme.of(context).backgroundColor,
            ).copyWith(
                foregroundColor:
                    MaterialStateProperty.all(theme.backgroundColor)),
            child: child),
      ),
    );
  }
}
