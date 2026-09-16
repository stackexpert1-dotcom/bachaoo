import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class DiscountSummaryRowCard extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String subtitle;
  final String percentLabel;

  const DiscountSummaryRowCard({
    super.key,
    this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.percentLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
            child: imageUrl != null
                ? Image.network(
                    imageUrl!,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _placeholder(),
                  )
                : _placeholder(),
          ),
          const SizedBox(width: AppDimensions.spacingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.titleMedium(title, maxLines: 1),
                const SizedBox(height: 2),
                AppText.bodyMedium(subtitle, maxLines: 1),
              ],
            ),
          ),
          const SizedBox(width: AppDimensions.spacingSmall),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.warningLight,
              borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
            ),
            child: Text(
              percentLabel,
              style: const TextStyle(
                color: AppColors.warningDark,
                fontWeight: FontWeight.w700,
                fontSize: AppDimensions.fontSizeBodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 56,
      height: 56,
      color: AppColors.disabledBackground,
    );
  }
}
