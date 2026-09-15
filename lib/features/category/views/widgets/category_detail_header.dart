import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_text.dart';

class CategoryDetailHeader extends StatelessWidget {
  final String categoryTitle;
  final int totalDeals;

  const CategoryDetailHeader({
    super.key,
    required this.categoryTitle,
    required this.totalDeals,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText.headlineMedium(categoryTitle),
        AppText.bodyLarge('$totalDeals deals & discounts'),
      ],
    );
  }
}
