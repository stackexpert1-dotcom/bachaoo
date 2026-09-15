import 'package:flutter/material.dart';

class SubCategoryModel {
  final String title;
  final String subtitle;
  final String? imageUrl;
  final int dealsCount;
  final VoidCallback? onTap;

  const SubCategoryModel({
    required this.title,
    required this.subtitle,
    this.imageUrl,
    required this.dealsCount,
    this.onTap,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      imageUrl: json['image_url'] as String?,
      dealsCount: json['deals_count'] as int,
    );
  }
}
