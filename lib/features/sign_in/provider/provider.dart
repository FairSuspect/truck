import 'package:flutter/widgets.dart';

class SignInProvider extends ChangeNotifier {
  String driverId = '';
  String truckId = '';

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

  void logIn() {
    print("Logging in with $driverId and $truckId");
  }
}
