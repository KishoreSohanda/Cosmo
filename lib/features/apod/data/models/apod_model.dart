class ApodModel {
  final String title;
  final String date;
  final String explanation;
  final String imageUrl;
  final String thumbnailUrl;
  final String mediaType;
  final String? copyright;
  final String? imageDescription;
  final String? articleUrl;

  const ApodModel({
    required this.title,
    required this.date,
    required this.explanation,
    required this.imageUrl,
    required this.thumbnailUrl,
    required this.mediaType,
    this.copyright,
    this.imageDescription,
    this.articleUrl,
  });

  factory ApodModel.fromJson(Map<String, dynamic> json) {
    final imageUrl = json['hdurl'] as String? ?? json['url'] as String? ?? '';

    return ApodModel(
      title: json['title'] as String? ?? '',
      date: json['date'] as String? ?? '',
      explanation: json['explanation'] as String? ?? '',
      imageUrl: imageUrl,
      thumbnailUrl: _buildThumbnailUrl(imageUrl),
      mediaType: json['media_type'] as String? ?? 'image',
      copyright: json['copyright'] as String?,
      imageDescription: json['alt'] as String?,
      articleUrl: json['permalink'] as String? ?? json['url'] as String?,
    );
  }

  static String _buildThumbnailUrl(String imageUrl) {
    if (imageUrl.isEmpty) return '';

    final uri = Uri.tryParse(imageUrl);
    if (uri == null ||
        uri.host != 'assets.science.nasa.gov' ||
        !uri.path.contains('/dynamicimage/')) {
      return imageUrl;
    }

    return uri
        .replace(
          queryParameters: {
            ...uri.queryParameters,
            'w': '400',
            'h': '500',
            'fit': 'clip',
          },
        )
        .toString();
  }
}
