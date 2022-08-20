import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
    final auth = await service.signIn(
      Credentials(mail: driverId, password: truckId),
    );
    if (auth.isEmpty) {
      print("failed");
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
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
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
