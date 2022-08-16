import 'package:flutter/material.dart';

final lightTheme = ThemeData(
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
  colorScheme: ColorScheme.fromSeed(
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
);

const Color _primaryColor = Color(0xFF3F8CD6);
const Color _backgroundColor = Color(0xFFFFFFFF);
const Color _backgroundAccentColor = Color(0xFFF7FAFC);

const Color _primaryTextColor = Color(0xFF132A40);

const Color _focusBorderColor = Color(0xFFE0E4ED);

const TextStyle _headlineLargeTextStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 24,
  height: 32 / 24,
  color: _primaryTextColor,
);
