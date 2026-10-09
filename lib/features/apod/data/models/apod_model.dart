class ApodModel {
  final String title;
  final String date;
  final String explanation;
  final String imageUrl;
  final String mediaType;
  final String? copyright;
  final String? imageDescription;

  const ApodModel({
    required this.title,
    required this.date,
    required this.explanation,
    required this.imageUrl,
    required this.mediaType,
    this.copyright,
    this.imageDescription,
  });

  factory ApodModel.fromJson(Map<String, dynamic> json) {
    return ApodModel(
      title: json['title'] as String? ?? '',
      date: json['date'] as String? ?? '',
      explanation: json['explanation'] as String? ?? '',
      imageUrl: json['hdurl'] as String? ?? json['image_url'] as String? ?? '',
      mediaType: json['media_type'] as String? ?? 'image',
      copyright: json['copyright'] as String?,
      imageDescription: json['alt'] as String?,
    );
  }
}
