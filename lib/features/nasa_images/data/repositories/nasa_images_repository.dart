import 'package:dio/dio.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../models/nasa_image_model.dart';

class NasaImagesPageResult {
  final List<NasaImageModel> images;
  final int totalHits;

  const NasaImagesPageResult({required this.images, required this.totalHits});
}

class NasaImagesRepository {
  final Dio _dio;

  NasaImagesRepository({Dio? dio}) : _dio = dio ?? DioClient.instance;

  Future<NasaImagesPageResult> fetchImages({
    String query = 'space',
    int page = 1,
    int limit = 20,
  }) async {
    final response = await _dio.get(
      '${ApiEndpoints.nasaImagesBaseUrl}${ApiEndpoints.nasaImagesSearch}',
      queryParameters: {
        'q': query,
        'media_type': 'image',
        'page': page,
        'page_size': limit,
      },
    );

    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw const FormatException('Unexpected NASA Images response format.');
    }

    final collection = data['collection'] as Map<String, dynamic>?;

    final items = collection?['items'] as List<dynamic>? ?? [];
    final metadata = collection?['metadata'] as Map<String, dynamic>? ?? {};

    final images = items
        .whereType<Map<String, dynamic>>()
        .map(NasaImageModel.fromJson)
        .where(
          (image) => image.nasaId.isNotEmpty && image.thumbnailUrl.isNotEmpty,
        )
        .toList();

    return NasaImagesPageResult(
      images: images,
      totalHits: metadata['total_hits'] as int? ?? images.length,
    );
  }
}
