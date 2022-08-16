import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainNavBar extends StatefulWidget {
  const MainNavBar({
    Key? key,
    required this.initialIndex,
    required this.onNavBarTap,
  }) : super(key: key);

  final int initialIndex;
  final ValueChanged<int> onNavBarTap;
  @override
  State<MainNavBar> createState() => _MainNavBarState();
}

class _MainNavBarState extends State<MainNavBar> {
  static const _svgIconNames = [
    'home_outline',
    'qr_code',
    "water_drop_outline",
    'question_outline',
  ];
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          widget.onNavBarTap(index);
          setState(() {
            currentIndex = index;
          });
        },
        items: _svgIconNames
            .map((svgName) => BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  "assets/icons/$svgName.svg",
                  color: theme.primaryColor,
                ),
                icon: InkWell(
                  child: SvgPicture.asset(
                    "assets/icons/$svgName.svg",
                    color: theme.disabledColor,
                  ),
                ),
                label: ''))
            .toList());
  }
}
