import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/category/models/sub_category_model.dart';

class SubCategoryListItem extends StatelessWidget {
  final SubCategoryModel subCategory;
  final VoidCallback? onTap;

  const SubCategoryListItem({super.key, required this.subCategory, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
          vertical: AppDimensions.paddingMedium,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --- Image / placeholder ---
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
              child: subCategory.imageUrl != null
                  ? Image.network(
                      subCategory.imageUrl!,
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _placeholder(),
                    )
                  : _placeholder(),
            ),
            const SizedBox(width: AppDimensions.spacingMedium),

            // --- Title + subtitle ---
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.titleMedium(subCategory.title, maxLines: 1),
                  const SizedBox(height: 2),
                  AppText.bodyMedium(
                    subCategory.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppDimensions.spacingSmall),

            // --- Deals count pill ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.successLight,
                borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
              ),
              child: Text(
                '${subCategory.dealsCount}',
                style: const TextStyle(
                  color: AppColors.successDark,
                  fontWeight: FontWeight.w700,
                  fontSize: AppDimensions.fontSizeBodyMedium,
                ),
              ),
            ),
            const SizedBox(width: 4),

            const Icon(Icons.chevron_right_rounded, color: AppColors.iconMuted),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 64,
      height: 64,
      color: AppColors.disabledBackground,
    );
  }
}
