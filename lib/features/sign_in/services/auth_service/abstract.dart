import 'package:truck/features/sign_in/models/credentials.dart';

abstract class AuthService {
  Future<bool> signIn(Credentials credentials);
}
