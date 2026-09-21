import 'dart:ui';


import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_image.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/businesses/models/nearby_business_model.dart';

class BusinessDiscountCard extends StatelessWidget {
  final BusinessModel business;
  final bool isFavorite;

  /// Whether this card is currently selected in selection / cart-add mode.
  final bool isSelected;

  /// Fixed pixel width. When null the card uses [_kDefaultWidth] so it is
  /// always self-sized and never crashes inside unbounded parents.
  final double? width;

  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  /// Fallback width used when [width] is null (e.g. horizontal ListView).
  static const double _kDefaultWidth = 180.0;

  const BusinessDiscountCard({
    super.key,
    required this.business,
    this.isFavorite = false,
    this.isSelected = false,
    this.width,
    this.onTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final photoUrl = business.coverImageUrl ?? business.imageUrl;
    final effectiveWidth = width ?? _kDefaultWidth;
    // Image height = width × (1/1.15) to preserve the original aspect ratio.
    final imageHeight = effectiveWidth / 1.15;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: effectiveWidth,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        border: Border.all(
          color: isSelected ? AppColors.primaryColor : AppColors.borderColor,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
          child: Stack(
            children: [
              // --- Photo ---
              SizedBox(
                width: effectiveWidth,
                height: imageHeight,
                child: photoUrl != null
                    ? AppImage(imagePath: photoUrl, fit: BoxFit.cover)
                    : Container(
                        color: AppColors.disabledBackground,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.image_not_supported_outlined,
                          color: AppColors.iconMuted,
                        ),
                      ),
              ),

              // --- Discount badge — top left ---
              Positioned(
                top: AppDimensions.spacingSmall,
                left: AppDimensions.spacingSmall,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusRound,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.sell_rounded,
                        size: 16,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Flat ${business.discountLabel} Off',
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: AppDimensions.fontSizeBodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // --- Favourite / selection check — top right ---
              Positioned(
                top: AppDimensions.spacingSmall,
                right: AppDimensions.spacingSmall,
                child: isSelected
                    ? Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.check_rounded,
                          color: AppColors.white,
                          size: 18,
                        ),
                      )
                    : GestureDetector(
                        onTap: onFavoriteTap,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.white.withValues(alpha: 0.85),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadow,
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: isFavorite
                                ? AppColors.error
                                : AppColors.textSecondary,
                            size: 18,
                          ),
                        ),
                      ),
              ),

              // --- Frosted business-info panel — overlapping the photo's
              // bottom edge, genuinely translucent (BackdropFilter blur),
              // not just a flat semi-opaque color. ---
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppDimensions.radiusXLarge),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                    child: Container(
                      padding: const EdgeInsets.all(
                        AppDimensions.paddingMedium,
                      ),
                      color: AppColors.white.withValues(alpha: 0.55),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Logo
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusLarge,
                            ),
                            child: business.logoUrl != null
                                ? AppImage(
                                    imagePath: business.logoUrl!,
                                    width: 56,
                                    height: 56,
                                    fit: BoxFit.cover,
                                    errorBuilder: (
                                      context,
                                      error,
                                      stackTrace,
                                    ) => _logoPlaceholder(),
                                  )
                                : _logoPlaceholder(),
                          ),
                          const SizedBox(width: AppDimensions.spacingMedium),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText.titleMedium(
                                  business.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${business.location} \u2022 ${business.distanceKm} km',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: AppDimensions.fontSizeBodyMedium,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Icon(
                                      business.isOpenNow
                                          ? Icons.storefront_rounded
                                          : Icons.storefront_outlined,
                                      size: 15,
                                      color: business.isOpenNow
                                          ? AppColors.successDark
                                          : AppColors.textHint,
                                    ),
                                    const SizedBox(width: 4),
                                    if (business.isNew ||
                                        business.rating == null)
                                      const Text(
                                        'New',
                                        style: TextStyle(
                                          color: AppColors.textSecondary,
                                          fontWeight: FontWeight.w700,
                                          fontSize:
                                              AppDimensions.fontSizeBodySmall,
                                        ),
                                      )
                                    else ...[
                                      const Icon(
                                        Icons.star_rounded,
                                        color: AppColors.secondaryColor,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        business.rating!.toStringAsFixed(1),
                                        style: const TextStyle(
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.w700,
                                          fontSize:
                                              AppDimensions.fontSizeBodySmall,
                                        ),
                                      ),
                                      if (business.reviewCount != null) ...[
                                        const SizedBox(width: 2),
                                        Text(
                                          '(${business.reviewCount})',
                                          style: const TextStyle(
                                            color: AppColors.textSecondary,
                                            fontSize:
                                                AppDimensions.fontSizeBodySmall,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logoPlaceholder() {
    return Container(
      width: 56,
      height: 56,
      color: AppColors.disabledBackground,
      alignment: Alignment.center,
      child: Text(
        business.name.isEmpty
            ? '?'
            : business.name.substring(0, 1).toUpperCase(),
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w800,
          fontSize: AppDimensions.fontSizeTitleMedium,
        ),
      ),
    );
  }
}
