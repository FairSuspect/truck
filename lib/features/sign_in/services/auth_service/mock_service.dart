import 'package:truck/features/sign_in/models/credentials.dart';

import 'auth_service.dart';

class MockAuthService implements AuthService {
  @override
  Future<bool> signIn(Credentials credentials) async {
    return _allowedCreds.contains(credentials);
  }

  static final List<Credentials> _allowedCreds = List.generate(
      9, (index) => Credentials(driverId: 111 * index, truckId: 111 * index));
}
