import 'package:truck/features/main/models/user.dart';

import 'user_service.dart';

class MockUserService implements UserService {
  @override
  Future<User> getUser() async {
    await Future.delayed(const Duration(seconds: 1));
    return const User(driverId: 111, truckId: 222, name: "Davy Jones");
  }
}
