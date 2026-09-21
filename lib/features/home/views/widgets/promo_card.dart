import 'package:flutter/material.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/home/models/promo_model.dart';

class PromoCard extends StatelessWidget {
  final PromoModel promo;
  final VoidCallback? onTap;

  const PromoCard({super.key, required this.promo, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        child: AspectRatio(
          aspectRatio: 16 / 11,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // --- Background image ---
              Image.network(
                promo.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    color: AppColors.disabledBackground,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primaryColor,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.disabledBackground,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.image_not_supported_outlined,
                    color: AppColors.iconMuted,
                    size: 32,
                  ),
                ),
              ),

              // --- Gradient overlay for text legibility ---
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black54],
                    stops: [0.5, 1.0],
                  ),
                ),
              ),

              // --- Top-left badge ---
              if (promo.badgeText != null)
                Positioned(
                  top: AppDimensions.spacingMedium,
                  left: AppDimensions.spacingMedium,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusSmall,
                      ),
                    ),
                    child: Text(
                      promo.badgeText!,
                      style: const TextStyle(
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: AppDimensions.fontSizeLabelMedium,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),

              // Category describes the visual without relying on a logo.
              if (promo.category != null)
                Positioned(
                  top: AppDimensions.spacingMedium,
                  right: AppDimensions.spacingMedium,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusSmall,
                      ),
                    ),
                    child: Text(
                      promo.category!,
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: AppDimensions.fontSizeLabelMedium,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),

              // --- Bottom text block ---
              if (promo.subtitle != null || promo.offerTitle != null)
                Positioned(
                  left: AppDimensions.spacingMedium,
                  right: AppDimensions.spacingMedium,
                  bottom: AppDimensions.spacingMedium,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (promo.brandName != null)
                        Text(
                          promo.brandName!,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: AppDimensions.fontSizeTitleLarge,
                            height: 1.2,
                          ),
                        ),
                      if (promo.subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          promo.subtitle!,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: AppDimensions.fontSizeBodySmall,
                            height: 1.3,
                          ),
                        ),
                      ],
                      if (promo.offerTitle != null) ...[
                        const SizedBox(height: 6),
                        Text(
                          promo.offerTitle!,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: AppDimensions.fontSizeBodyMedium,
                            height: 1.2,
                          ),
                        ),
                      ],
                      if (promo.rating != null ||
                          promo.distanceLabel != null) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            if (promo.rating != null) ...[
                              const Icon(
                                Icons.star_rounded,
                                color: Color(0xFFFFD45B),
                                size: 17,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                promo.rating!.toStringAsFixed(1),
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: AppDimensions.fontSizeLabelMedium,
                                ),
                              ),
                            ],
                            if (promo.rating != null &&
                                promo.distanceLabel != null)
                              const SizedBox(width: 12),
                            if (promo.distanceLabel != null) ...[
                              Icon(
                                Icons.location_on_outlined,
                                color: AppColors.white.withValues(alpha: 0.9),
                                size: 16,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                promo.distanceLabel!,
                                style: TextStyle(
                                  color: AppColors.white.withValues(
                                    alpha: 0.95,
                                  ),
                                  fontWeight: FontWeight.w600,
                                  fontSize: AppDimensions.fontSizeLabelMedium,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
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
