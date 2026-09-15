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
                        fontSize: AppDimensions.fontSizeLabelLarge,
                      ),
                    ),
                  ),
                ),

              // --- Top-right brand pill ---
              if (promo.brandName != null)
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
                      promo.brandName!,
                      style: const TextStyle(
                        color: AppColors.error,
                        fontWeight: FontWeight.w800,
                        fontSize: AppDimensions.fontSizeLabelLarge,
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
                      if (promo.subtitle != null)
                        Text(
                          promo.subtitle!,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: AppDimensions.fontSizeBodyMedium,
                          ),
                        ),
                      if (promo.offerTitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          promo.offerTitle!,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: AppDimensions.fontSizeHeadlineSmall,
                          ),
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
