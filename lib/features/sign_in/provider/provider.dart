import 'package:flutter/widgets.dart';
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
      Credentials(
          driverId: int.tryParse(driverId) ?? 0,
          truckId: int.tryParse(truckId) ?? 0),
    );
    if (!auth) {
      print("failed");
      return;
    }
    Navigation().key.currentState!.pushReplacementNamed(MainScreen.routeName);
  }
}
