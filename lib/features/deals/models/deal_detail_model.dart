import 'package:bachaoo/features/deals/models/deal_model.dart';

/// Full data needed by the deal explore screen
/// (`features/deals/views/screens/explore_deal_screen.dart`).
class DealDetailModel {
  final String title; // e.g. "Bachaoo Deal 1"
  final String businessName; // e.g. "Dhuaan N Dhukan"
  final String location; // e.g. "Satellite Town"
  final String? imageUrl; // header image
  final String saveLabel; // e.g. "Save Rs 150"
  final double price; // current deal price
  final double originalPrice; // price before discount
  final String discountPercentLabel; // e.g. "31% less"
  final List<String> includedItems;
  final List<String> claimSteps;
  final String contactName;
  final String contactRole;
  final String contactPhone;
  final String contactAddress;
  final List<String> terms;

  const DealDetailModel({
    required this.title,
    required this.businessName,
    required this.location,
    this.imageUrl,
    required this.saveLabel,
    required this.price,
    required this.originalPrice,
    required this.discountPercentLabel,
    required this.includedItems,
    required this.claimSteps,
    required this.contactName,
    required this.contactRole,
    required this.contactPhone,
    required this.contactAddress,
    required this.terms,
  });

  factory DealDetailModel.fromJson(Map<String, dynamic> json) {
    return DealDetailModel(
      title: json['title'] as String,
      businessName: json['business_name'] as String,
      location: json['location'] as String,
      imageUrl: json['image_url'] as String?,
      saveLabel: json['save_label'] as String,
      price: (json['price'] as num).toDouble(),
      originalPrice: (json['original_price'] as num).toDouble(),
      discountPercentLabel: json['discount_percent_label'] as String,
      includedItems: (json['included_items'] as List?)?.cast<String>() ?? const <String>[],
      claimSteps: (json['claim_steps'] as List?)?.cast<String>() ?? const <String>[],
      contactName: json['contact_name'] as String,
      contactRole: json['contact_role'] as String,
      contactPhone: json['contact_phone'] as String,
      contactAddress: json['contact_address'] as String,
      terms: (json['terms'] as List?)?.cast<String>() ?? const <String>[],
    );
  }

  // --- Dummy fallback data -------------------------------------------------
  // Compact home cards don't carry the detail fields, so when they're missing
  // we fill the explore screen sections with dummy data instead of leaving
  // "What's included / How to claim / Contact / Terms" empty.
  static const List<String> fallbackIncludedItems = [
    '300g Dhuaan rice',
    '2 chicken tikka',
    'Maghoolta',
    '345ml drink',
  ];
  static const List<String> fallbackClaimSteps = [
    'Scan the Bachaoo QR at the counter, or add this deal to your cart.',
    'Ask staff for the 4-digit business code.',
    'Enter it, pay the discounted amount.',
  ];
  static const String fallbackContactName = 'Naveed Anwar';
  static const String fallbackContactRole = 'CEO';
  static const String fallbackContactPhone = '0304 7665454';
  static const String fallbackContactAddress =
      'Main Zafar Ullah Chowk, Satellite Town, Sargodha';
  static const List<String> fallbackTerms = [
    'Credit is not allowed for Bachaoo members.',
    'Membership must be shown and verified at billing.',
    'Cannot be combined with other offers.',
    'Dine‑in and takeaway only.',
  ];

  /// Builds a full explore-screen deal from the compact home-card [DealModel],
  /// parsing the free-form price strings the same way as
  /// [DealModel.discountPercentLabel]. Detail sections fall back to the
  /// dummy data above when the home card doesn't provide them.
  factory DealDetailModel.fromDealModel(DealModel deal) {
    final current = _parsePrice(deal.currentPrice);
    final original = _parsePrice(deal.originalPrice);
    final isDiscounted =
        current != null && original != null && original > current;
    final location = deal.subtitle.contains('·')
        ? deal.subtitle.substring(deal.subtitle.indexOf('·') + 1).trim()
        : deal.subtitle;
    return DealDetailModel(
      title: deal.title,
      businessName: deal.brandTag,
      location: location,
      imageUrl: deal.imageUrl,
      saveLabel: isDiscounted
          ? 'Save Rs ${(original - current).toStringAsFixed(0)}'
          : 'Save',
      price: current ?? 0,
      originalPrice: original ?? (current ?? 0) + 100,
      discountPercentLabel: deal.discountPercentLabel ?? '',
      includedItems: deal.includedItems ?? fallbackIncludedItems,
      claimSteps: deal.claimSteps ?? fallbackClaimSteps,
      contactName: deal.contactName ?? fallbackContactName,
      contactRole: deal.contactRole ?? fallbackContactRole,
      contactPhone: deal.contactPhone ?? fallbackContactPhone,
      contactAddress: deal.contactAddress ?? fallbackContactAddress,
      terms: deal.terms ?? fallbackTerms,
    );
  }

  static double? _parsePrice(String value) {
    final cleaned = value.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned);
  }
}