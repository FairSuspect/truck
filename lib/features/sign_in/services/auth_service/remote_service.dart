import 'package:truck/features/sign_in/models/credentials.dart';
import 'package:truck/features/sign_in/services/auth_service/auth_service.dart';
import 'package:truck/services/remote/api.dart';

class RemoteAuthService implements AuthService {
  @override
  Future<String> signIn(Credentials credentials) async {
    final dio = Api().dio;

    final response = await dio.post('/driver/driver-login/', data: credentials);
    final authCookie = response.headers['set-cookie']!;
    String auth = '';
    for (var cookie in authCookie) {
      auth += cookie.substring(0, cookie.indexOf(';'));
      auth += '; ';
    }
    auth.trimRight();
    return auth;
  }
}
