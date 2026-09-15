import 'package:flutter/material.dart';

/// Whether a voucher's amount block should be rendered as a priced
/// voucher (primary green block, white text) or a free perk
/// (secondary gold block, primary text).
enum VoucherType { price, free }

class VoucherModel {
  final String id;
  final VoucherType type;

  /// Big text in the amount block, e.g. "Rs 500" or "Free".
  final String amountLabel;

  /// Small caption under the amount label, e.g. "voucher" or "dessert".
  final String amountCaption;

  final String imageUrl;
  final String title;
  final String subtitle;

  /// Already-formatted expiry text, e.g. "Expires 30 Sep".
  final String expiryLabel;

  final VoidCallback? onUseNow;

  const VoucherModel({
    required this.id,
    required this.type,
    required this.amountLabel,
    required this.amountCaption,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.expiryLabel,
    this.onUseNow,
  });
}
