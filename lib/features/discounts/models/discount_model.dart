class DiscountModel {
  // --- Original fields — unchanged ---
  final String imageUrl;
  final String discountLabel; // e.g. "10% off" or "12%"
  final String title; // e.g. "KFC" or "off your entire bill"
  final String
  subtitle; // e.g. "All buckets & meals" or "Chobara Restaurant · Queen Road"

  // --- Added for the discount view (detail) screen ---
  final String? description; // e.g. "What to expect" paragraph
  final List<String>? tags; // e.g. ["Dine-in", "Cash & card", "Cap Rs 1,500"]
  final String? contactName;
  final String? contactRole;
  final String? contactPhone;
  final String? contactAddress;
  final List<String>? terms;

  // --- Added for the catalog (search/filter/sort) screen ---
  final String? category;
  final double? rating;
  final DateTime? createdAt;
  final int? popularityScore;

  const DiscountModel({
    required this.imageUrl,
    required this.discountLabel,
    required this.title,
    required this.subtitle,
    this.description,
    this.tags,
    this.contactName,
    this.contactRole,
    this.contactPhone,
    this.contactAddress,
    this.terms,
    this.category,
    this.rating,
    this.createdAt,
    this.popularityScore,
  });

  factory DiscountModel.fromJson(Map<String, dynamic> json) {
    return DiscountModel(
      imageUrl: json['image_url'] as String,
      discountLabel: json['discount_label'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      description: json['description'] as String?,
      tags: (json['tags'] as List?)?.cast<String>(),
      contactName: json['contact_name'] as String?,
      contactRole: json['contact_role'] as String?,
      contactPhone: json['contact_phone'] as String?,
      contactAddress: json['contact_address'] as String?,
      terms: (json['terms'] as List?)?.cast<String>(),
      category: json['category'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      popularityScore: json['popularity_score'] as int?,
    );
  }
}
