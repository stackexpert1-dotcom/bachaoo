class PromoModel {
  final String imageUrl;
  final String? badgeText; // e.g. "Members only" — top-left pill
  final String? brandName; // e.g. "McDonald's" — top-right pill
  final String? subtitle; // e.g. "McDonald's · Sargodha"
  final String? offerTitle; // e.g. "15% off every meal"

  const PromoModel({
    required this.imageUrl,
    this.badgeText,
    this.brandName,
    this.subtitle,
    this.offerTitle,
  });

  factory PromoModel.fromJson(Map<String, dynamic> json) {
    return PromoModel(
      imageUrl: json['image_url'] as String,
      badgeText: json['badge_text'] as String?,
      brandName: json['brand_name'] as String?,
      subtitle: json['subtitle'] as String?,
      offerTitle: json['offer_title'] as String?,
    );
  }
}
