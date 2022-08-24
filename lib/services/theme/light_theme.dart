import 'package:flutter/material.dart';

final lightTheme = ThemeData(
    // useMaterial3: true,
    primaryColor: _primaryColor,
    backgroundColor: _backgroundColor,
    cardColor: _backgroundAccentColor,
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: _backgroundAccentColor,
      border: InputBorder.none,
      focusColor: _focusBorderColor,
    ),
    disabledColor: const Color(0xFFA0AAC6),
    scaffoldBackgroundColor: _backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: _backgroundColor,
      elevation: 0,
      titleTextStyle: _headlineLargeTextStyle,
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14.0))),
    )),
    colorScheme: ColorScheme.fromSeed(
        onSecondary: _secondaryTextColor,
        seedColor: _primaryColor,
        onBackground: _primaryTextColor,
        secondary: const Color(0xFFF7990D)),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 24 / 16,
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        height: 20 / 12,
      ),
      headlineLarge: _headlineLargeTextStyle,
    ),
    fontFamily: "Gilroy",
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: _backgroundColor,
      elevation: 0,
    ),
    extensions: [
// 00B4AC - больше месяца остается
// 3F8CD6 - остается >= 75%
// F7990D - остается >=50 %
// FF7A68 - остается >= 25 %
// FF0000 - остается >= 0%
      TimeIndicatorColors(
        moreThanMonth: const Color(0xFF00B4Ac),
        threeQuarters: const Color(0xFF3F8CD6),
        half: const Color(0xFFF7990D),
        quarter: const Color(0xFFFF7A68),
        zero: const Color(0xFFFF0000),
      )
    ]);

const Color _primaryColor = Color(0xFF3F8CD6);
const Color _backgroundColor = Color(0xFFFFFFFF);
const Color _backgroundAccentColor = Color(0xFFF7FAFC);

const Color _primaryTextColor = Color(0xFF132A40);
const Color _secondaryTextColor = Color(0xFF4E5467);

const Color _focusBorderColor = Color(0xFFE0E4ED);

const TextStyle _headlineLargeTextStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 24,
  height: 32 / 24,
  color: _primaryTextColor,
);

class TimeIndicatorColors extends ThemeExtension<TimeIndicatorColors> {
  final Color moreThanMonth;
  final Color threeQuarters;
  final Color half;
  final Color quarter;
  final Color zero;

  TimeIndicatorColors({
    required this.moreThanMonth,
    required this.threeQuarters,
    required this.half,
    required this.quarter,
    required this.zero,
  });

  List<Color> get values => [zero, quarter, half, threeQuarters, moreThanMonth];
  @override
  ThemeExtension<TimeIndicatorColors> copyWith({
    Color? moreThanMonth,
    Color? threeQuarters,
    Color? half,
    Color? quarter,
    Color? zero,
  }) =>
      TimeIndicatorColors(
        half: half ?? this.half,
        moreThanMonth: moreThanMonth ?? this.moreThanMonth,
        quarter: quarter ?? this.quarter,
        threeQuarters: threeQuarters ?? this.threeQuarters,
        zero: zero ?? this.zero,
      );

  @override
  ThemeExtension<TimeIndicatorColors> lerp(
      ThemeExtension<TimeIndicatorColors>? other, double t) {
    if (other is! TimeIndicatorColors) {
      return this;
    }
    return TimeIndicatorColors(
      half: Color.lerp(half, other.half, t) ?? half,
      moreThanMonth:
          Color.lerp(moreThanMonth, other.moreThanMonth, t) ?? moreThanMonth,
      quarter: Color.lerp(quarter, other.quarter, t) ?? quarter,
      threeQuarters:
          Color.lerp(threeQuarters, other.threeQuarters, t) ?? threeQuarters,
      zero: Color.lerp(zero, other.zero, t) ?? zero,
    );
  }
}
