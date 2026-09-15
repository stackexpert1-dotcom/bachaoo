import 'package:flutter/material.dart';

class CategoryModel {
  final String title;
  final int offersCount;
  final IconData? icon;
  final Widget? faIcon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final bool isFeatured;

  const CategoryModel({
    required this.title,
    required this.offersCount,
    this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    this.isFeatured = false,
    this.faIcon,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      title: json['title'] as String,
      offersCount: json['offers_count'] as int,
      icon: _iconForKey(json['icon_key'] as String),
      iconColor: _colorFromHex(json['icon_color'] as String),
      iconBackgroundColor: _colorFromHex(
        json['icon_background_color'] as String,
      ),
      isFeatured: json['is_featured'] as bool? ?? false,
    );
  }

  static IconData _iconForKey(String key) {
    switch (key) {
      case 'food':
        return Icons.lunch_dining_rounded;
      case 'supermarket':
        return Icons.shopping_cart_rounded;
      case 'beauty_care':
        return Icons.spa_rounded;
      case 'health':
        return Icons.favorite_rounded;
      case 'automobiles':
        return Icons.directions_car_rounded;
      case 'fashion':
        return Icons.checkroom_rounded;
      default:
        return Icons.category_rounded;
    }
  }

  static Color _colorFromHex(String hex) {
    final cleaned = hex.replaceFirst('#', '');
    return Color(int.parse('FF$cleaned', radix: 16));
  }
}
