import 'package:truck/features/sign_in/models/credentials.dart';

import 'auth_service.dart';

class MockAuthService implements AuthService {
  @override
  Future<String> signIn(Credentials credentials) async {
    return _allowedCreds.contains(credentials) ? '222' : '';
  }

  static final List<Credentials> _allowedCreds = List.generate(
      9,
      (index) => Credentials(
          mail: (111 * index).toString(), password: (111 * index).toString()));
}
