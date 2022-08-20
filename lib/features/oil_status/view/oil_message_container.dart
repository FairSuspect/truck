import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OilMessageContainer extends StatelessWidget {
  const OilMessageContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(36.0),
        ),
        color: theme.cardColor,
      ),
      padding: const EdgeInsets.all(34.0),
      child: Column(
        children: const [
          _ExpiresMessage(message: "Expires in 15 min"),
          SizedBox(height: 22),
          _IconBody()
        ],
      ),
    );
  }
}

class _IconBody extends StatelessWidget {
  const _IconBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(55.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(57.0)),
        color: theme.primaryColor.withOpacity(.08),
      ),
      child: SvgPicture.asset(
        "assets/icons/water_drop_outline.svg",
        height: 116,
        color: theme.primaryColor,
      ),
    );
  }
}

class _ExpiresMessage extends StatelessWidget {
  const _ExpiresMessage({Key? key, required this.message}) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: theme.backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(16.0))),
        child: Text(
          message,
          style: theme.textTheme.bodyLarge
              ?.copyWith(color: theme.colorScheme.onSecondary),
        ));
  }
}
