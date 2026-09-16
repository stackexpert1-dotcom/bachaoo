import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';

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
        Expanded(
          child: AppText.headlineXSmall(
            categoryTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 12),
        AppText.bodySmall(
          '$totalDeals deals & discounts',
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
