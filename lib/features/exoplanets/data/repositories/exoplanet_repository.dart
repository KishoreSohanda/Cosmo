import 'package:dio/dio.dart';

import '../../../../core/network/api_endpoints.dart';
import '../models/exoplanet_model.dart';

class ExoplanetRepository {
  final Dio _dio;

  ExoplanetRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<List<ExoplanetModel>> fetchExoplanets({
    int limit = 10,
    String? afterPlanetName,
  }) async {
    final cursorCondition = afterPlanetName == null
        ? ''
        : " where pl_name > '${afterPlanetName.replaceAll("'", "''")}'";

    final response = await _dio.get(
      '${ApiEndpoints.exoplanetBaseUrl}${ApiEndpoints.exoplanetQuery}',
      queryParameters: {
        'query':
            'select top $limit * from pscomppars'
            '$cursorCondition order by pl_name',
        'format': 'json',
      },
    );

    final data = response.data;

    if (data is! List) {
      throw const FormatException(
        'Unexpected response from the Exoplanet Archive.',
      );
    }

    return data
        .whereType<Map<String, dynamic>>()
        .map(ExoplanetModel.fromJson)
        .toList();
  }
}
