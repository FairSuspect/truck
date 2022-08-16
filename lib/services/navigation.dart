import 'package:flutter/widgets.dart';

class Navigation {
  Navigation._();

  static final _instance = Navigation._();

  factory Navigation() => _instance;

  GlobalKey<NavigatorState> key = GlobalKey();
}
