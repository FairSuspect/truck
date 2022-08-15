import 'package:flutter/material.dart';
import 'package:truck/features/sign_in/view/view.dart';
import 'package:truck/services/theme/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      home: const SignInScreen(),
    );
  }
}
