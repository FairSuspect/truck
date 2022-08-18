import 'package:dio/dio.dart';

class DioService {
  final Dio dio = Dio();

  static final DioService _instance = DioService._();

  DioService._();

  factory DioService() => _instance;
}
