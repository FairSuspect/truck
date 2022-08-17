import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:truck/features/doc_option/view/doc_option_screen.dart';
import 'package:truck/features/main/view/option_tile.dart';
import 'package:truck/features/oil_status/view/oil_status_app_bar.dart';
import 'package:truck/features/oil_status/view/oil_status_page.dart';
import 'package:truck/features/qr_code/qr_code.dart';
import 'package:truck/features/qr_code/view/qr_code_app_bar.dart';
import 'package:truck/services/navigation.dart';

import '../provider/provider.dart';
import 'nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String routeName = '/';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IndexedStack(
          index: currentIndex,
          children: const [
            _AppBarTitle(),
            QrCodeAppBarTitle(),
            OilStatusAppBarTitle(),
          ],
        ),
        actions: [
          IconButton(
              onPressed:
                  Provider.of<MainProvider>(context, listen: false).logOut,
              icon:
                  SvgPicture.asset('assets/icons/door_arrow_right_outline.svg'))
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: const [
          _MainScreenPage(),
          QrCodePage(),
          OilStatusPage(),
        ],
      ),
      bottomNavigationBar: MainNavBar(
        initialIndex: currentIndex,
        onNavBarTap: (int value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
    );
  }
}

class _MainScreenPage extends StatelessWidget {
  const _MainScreenPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: OptionTile(onTap: () {
              Navigation()
                  .key
                  .currentState!
                  .pushNamed(DocOptionScreen.routeName);
            }),
          ),
        ],
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
