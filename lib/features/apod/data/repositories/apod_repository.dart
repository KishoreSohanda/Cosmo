import 'package:dio/dio.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../models/apod_model.dart';

class ApodPageResult {
  final List<ApodModel> apods;
  final int totalPages;

  const ApodPageResult({required this.apods, required this.totalPages});
}

class ApodRepository {
  final Dio _dio;

  ApodRepository({Dio? dio}) : _dio = dio ?? DioClient.instance;

  Future<ApodPageResult> fetchApodList({int page = 1, int limit = 10}) async {
    final response = await _dio.get(
      '${ApiEndpoints.nasaBaseUrl}${ApiEndpoints.apod}',
      queryParameters: {'per_page': limit, 'page': page},
    );

    final data = response.data;

    if (data is! List) {
      throw const FormatException('Unexpected APOD API response format.');
    }

    final apods =
        data
            .whereType<Map<String, dynamic>>()
            .map(ApodModel.fromJson)
            .where((apod) => apod.mediaType == 'image')
            .toList()
          ..sort((a, b) => b.date.compareTo(a.date));

    final totalPages =
        int.tryParse(response.headers.value('x-wp-totalpages') ?? '') ?? page;

    return ApodPageResult(apods: apods, totalPages: totalPages);
  }
}
