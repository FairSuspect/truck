import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck/features/main/provider/user_provider.dart';
import 'package:truck/features/main/provider/option_provider.dart';
import 'package:truck/features/main/provider/provider.dart';
import 'package:truck/features/main/services/option_service/stub_service.dart';
import 'package:truck/features/main/services/user_service/user_service.dart';
import 'package:truck/features/main/view/main_screen.dart';
import 'package:truck/features/oil_status/provider/provider.dart';
import 'package:truck/features/oil_status/service/mock_service.dart';
import 'package:truck/features/qr_code/qr_code.dart';
import 'package:truck/services/theme/light_theme.dart';

import 'features/main/services/option_service/option_service.dart';
import 'features/qr_code/services/qr_code_service.dart';
import 'features/sign_in/services/auth_service/auth_service.dart';
import 'features/sign_in/sign_in.dart';
import 'services/navigation.dart';
import 'services/notifications.dart' as notifications;
import 'services/env.dart' as env;

Future<void> main() async {
  await env.Env().init();
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    // ignore: avoid_print
    print('[${record.loggerName}] (${record.time}): ${record.message}');
  });
  await Future.delayed(Duration(seconds: 3));

  final hasToken = await checkAuth();
  final initialRoute = hasToken ? MainScreen.routeName : SignInScreen.routeName;
  final log = Logger("Splash");
  log.log(Level.INFO, 'Running up with initial route: $initialRoute');
  WidgetsFlutterBinding.ensureInitialized();
  notifications.Notifications().init();
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
      scaffoldMessengerKey: Navigation().scaffoldKey,
      theme: lightTheme,
      initialRoute: initialRoute,
      onGenerateRoute: (RouteSettings settings) {
        late final WidgetBuilder builder;
        switch (settings.name) {
          case SignInScreen.routeName:
            builder = (context) => ChangeNotifierProvider(
                create: (context) => SignInProvider(RemoteAuthService()),
                child: const SignInScreen());
            break;
          case MainScreen.routeName:
          default:
            builder = (context) => MultiProvider(providers: [
                  ChangeNotifierProvider(
                      create: (context) =>
                          OptionProvider(RemoteOptionService())),
                  ChangeNotifierProvider(
                      create: (context) => UserProvider(RemoteUserService())),
                  ChangeNotifierProvider(
                      create: (context) => QrCodeProvider(RemoteQrService())),
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
