import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck/features/sign_in/sign_in.dart';
import 'package:truck/services/navigation.dart';

class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final log = Logger('DioError');
    log.log(Level.WARNING,
        "Error intercepted. Request path: ${err.requestOptions.path}. Status code: ${err.response?.statusCode}. Message: ${err.response?.data}");
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      Navigation()
          .key
          .currentState!
          .popUntil((route) => !Navigation().key.currentState!.canPop());
      Navigation()
          .key
          .currentState!
          .pushReplacementNamed(SignInScreen.routeName);
      log.log(Level.WARNING, "Unauthorized request. Redirecting to auth page");
    }
    super.onError(err, handler);
  }

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final prefs = await SharedPreferences.getInstance();
    final logger = Logger('Dio');
    options.headers['Cookie'] = prefs.getString('authToken');
    logger.log(Level.INFO,
        "Making ${options.method} request (${options.path}) with cookie: ${options.headers['Cookie']}");
    super.onRequest(options, handler);
  }
}
