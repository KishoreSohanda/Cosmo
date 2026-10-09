import 'package:dio/dio.dart';

class DioClient {
  DioClient._();

  static late final Dio instance;

  static void initialize() {
    instance = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: {'Accept': 'application/json'},
      ),
    );
  }
}
