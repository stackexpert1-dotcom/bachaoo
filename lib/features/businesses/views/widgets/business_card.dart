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
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    business.discountLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: AppDimensions.fontSizeHeadlineXSmall,
                    ),
                  ),
                  AppText.bodyXSmall(
                    _truncateSubtitle(business.discountSubtitle),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
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

  // FIX: custom truncation — if the subtitle has more than 3 words OR
  // more than 16 characters, cut it and append ".."
  String _truncateSubtitle(String text) {
    final trimmed = text.trim();
    final wordCount = trimmed.split(RegExp(r'\s+')).length;

    if (wordCount <= 3 && trimmed.length <= 16) {
      return trimmed;
    }

    final cut = trimmed.length > 16
        ? trimmed.substring(0, 16).trimRight()
        : trimmed;
    return '$cut..';
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
        ..._buildStars(rating), // pass the raw double, not rounded
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

  // FIX: draws partial stars. e.g. 4.8 -> 4 full stars + 1 star at 80% fill.
  List<Widget> _buildStars(double rating) {
    return List.generate(5, (index) {
      final fillAmount = (rating - index).clamp(0.0, 1.0);

      if (fillAmount <= 0) {
        return const Icon(
          Icons.star_border_rounded,
          color: AppColors.secondaryColor,
          size: 16,
        );
      }

      if (fillAmount >= 1) {
        return const Icon(
          Icons.star_rounded,
          color: AppColors.secondaryColor,
          size: 16,
        );
      }

      // Partial star: outline underneath, clipped filled star on top.
      return SizedBox(
        width: 16,
        height: 16,
        child: Stack(
          children: [
            const Icon(
              Icons.star_border_rounded,
              color: AppColors.secondaryColor,
              size: 16,
            ),
            ClipRect(
              clipper: _StarClipper(fillAmount),
              child: const Icon(
                Icons.star_rounded,
                color: AppColors.secondaryColor,
                size: 16,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _StarClipper extends CustomClipper<Rect> {
  final double fraction;
  _StarClipper(this.fraction);

  @override
  Rect getClip(Size size) =>
      Rect.fromLTRB(0, 0, size.width * fraction, size.height);

  @override
  bool shouldReclip(covariant _StarClipper oldClipper) =>
      oldClipper.fraction != fraction;
}
