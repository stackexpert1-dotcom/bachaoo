import 'package:bachaoo/features/category/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final int index;
  final void Function(int index, CategoryModel category)? onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap == null ? null : () => onTap!(index, category),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon — always primary background, white foreground
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
            ),
            alignment: Alignment.center,
            child: category.iconAsset != null
                ? Image.asset(
                    category.iconAsset!,
                    width: AppDimensions.iconSizeXLarge,
                    height: AppDimensions.iconSizeXLarge,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.category_rounded,
                      color: const Color(0xFF333333),
                      size: AppDimensions.iconSizeLarge,
                    ),
                  )
                : category.icon == null
                ? IconTheme(
                    data: const IconThemeData(
                      color: Color(0xFF333333), // black 60%
                      size: AppDimensions.iconSizeLarge,
                    ),
                    child: category.faIcon ?? const SizedBox.shrink(),
                  )
                : Icon(
                    category.icon,
                    color: Color(0xFF333333),
                    size: AppDimensions.iconSizeLarge,
                  ),
          ),
          const SizedBox(height: 4),
          // Title — constrained to the icon's width so it wraps to a
          // second line instead of overflowing horizontally or forcing
          // the card wider than the icon above it
          SizedBox(
            width: 70,
            child: AppText.bodySmall(
              category.title,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
