class PartnerModel {
  final String title;
  final String subtitle;
  final String videoUrl;
  final bool isFeatured;

  const PartnerModel({
    required this.title,
    required this.subtitle,
    required this.videoUrl,
    this.isFeatured = false,
  });

  factory PartnerModel.fromJson(Map<String, dynamic> json) {
    return PartnerModel(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      videoUrl: json['video_url'] as String,
      isFeatured: json['is_featured'] as bool? ?? false,
    );
  }
}
