import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_image.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/businesses/models/nearby_business_model.dart';

class BusinessInfoCard extends StatelessWidget {
  final BusinessModel business;
  final VoidCallback? onDirectionsTap;
  final VoidCallback? onCallTap;

  const BusinessInfoCard({
    super.key,
    required this.business,
    this.onDirectionsTap,
    this.onCallTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Logo (distinct from the header cover image) + name + address ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
                child: business.logoUrl != null
                    ? AppImage(
                        imagePath: business.logoUrl!,
                        width: 64,
                        height: 64,
                        errorBuilder: (context, error, stackTrace) =>
                            _logoPlaceholder(),
                      )
                    : _logoPlaceholder(),
              ),
              const SizedBox(width: AppDimensions.spacingMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.headlineSmall(business.name),
                    const SizedBox(height: 4),
                    AppText.bodyLarge(
                      business.address ?? business.location,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),

          AppDimensions.verticalSpace12,

          // --- Status pills: Open now + deals count ---
          Row(
            children: [
              if (business.isOpenNow) ...[
                _pill(
                  bg: AppColors.successLight,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.circle, size: 8, color: AppColors.successDark),
                      SizedBox(width: 6),
                      Text(
                        'Open now',
                        style: TextStyle(
                          color: AppColors.successDark,
                          fontWeight: FontWeight.w700,
                          fontSize: AppDimensions.fontSizeBodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppDimensions.spacingSmall),
              ],
              _pill(
                bg: AppColors.warningLight,
                child: Text(
                  '${business.dealsCount ?? 0} deals',
                  style: const TextStyle(
                    color: AppColors.warningDark,
                    fontWeight: FontWeight.w700,
                    fontSize: AppDimensions.fontSizeBodyMedium,
                  ),
                ),
              ),
            ],
          ),

          AppDimensions.verticalSpace16,

          // --- Stat boxes: rating / distance / call ---
          Row(
            children: [
              Expanded(
                child: business.isNew || business.rating == null
                    ? const _StatBox(
                        primaryText: 'New',
                        caption: 'No reviews yet',
                      )
                    : _StatBox(
                        primaryText: business.rating!.toStringAsFixed(1),
                        secondaryLine: const Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: AppColors.secondaryColor,
                              size: 16,
                            ),
                          ],
                        ),
                        caption: '${business.reviewCount ?? 0} reviews',
                      ),
              ),
              const SizedBox(width: AppDimensions.spacingSmall),
              Expanded(
                child: _StatBox(
                  primaryText: '${business.distanceKm} km',
                  caption: 'Directions',
                  onTap: onDirectionsTap,
                ),
              ),
              const SizedBox(width: AppDimensions.spacingSmall),
              Expanded(
                child: _StatBox(
                  primaryText: 'Call',
                  caption: business.phoneNumber ?? 'Not available',
                  onTap: business.phoneNumber != null ? onCallTap : null,
                ),
              ),
            ],
          ),

          // --- Phone number contact row — the number is shown here instead
          //     of being crammed inside the "Call" stat box above. ---
          // if (business.phoneNumber != null) ...[
          //   AppDimensions.verticalSpace16,
          //   GestureDetector(
          //     onTap: onCallTap,
          //     child: Container(
          //       padding: const EdgeInsets.symmetric(
          //         horizontal: AppDimensions.paddingMedium,
          //         vertical: AppDimensions.paddingSmall,
          //       ),
          //       decoration: BoxDecoration(
          //         color: AppColors.successLight,
          //         borderRadius: BorderRadius.circular(
          //           AppDimensions.radiusLarge,
          //         ),
          //       ),
          //       child: Row(
          //         children: [
          //           const Icon(
          //             Icons.call,
          //             color: AppColors.primaryColor,
          //             size: 18,
          //           ),
          //           const SizedBox(width: AppDimensions.spacingSmall),
          //           Expanded(
          //             child: AppText.bodyMedium(
          //               business.phoneNumber!,
          //               color: AppColors.textPrimary,
          //               fontWeight: FontWeight.w700,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ],
        ],
      ),
    );
  }

  Widget _logoPlaceholder() {
    // Fallback: brand initial on a muted background instead of an empty box.
    final name = business.name;
    final initial = name.isEmpty ? '?' : name.substring(0, 1).toUpperCase();
    return Container(
      width: 64,
      height: 64,
      color: AppColors.disabledBackground,
      alignment: Alignment.center,
      child: Text(
        initial,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w800,
          fontSize: AppDimensions.fontSizeTitleLarge,
        ),
      ),
    );
  }

  Widget _pill({required Color bg, required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
      ),
      child: child,
    );
  }
}

class _StatBox extends StatelessWidget {
  final String primaryText;
  final Widget? secondaryLine;
  final String caption;
  final VoidCallback? onTap;

  const _StatBox({
    required this.primaryText,
    this.secondaryLine,
    required this.caption,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.paddingMedium,
          horizontal: AppDimensions.paddingSmall,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              primaryText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w800,
                fontSize: AppDimensions.fontSizetitleXSmall,
              ),
            ),
            ?secondaryLine,
            const SizedBox(height: 2),
            AppText.bodySmall(caption, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
