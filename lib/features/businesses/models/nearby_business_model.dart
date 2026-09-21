import 'package:bachaoo/features/deals/models/deal_model.dart';
import 'package:bachaoo/features/discounts/models/discount_model.dart';
import 'package:bachaoo/features/home/models/partner_model.dart';

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
    final slug = business.name.toLowerCase().replaceAll(
      RegExp(r'[^a-z0-9]+'),
      '-',
    );
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
      // Prefer the real business logo when present; otherwise fall back to
      // the generated demo avatar so detail screens always show a logo.
      logoUrl:
          business.logoUrl ?? 'https://picsum.photos/seed/$slug-logo/512/512',
      coverImageUrl: 'https://picsum.photos/seed/$slug-cover/1200/600',
    );
  }

  /// Adapts an existing deal for the business/discount explore screen without
  /// replacing any of the deal's visible content.
  factory BusinessModel.fromDeal(DealModel deal) {
    return BusinessModel(
      name: deal.title,
      location: deal.subtitle,
      distanceKm: 0,
      imageUrl: deal.imageUrl,
      coverImageUrl: deal.imageUrl,
      logoUrl: deal.logoUrl,
      discountLabel: deal.badgeLabel ?? '',
      discountSubtitle: deal.subtitle,
      rating: deal.rating,
      isOpenNow: true,
    );
  }

  /// Adapts catalog discount data for the shared business/deal card and
  /// explore screen while keeping its image, label, title, and subtitle.
  factory BusinessModel.fromDiscount(DiscountModel discount) {
    return BusinessModel(
      name: discount.title,
      location: discount.subtitle,
      distanceKm: 0,
      imageUrl: discount.imageUrl,
      coverImageUrl: discount.imageUrl,
      logoUrl: discount.logoUrl,
      discountLabel: discount.discountLabel,
      discountSubtitle: discount.subtitle,
      rating: discount.rating,
      isOpenNow: true,
    );
  }

  /// Adapts a featured home-feed partner into a business for the discount
  /// explore screen with complete header images, logo, and store details.
  factory BusinessModel.fromPartner(PartnerModel partner) {
    return BusinessModel(
      name: partner.title,
      location: partner.subtitle,
      distanceKm: 1.2,
      discountLabel: partner.discountLabel ?? 'Special Offer',
      discountSubtitle: partner.subtitle,
      isFeatured: partner.isFeatured,
      isOpenNow: true,
      imageUrl: partner.imageUrl,
      coverImageUrl: partner.coverImageUrl,
      logoUrl: partner.logoUrl,
      rating: partner.rating ?? 4.8,
      reviewCount: partner.reviewCount ?? 85,
      address: partner.address,
      phoneNumber: partner.phoneNumber ?? '0300 1234567',
      dealsCount: 3,
    );
  }
}
