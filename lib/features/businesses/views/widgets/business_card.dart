import 'package:bachaoo/features/businesses/models/nearby_business_model.dart';
import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class NearbyBusinessCard extends StatelessWidget {
  final BusinessModel business;
  final VoidCallback? onTap;

  const NearbyBusinessCard({super.key, required this.business, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --- Image / placeholder ---
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
              child: business.imageUrl != null
                  ? Image.network(
                      business.imageUrl!,
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _placeholder(),
                    )
                  : _placeholder(),
            ),
            const SizedBox(width: AppDimensions.spacingMedium),

            // --- Name, location, rating ---
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.titleSmall(business.name, maxLines: 1),
                  const SizedBox(height: 2),
                  AppText.bodyMedium(
                    '${business.location} · ${business.distanceKm} km',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  _buildRatingRow(),
                ],
              ),
            ),
            const SizedBox(width: AppDimensions.spacingSmall),

            // --- Discount ---
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  business.discountLabel,
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: AppDimensions.fontSizeHeadlineXSmall,
                  ),
                ),
                AppText.bodyXSmall(business.discountSubtitle),
              ],
            ),
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

  Widget _buildRatingRow() {
    if (business.isNew) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ..._buildStars(5),
          const SizedBox(width: 6),
          AppText.bodyMedium('New', color: AppColors.textSecondary),
        ],
      );
    }

    final rating = business.rating ?? 0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ..._buildStars(rating.round()),
        const SizedBox(width: 2),
        AppText.bodyMedium(
          business.reviewCount != null
              ? '(${rating.toStringAsFixed(1)})'
              : rating.toStringAsFixed(1),
          color: AppColors.textSecondary,
        ),
      ],
    );
  }

  List<Widget> _buildStars(int filledCount) {
    return List.generate(5, (index) {
      final filled = index < filledCount;
      return Icon(
        filled ? Icons.star_rounded : Icons.star_border_rounded,
        color: AppColors.secondaryColor,
        size: 16,
      );
    });
  }
}
