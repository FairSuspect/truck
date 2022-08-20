import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck/features/sign_in/models/credentials.dart';
import 'package:truck/features/sign_in/services/auth_service/auth_service.dart';
import 'package:truck/features/main/view/main_screen.dart';
import 'package:truck/services/navigation.dart';

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
  }
}
