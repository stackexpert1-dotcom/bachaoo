import 'package:bachaoo/core/constants/bachaoo_assets.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  final String title;
  final int offersCount;
  final IconData? icon;
  final Widget? faIcon;

  /// Bundled PNG asset path for the category icon, e.g.
  /// [AppAssets.categoryFood]. When present, the category card renders this
  /// image instead of [icon] / [faIcon].
  final String? iconAsset;
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
    this.iconAsset,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      title: json['title'] as String,
      offersCount: json['offers_count'] as int,
      icon: _iconForKey(json['icon_key'] as String),
      iconAsset: _iconAssetForKey(json['icon_key'] as String),
      iconColor: _colorFromHex(json['icon_color'] as String),
      iconBackgroundColor: _colorFromHex(
        json['icon_background_color'] as String,
      ),
      isFeatured: json['is_featured'] as bool? ?? false,
    );
  }

  /// Maps the API's `icon_key` to the bundled PNG icon when one exists for
  /// that category. Falls back to null (card then shows the font icon).
  static String? _iconAssetForKey(String key) {
    switch (key) {
      case 'food':
        return AppAssets.categoryFood;
      case 'supermarket':
        return AppAssets.categorySupermarket;
      case 'beauty_care':
        return AppAssets.categoryBeauty;
      case 'health':
        return AppAssets.categoryHealth;
      case 'automobiles':
        return AppAssets.categoryAutomobiles;
      case 'fashion':
        return AppAssets.categoryFashion;
      case 'education':
        return AppAssets.categoryEducation;
      case 'entertainment':
        return AppAssets.categoryEntertainment;
      case 'services':
        return AppAssets.categoryServices;
      case 'cinema':
        return AppAssets.categoryCinema;
      case 'hospital':
        return AppAssets.categoryHospital;
      case 'labs':
      case 'lab':
        // Labs intentionally share the health artwork.
        return AppAssets.categoryHealth;
      default:
        return null;
    }
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
      case 'hospital':
        return Icons.local_hospital_rounded;
      case 'labs':
      case 'lab':
        return Icons.science_rounded;
      case 'cinema':
        return Icons.movie_rounded;
      default:
        return Icons.category_rounded;
    }
  }

  static Color _colorFromHex(String hex) {
    final cleaned = hex.replaceFirst('#', '');
    return Color(int.parse('FF$cleaned', radix: 16));
  }
}
