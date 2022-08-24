import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:truck/services/remote/interceptors.dart';

class DioFactory {
  DioFactory._();

  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env["API_DOMAIN"] ?? dotenv.env["DOMAIN"]!,
        receiveTimeout: 15000, // 15 seconds
        connectTimeout: 15000,
        sendTimeout: 15000,
      ),
    );
    dio.interceptors.add(AppInterceptors(dio));
    return dio;
  }
}
