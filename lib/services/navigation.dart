import 'package:flutter/material.dart';

class Navigation {
  Navigation._();

  static final _instance = Navigation._();

  factory Navigation() => _instance;

  GlobalKey<NavigatorState> key = GlobalKey();
  GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey();
}
