import 'package:bachaoo/common_widgets/app_image.dart';
import 'package:bachaoo/features/discounts/models/discount_model.dart';
import 'package:flutter/material.dart';

import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class DiscountCard extends StatelessWidget {
  final DiscountModel discount;
  final VoidCallback? onTap;
  final double width;

  const DiscountCard({
    super.key,
    required this.discount,
    this.onTap,
    this.width = 160,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
            border: Border.all(color: AppColors.borderColor),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Image + discount badge ---
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1.1,
                    child: AppImage(imagePath: discount.imageUrl),
                  ),
                  Positioned(
                    top: AppDimensions.spacingSmall,
                    left: AppDimensions.spacingSmall,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.warningLight,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusRound,
                        ),
                      ),
                      child: Text(
                        discount.discountLabel,
                        style: const TextStyle(
                          color: AppColors.warningDark,
                          fontWeight: FontWeight.w700,
                          fontSize: AppDimensions.fontSizeLabelLarge,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // --- Title + subtitle ---
              Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingXSmall),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      discount.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: AppDimensions.fontSizeTitleSmall,
                        height: AppDimensions.lineHeightTight,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      discount.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: AppDimensions.fontSizeBodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
