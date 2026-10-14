class NasaImageModel {
  final String nasaId;
  final String title;
  final String description;
  final String accessibleDescription;
  final String dateCreated;
  final String mediaType;

  final String thumbnailUrl;
  final String smallImageUrl;
  final String mediumImageUrl;
  final String originalImageUrl;
  final String assetManifestUrl;

  final String? center;
  final String? photographer;
  final String? secondaryCreator;
  final List<String> keywords;

  const NasaImageModel({
    required this.nasaId,
    required this.title,
    required this.description,
    required this.accessibleDescription,
    required this.dateCreated,
    required this.mediaType,
    required this.thumbnailUrl,
    required this.smallImageUrl,
    required this.mediumImageUrl,
    required this.originalImageUrl,
    required this.assetManifestUrl,
    this.center,
    this.photographer,
    this.secondaryCreator,
    this.keywords = const [],
  });

  factory NasaImageModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as List<dynamic>? ?? [];

    final metadata = data.isNotEmpty && data.first is Map<String, dynamic>
        ? data.first as Map<String, dynamic>
        : <String, dynamic>{};

    final links = (json['links'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .toList();

    String findImageUrl(String relation) {
      for (final link in links) {
        if (link['rel'] == relation &&
            link['render'] == 'image' &&
            link['href'] is String) {
          return link['href'] as String;
        }
      }

      return '';
    }

    final thumbnailUrl = findImageUrl('preview');
    final originalImageUrl = findImageUrl('canonical');
    final alternateUrls = links
        .where(
          (link) =>
              link['rel'] == 'alternate' &&
              link['render'] == 'image' &&
              link['href'] is String,
        )
        .toList();

    String alternateUrlContaining(String size) {
      for (final link in alternateUrls) {
        if ((link['href'] as String).contains('~$size.')) {
          return link['href'] as String;
        }
      }

      return '';
    }

    return NasaImageModel(
      nasaId: metadata['nasa_id'] as String? ?? '',
      title: metadata['title'] as String? ?? 'Untitled image',
      description: metadata['description'] as String? ?? '',
      accessibleDescription: metadata['description_508'] as String? ?? '',
      dateCreated: metadata['date_created'] as String? ?? '',
      mediaType: metadata['media_type'] as String? ?? 'image',
      thumbnailUrl: thumbnailUrl,
      smallImageUrl: alternateUrlContaining('small'),
      mediumImageUrl: alternateUrlContaining('medium'),
      originalImageUrl: originalImageUrl,
      assetManifestUrl: json['href'] as String? ?? '',
      center: metadata['center'] as String?,
      photographer: metadata['photographer'] as String?,
      secondaryCreator: metadata['secondary_creator'] as String?,
      keywords: (metadata['keywords'] as List<dynamic>? ?? [])
          .whereType<String>()
          .toList(),
    );
  }

  NasaImageModel copyWith({
    String? thumbnailUrl,
    String? smallImageUrl,
    String? mediumImageUrl,
    String? originalImageUrl,
    String? photographer,
  }) {
    return NasaImageModel(
      nasaId: nasaId,
      title: title,
      description: description,
      accessibleDescription: accessibleDescription,
      dateCreated: dateCreated,
      mediaType: mediaType,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      smallImageUrl: smallImageUrl ?? this.smallImageUrl,
      mediumImageUrl: mediumImageUrl ?? this.mediumImageUrl,
      originalImageUrl: originalImageUrl ?? this.originalImageUrl,
      assetManifestUrl: assetManifestUrl,
      center: center,
      photographer: photographer,
      secondaryCreator: secondaryCreator,
      keywords: keywords,
    );
  }
}
