import 'package:flutter/widgets.dart';
import 'package:truck/features/main/models/user.dart';
import 'package:truck/features/main/services/user_service/user_service.dart';

class UserProvider with ChangeNotifier {
  late User user;

  final UserService service;

  UserProvider(this.service) {
    getUser();
  }

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future<void> getUser() async {
    isLoading = true;
    user = await service.getUser();
    isLoading = false;
  }
}
