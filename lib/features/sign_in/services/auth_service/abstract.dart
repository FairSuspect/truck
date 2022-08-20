import 'package:truck/features/sign_in/models/credentials.dart';

abstract class AuthService {
  Future<String> signIn(Credentials credentials);
}
