import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:truck/features/main/view/option_tile.dart';

import 'nav_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _AppBarTitle(),
        actions: [
          IconButton(
              onPressed: () {},
              icon:
                  SvgPicture.asset('assets/icons/door_arrow_right_outline.svg'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: OptionTile(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: OptionTile(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: OptionTile(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainNavBar(
        initialIndex: 0,
        onNavBarTap: (int value) {},
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subtitleStyle =
        theme.textTheme.bodyMedium?.copyWith(color: theme.disabledColor);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Driver Name",
        ),
        Row(
          children: [
            Text(
              "Driver #000000",
              style: subtitleStyle,
            ),
            const SizedBox(width: 4),
            Text(
              "Truck #000000",
              style: subtitleStyle,
            )
          ],
        )
      ],
    );
  }
}
