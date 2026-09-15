import 'dart:ui';

class DealModel {
  // --- Original fields — unchanged ---
  final String imageUrl;
  final String badgeLabel;
  final String brandTag;
  final String title;
  final String subtitle;
  final String currentPrice;
  final String originalPrice;
  final String currency;
  final bool showOnHome;
  final int? homePriority;
  final Color? brandColor;

  // --- Added for the full explore screen ---
  final List<String>? includedItems;
  final List<String>? claimSteps;
  final String? contactName;
  final String? contactRole;
  final String? contactPhone;
  final String? contactAddress;
  final List<String>? terms;

  /// Short brand tag for the badge on the image — 3 letters max (e.g. "KFC", "DD" stays "DD").
  String get brandTagShort {
    if (brandTag.length <= 3) return brandTag.toUpperCase();
    return brandTag.substring(0, 3).toUpperCase();
  }

  /// Computed from currentPrice/originalPrice, not stored — since both
  /// are free-form strings (may contain commas, currency symbols),
  /// non-numeric characters are stripped before parsing. Returns null
  /// when there's nothing sensible to show (unparsable, or no discount).
  String? get discountPercentLabel {
    final current = _parsePrice(currentPrice);
    final original = _parsePrice(originalPrice);
    if (current == null || original == null) return null;
    if (original <= 0 || current >= original) return null;
    final percent = (((original - current) / original) * 100).round();
    return '$percent% less';
  }

  static double? _parsePrice(String value) {
    final cleaned = value.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned);
  }

  const DealModel({
    required this.imageUrl,
    required this.badgeLabel,
    required this.brandTag,
    required this.title,
    required this.subtitle,
    required this.currentPrice,
    required this.originalPrice,
    this.currency = 'Rs',
    this.showOnHome = false,
    this.homePriority,
    this.brandColor,
    this.includedItems,
    this.claimSteps,
    this.contactName,
    this.contactRole,
    this.contactPhone,
    this.contactAddress,
    this.terms,
  });

  factory DealModel.fromJson(Map<String, dynamic> json) {
    return DealModel(
      imageUrl: json['image_url'] as String,
      badgeLabel: json['badge_label'] as String,
      brandTag: json['brand_tag'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      currentPrice: json['current_price'] as String,
      originalPrice: json['original_price'] as String,
      currency: json['currency'] as String? ?? 'Rs',
      showOnHome: json['show_on_home'] as bool? ?? false,
      homePriority: json['home_priority'] as int?,
      // Was `json['brand_color'] as Color?` — JSON has no Color type,
      // so that cast would throw at runtime. Parsed from a hex string
      // instead, same as your other models' color fields.
      brandColor: _colorFromHex(json['brand_color'] as String?),
      includedItems: (json['included_items'] as List?)?.cast<String>(),
      claimSteps: (json['claim_steps'] as List?)?.cast<String>(),
      contactName: json['contact_name'] as String?,
      contactRole: json['contact_role'] as String?,
      contactPhone: json['contact_phone'] as String?,
      contactAddress: json['contact_address'] as String?,
      terms: (json['terms'] as List?)?.cast<String>(),
    );
  }

  // Expects hex like "#B33A2E" or "B33A2E"; returns null for null/empty input.
  static Color? _colorFromHex(String? hex) {
    if (hex == null || hex.isEmpty) return null;
    final cleaned = hex.replaceFirst('#', '');
    return Color(int.parse('FF$cleaned', radix: 16));
  }
}
