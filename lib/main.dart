import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck/features/doc_option/provider/provider.dart';
import 'package:truck/features/doc_option/view/doc_option_screen.dart';
import 'package:truck/features/main/provider/user_provider.dart';
import 'package:truck/features/main/provider/option_provider.dart';
import 'package:truck/features/main/provider/provider.dart';
import 'package:truck/features/main/services/option_service/stub_service.dart';
import 'package:truck/features/main/view/main_screen.dart';
import 'package:truck/features/oil_status/provider/provider.dart';
import 'package:truck/features/oil_status/service/mock_service.dart';
import 'package:truck/features/qr_code/qr_code.dart';
import 'package:truck/services/theme/light_theme.dart';

import 'features/main/services/user_service/remote_service.dart';
import 'features/qr_code/services/mock_service.dart';
import 'features/sign_in/services/auth_service/auth_service.dart';
import 'features/sign_in/sign_in.dart';
import 'services/navigation.dart';
import 'services/env.dart' as env;

Future<void> main() async {
  await env.Env().init();
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('[${record.loggerName}] (${record.time}): ${record.message}');
  });
  final hasToken = await checkAuth();
  final initialRoute = hasToken ? MainScreen.routeName : SignInScreen.routeName;
  final log = Logger("Splash");
  log.log(Level.INFO, 'Running up with initial route: $initialRoute');
  runApp(MyApp(
    initialRoute: initialRoute,
  ));
}

Future<bool> checkAuth() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authToken');
  final log = Logger("Splash");
  log.log(Level.INFO, 'Auth token: $token');
  return token is String && token.isNotEmpty;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.initialRoute = SignInScreen.routeName});
  final String initialRoute;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Truck documents',
      navigatorKey: Navigation().key,
      theme: lightTheme,
      initialRoute: initialRoute,
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
                create: (context) => SignInProvider(RemoteAuthService()),
                child: const SignInScreen());
            break;
          case MainScreen.routeName:
          default:
            builder = (context) => MultiProvider(providers: [
                  ChangeNotifierProvider(
                      create: (context) => OptionProvider(StubOptionService())),
                  ChangeNotifierProvider(
                      create: (context) => UserProvider(RemoteUserService())),
                  ChangeNotifierProvider(
                      create: (context) => QrCodeProvider(QrMockService())),
                  Provider(
                      create: (context) => OilStatusProvider(MockOilService())),
                  Provider(create: (context) => MainProvider()),
                ], child: const MainScreen());
        }

        return MaterialPageRoute(builder: builder);
      },
    );
  }
}
