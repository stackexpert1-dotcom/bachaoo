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
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.paddingXXSmall,
          horizontal: AppDimensions.paddingXSmall,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // --- Icon ---
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: category.iconBackgroundColor,
                borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
              ),
              alignment: Alignment.center,
              child: category.icon == null
                  ? IconTheme(
                      data: IconThemeData(
                        color: category.iconColor,
                        size: AppDimensions.iconSizeMedium,
                      ),
                      child: category.faIcon ?? const SizedBox.shrink(),
                    )
                  : Icon(
                      category.icon,
                      color: category.iconColor,
                      size: AppDimensions.iconSizeMedium,
                    ),
            ),
            const SizedBox(height: 6),

            // --- Title ---
            SizedBox(
              width: double.infinity,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: AppText.bodySmall(
                  category.title,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
            const SizedBox(height: 2),

            // --- Offer count ---
            AppText.bodyXSmall(
              '${category.offersCount} offers',
              color: AppColors.textSecondary,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
