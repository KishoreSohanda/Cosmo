import 'package:dio/dio.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../models/apod_model.dart';

class ApodRepository {
  final Dio _dio;

  ApodRepository({Dio? dio}) : _dio = dio ?? DioClient.instance;

  Future<List<ApodModel>> fetchApodList({int days = 7}) async {
    final endDate = DateTime.now().toUtc();
    final startDate = endDate.subtract(Duration(days: days - 1));

    final response = await _dio.get(
      '${ApiEndpoints.nasaBaseUrl}${ApiEndpoints.apod}',
      queryParameters: {
        'start_date': _formatDate(startDate),
        'end_date': _formatDate(endDate),
      },
    );

    final data = response.data;

    if (data is! List) {
      throw const FormatException('Unexpected APOD API response format.');
    }

    return data
        .whereType<Map<String, dynamic>>()
        .map(ApodModel.fromJson)
        .toList()
        .where((apod) => apod.mediaType == 'image')
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  Future<ApodModel> fetchApodByDate(String date) async {
    final response = await _dio.get(
      '${ApiEndpoints.nasaBaseUrl}${ApiEndpoints.apod}',
      queryParameters: {'date': date},
    );

    if (response.data is! Map<String, dynamic>) {
      throw const FormatException('Unexpected APOD detail response format.');
    }

    return ApodModel.fromJson(response.data as Map<String, dynamic>);
  }

  String _formatDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }
}
