import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truck/features/main/view/main_screen.dart';
import 'package:truck/services/theme/light_theme.dart';

import 'features/sign_in/sign_in.dart';

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
      home: ChangeNotifierProvider(
        create: (context) => SignInProvider(),
        child: const MainScreen(),
      ),
    );
  }
}
