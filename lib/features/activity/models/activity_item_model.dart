import 'package:flutter/material.dart';

/// Drives which icon/color a row falls back to when there's no image.
enum ActivityType { discountClaimed, referralJoined, dealRedeemed }

class ActivityItemModel {
  final String id;
  final ActivityType type;
  final String title;
  final String subtitle; // e.g. "Nawaab Royal · today"
  final String amountLabel; // e.g. "- Rs 100" or "+1,000 pts"
  final bool isPositive; // true = green/earned, false = deducted/spent
  final String? imageUrl;
  final DateTime date;

  const ActivityItemModel({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.amountLabel,
    required this.isPositive,
    required this.date,
    this.imageUrl,
  });

  factory ActivityItemModel.fromJson(Map<String, dynamic> json) {
    return ActivityItemModel(
      id: json['id'] as String,
      type: ActivityType.values.firstWhere((t) => t.name == json['type']),
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      amountLabel: json['amountLabel'] as String,
      isPositive: json['isPositive'] as bool,
      date: DateTime.parse(json['date'] as String),
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type.name,
    'title': title,
    'subtitle': subtitle,
    'amountLabel': amountLabel,
    'isPositive': isPositive,
    'date': date.toIso8601String(),
    'imageUrl': imageUrl,
  };
}

/// Fallback icon + tint when a row has no `imageUrl`.
extension ActivityTypeVisuals on ActivityType {
  IconData get icon {
    switch (this) {
      case ActivityType.discountClaimed:
        return Icons.local_offer_outlined;
      case ActivityType.referralJoined:
        return Icons.share_outlined;
      case ActivityType.dealRedeemed:
        return Icons.restaurant_outlined;
    }
  }

  Color get iconBackground {
    switch (this) {
      case ActivityType.discountClaimed:
        return const Color(0xFFFDF0E1);
      case ActivityType.referralJoined:
        return const Color(0xFFE7F3EA);
      case ActivityType.dealRedeemed:
        return const Color(0xFFF1E9E4);
    }
  }

  Color get iconColor {
    switch (this) {
      case ActivityType.discountClaimed:
        return const Color(0xFFB9770E);
      case ActivityType.referralJoined:
        return const Color(0xFF1E6B3A);
      case ActivityType.dealRedeemed:
        return const Color(0xFF6E4A32);
    }
  }
}
