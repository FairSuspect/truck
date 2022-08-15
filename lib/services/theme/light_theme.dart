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
  colorScheme: ColorScheme.fromSeed(seedColor: _primaryColor),
);

const Color _primaryColor = Color(0xFF3F8CD6);
const Color _backgroundColor = Color(0xFFFFFFFF);
const Color _backgroundAccentColor = Color(0xFFF7FAFC);

const Color _focusBorderColor = Color(0xFFE0E4ED);
