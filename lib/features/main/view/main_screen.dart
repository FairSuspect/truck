import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:truck/features/contact/view/contact_screen.dart';
import 'package:truck/features/main/provider/option_provider.dart';
import 'package:truck/features/main/view/error_card.dart';
import 'package:truck/features/main/view/option_tile.dart';
import 'package:truck/features/oil_status/view/oil_status_app_bar.dart';
import 'package:truck/features/oil_status/view/oil_status_page.dart';
import 'package:truck/features/qr_code/qr_code.dart';
import 'package:truck/features/qr_code/view/qr_code_app_bar.dart';
import 'package:truck/services/theme/light_theme.dart';

import '../provider/provider.dart';
import '../provider/user_provider.dart';
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
          ContactScreen(),
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
      child: Consumer<OptionProvider>(builder: (context, controller, child) {
        return controller.hasError
            ? const Center(child: ErrorCard())
            : controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      SizedBox(
                        height: 46 * 2 + 10,
                        child: GridView.builder(
                          itemCount: controller.filters.length,
                          itemBuilder: (context, index) => _FilterChip(
                            title: controller.filters[index],
                            notificationColor:
                                controller.filterNotificationColor(
                                    controller.filters[index],
                                    Theme.of(context)
                                        .extension<TimeIndicatorColors>()!),
                            isSelected:
                                controller.filters[index] == controller.filter,
                            onTap: controller.onFilterSelected,
                          ),
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 46,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.filteredOptions.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: OptionTile(
                              onTap: () {
                                controller.onOptionTap(
                                    controller.filteredOptions[index].key);
                              },
                              option: controller.filteredOptions[index],
                            ),
                          ),
                          physics: const BouncingScrollPhysics(),
                        ),
                      ),
                    ],
                  );
      }),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.title,
    this.isSelected = false,
    this.onTap,
    this.notificationColor,
  });
  final String title;
  final bool isSelected;
  final ValueChanged<String>? onTap;
  final Color? notificationColor;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          onTap?.call(title);
        },
        child: Stack(
          children: [
            Container(
              height: 46,
              decoration: BoxDecoration(
                color: isSelected ? theme.cardColor : const Color(0xFFF7F8FA),
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              ),
              child: Center(
                  child: Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? const Color(0xFF4E5467)
                      : const Color(0xFF858DA6),
                ),
              )),
            ),
            if (notificationColor != null)
              NotificationDot(color: notificationColor!)
          ],
        ),
      ),
    );
  }
}

class NotificationDot extends StatelessWidget {
  const NotificationDot({
    Key? key,
    required this.color,
  }) : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(4))),
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
    return Consumer<UserProvider>(builder: (context, controller, child) {
      return controller.isLoading
          ? const Text('...')
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.user.driverName,
                ),
                Row(
                  children: [
                    Text(
                      "VIN ${controller.user.vin}",
                      style: subtitleStyle,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Truck #${controller.user.truckNumber}",
                      style: subtitleStyle,
                    )
                  ],
                )
              ],
            );
    });
  }
}

Color colorByProgress(TimeIndicatorColors colors, double progress) {
  if (progress >= 1) {
    return colors.moreThanMonth;
  } else if (progress >= 0.75) {
    return colors.threeQuarters;
  } else if (progress >= .5) {
    return colors.half;
  } else if (progress >= .25) {
    return colors.quarter;
  }
  return colors.zero;
}
