class PartnerModel {
  final String title;
  final String subtitle;
  final String videoUrl;
  final bool isFeatured;
  final String? imageUrl;
  final String? coverImageUrl;
  final String? logoUrl;
  final double? rating;
  final int? reviewCount;
  final String? address;
  final String? phoneNumber;
  final String? discountLabel;

  const PartnerModel({
    required this.title,
    required this.subtitle,
    required this.videoUrl,
    this.isFeatured = false,
    this.imageUrl,
    this.coverImageUrl,
    this.logoUrl,
    this.rating,
    this.reviewCount,
    this.address,
    this.phoneNumber,
    this.discountLabel,
  });

  factory PartnerModel.fromJson(Map<String, dynamic> json) {
    return PartnerModel(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      videoUrl: json['video_url'] as String,
      isFeatured: json['is_featured'] as bool? ?? false,
      imageUrl: json['image_url'] as String?,
      coverImageUrl: json['cover_image_url'] as String?,
      logoUrl: json['logo_url'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      reviewCount: json['review_count'] as int?,
      address: json['address'] as String?,
      phoneNumber: json['phone_number'] as String?,
      discountLabel: json['discount_label'] as String?,
    );
  }
}
