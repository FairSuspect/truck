import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truck/features/doc_option/provider/provider.dart';
import 'package:truck/features/doc_option/view/doc_option_screen.dart';
import 'package:truck/features/main/provider/user_provider.dart';
import 'package:truck/features/main/provider/option_provider.dart';
import 'package:truck/features/main/provider/provider.dart';
import 'package:truck/features/main/services/option_service/mock_service.dart';
import 'package:truck/features/main/services/user_service/mock_service.dart';
import 'package:truck/features/main/view/main_screen.dart';
import 'package:truck/features/sign_in/services/auth_service/mock_service.dart';
import 'package:truck/services/theme/light_theme.dart';

import 'features/sign_in/sign_in.dart';
import 'services/navigation.dart';

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
      navigatorKey: Navigation().key,
      theme: lightTheme,
      initialRoute: SignInScreen.routeName,
      onGenerateRoute: (RouteSettings settings) {
        late final WidgetBuilder builder;
        switch (settings.name) {
          case DocOptionScreen.routeName:
            builder = (context) => Provider(
                create: (context) => DocOptionProvider(),
                child: const DocOptionScreen());
            break;
          case SignInScreen.routeName:
            builder = (context) => ChangeNotifierProvider(
                create: (context) => SignInProvider(MockAuthService()),
                child: const SignInScreen());
            break;
          case MainScreen.routeName:
          default:
            builder = (context) => MultiProvider(providers: [
                  ChangeNotifierProvider(
                      create: (context) => OptionProvider(MockOptionService())),
                  ChangeNotifierProvider(
                      create: (context) => UserProvider(MockUserService())),
                  Provider(create: (context) => MainProvider()),
                ], child: const MainScreen());
        }

        return MaterialPageRoute(builder: builder);
      },
    );
  }
}
