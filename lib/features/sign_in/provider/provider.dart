import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:truck/features/shared/view/snackbars.dart';
import 'package:truck/features/sign_in/models/credentials.dart';
import 'package:truck/features/sign_in/services/auth_service/auth_service.dart';
import 'package:truck/features/main/view/main_screen.dart';
import 'package:truck/services/navigation.dart';
import 'package:truck/services/notifications.dart' as notifications;

class SignInProvider extends ChangeNotifier {
  String driverId = '';
  String truckId = '';

  final AuthService service;

  SignInProvider(this.service);

  void onTruckIdChanged(String? value) {
    if (value == null) {
      truckId = '';
    } else {
      truckId = value;
    }
    notifyListeners();
  }

  void onDriverIdChanged(String? value) {
    if (value == null) {
      driverId = '';
    } else {
      driverId = value;
    }
    notifyListeners();
  }

  bool get buttonAvailable => truckId.isNotEmpty && driverId.isNotEmpty;

  VoidCallback? get onLogInPressed => buttonAvailable ? logIn : null;

  Future<void> logIn() async {
    late final String auth;
    try {
      auth = await service.signIn(
        Credentials(mail: driverId, password: truckId),
      );
      if (auth.isEmpty) {
        Logger('Auth').log(Level.WARNING, "Failed to auth");
        return;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        Navigation().scaffoldKey.currentState!.showSnackBar(SnackBars.info(
            e.response?.data['detail'] ?? "Incorrect email or password"));
      }
      Logger('Auth').log(Level.WARNING, "Remote reported failt auth");

      return;
    }
    final prefs = await SharedPreferences.getInstance();
    Navigation().key.currentState!.pushReplacementNamed(MainScreen.routeName);
    prefs.setString('authToken', auth);

    _showNotification();
    _configureWeeklyReminder();
  }

  void _configureWeeklyReminder() {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('truckMileage', 'Truck mileage reminder',
            channelDescription: 'Remind to send mileage every week');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    notifications.flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      'Mileage',
      'Do not forget to send one',
      RepeatInterval.weekly,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('truckMileage', 'Truck mileage reminder',
            channelDescription: 'Remind to send mileage every week',
            importance: Importance.defaultImportance,
            priority: Priority.defaultPriority,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await notifications.flutterLocalNotificationsPlugin.show(
      0,
      'Mileage',
      'Do not forget to send one',
      platformChannelSpecifics,
    );
  }
}
