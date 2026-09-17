import 'package:flutter/material.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';

enum NotificationCategory { promo, bachaoo }

enum NotificationType {
  dealExpiring,
  voucher,
  exclusiveGift,
  dealRedeemed,
  pointsEarned,
  cardUpgrade,
}

class NotificationModel {
  final String id;
  final String title;
  final String description;
  final DateTime time;
  final NotificationCategory category;
  final NotificationType type;
  final String? imageUrl;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.category,
    required this.type,
    this.imageUrl,
  });

  IconData get icon {
    switch (type) {
      case NotificationType.dealExpiring:
        return Icons.access_time_rounded;
      case NotificationType.voucher:
        return Icons.confirmation_number_rounded;
      case NotificationType.exclusiveGift:
        return Icons.card_giftcard_rounded;
      case NotificationType.dealRedeemed:
        return Icons.check_circle_rounded;
      case NotificationType.pointsEarned:
        return Icons.star_rounded;
      case NotificationType.cardUpgrade:
        return Icons.credit_card_rounded;
    }
  }

  Color get iconColor => AppColors.secondaryColor;
}
