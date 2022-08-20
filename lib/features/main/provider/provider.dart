import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck/features/sign_in/view/view.dart';
import 'package:truck/services/navigation.dart';
import 'package:truck/services/notifications.dart' as notifications;

class MainProvider {
  void logOut() {
    Navigation()
        .key
        .currentState!
        .popUntil((route) => !Navigation().key.currentState!.canPop());
    Navigation().key.currentState!.pushReplacementNamed(SignInScreen.routeName);
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('authToken', '');
    });

    disableNotifications();
  }

  void disableNotifications() {
    notifications.flutterLocalNotificationsPlugin.cancelAll();
  }
}
