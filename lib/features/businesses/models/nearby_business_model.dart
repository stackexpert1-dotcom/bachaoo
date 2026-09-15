class BusinessModel {
  // --- Fields from the "Near you" card ---
  final String name;
  final String location;
  final double distanceKm;
  final String? imageUrl;
  final bool isNew; // shows "New" instead of a rating
  final double? rating; // null when isNew is true
  final int? reviewCount; // e.g. 12 → shown as "(12)"
  final String discountLabel; // e.g. "15%"
  final String discountSubtitle; // e.g. "off bill"
  final bool isFeatured; // admin-controlled: show in "Near you" or not

  // --- Fields added for the business detail screen ---
  final String?
  address; // full address, e.g. "Zafarullah Chowk, Block A, Old Satellite Town"
  final String? coverImageUrl; // large header banner on the detail screen
  final String? logoUrl; // small square avatar shown in the detail info card
  final bool isOpenNow;
  final int? dealsCount; // e.g. 3 → shown as "3 deals"
  final String? phoneNumber;

  const BusinessModel({
    required this.name,
    required this.location,
    required this.distanceKm,
    this.imageUrl,
    this.isNew = false,
    this.rating,
    this.reviewCount,
    required this.discountLabel,
    required this.discountSubtitle,
    this.isFeatured = false,
    this.address,
    this.coverImageUrl,
    this.logoUrl,
    this.isOpenNow = false,
    this.dealsCount,
    this.phoneNumber,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      name: json['name'] as String,
      location: json['location'] as String,
      distanceKm: (json['distance_km'] as num).toDouble(),
      imageUrl: json['image_url'] as String?,
      isNew: json['is_new'] as bool? ?? false,
      rating: (json['rating'] as num?)?.toDouble(),
      reviewCount: json['review_count'] as int?,
      discountLabel: json['discount_label'] as String,
      discountSubtitle: json['discount_subtitle'] as String,
      isFeatured: json['is_featured'] as bool? ?? false,
      address: json['address'] as String?,
      coverImageUrl: json['cover_image_url'] as String?,
      logoUrl: json['logo_url'] as String?,
      isOpenNow: json['is_open_now'] as bool? ?? false,
      dealsCount: json['deals_count'] as int?,
      phoneNumber: json['phone_number'] as String?,
    );
  }

  /// Demo helper: the list ("partners") cards only carry the compact fields,
  /// so this fills in the detail-screen fields (cover image, logo, phone,
  /// deals, open status) before a business is pushed to the explore screen.
  factory BusinessModel.forDetailDemo(BusinessModel business) {
    final slug = business.name
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-');
    return BusinessModel(
      name: business.name,
      location: business.location,
      distanceKm: business.distanceKm,
      imageUrl: business.imageUrl,
      isNew: business.isNew,
      rating: business.rating,
      reviewCount: business.reviewCount,
      discountLabel: business.discountLabel,
      discountSubtitle: business.discountSubtitle,
      isFeatured: business.isFeatured,
      isOpenNow: true,
      dealsCount: 3,
      phoneNumber: '03195006813',
      coverImageUrl: 'https://picsum.photos/seed/$slug-cover/1200/600',
      logoUrl: 'https://picsum.photos/seed/$slug-logo/512/512',
    );
  }
}
