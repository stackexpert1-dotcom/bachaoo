import 'package:flutter/material.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class MemberPromoBanner extends StatelessWidget {
  final String badgeLabel; // e.g. "This weekend"
  final String brandInitial; // e.g. "B" — shown in the top-right pill
  final String title; // e.g. "Extra 5% off Deal 3 for members"
  final String
  subtitle; // e.g. "Fri–Sun · dine-in only · scan the QR at the counter"
  final String? imageUrl;

  const MemberPromoBanner({
    super.key,
    required this.badgeLabel,
    required this.brandInitial,
    required this.title,
    required this.subtitle,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        decoration: BoxDecoration(
          color: AppColors.disabledBackground,
          image: imageUrl != null
              ? DecorationImage(
                  image: NetworkImage(imageUrl!),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withValues(alpha: 0.35),
                    BlendMode.darken,
                  ),
                )
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Badge + brand initial ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.warningLight,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusRound,
                    ),
                  ),
                  child: Text(
                    badgeLabel,
                    style: const TextStyle(
                      color: AppColors.warningDark,
                      fontWeight: FontWeight.w700,
                      fontSize: AppDimensions.fontSizeBodyMedium,
                    ),
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.secondaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    brandInitial,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: AppDimensions.fontSizeBodyLarge,
                    ),
                  ),
                ),
              ],
            ),
            AppDimensions.verticalSpace24,

            // --- Title + subtitle ---
            Text(
              title,
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
                fontSize: AppDimensions.fontSizeTitleLarge,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: AppColors.white.withValues(alpha: 0.85),
                fontSize: AppDimensions.fontSizeBodyMedium,
              ),
            ),
            const SizedBox(height: 12),
            // Row(
            //   children: [
            //     Expanded(
            //       child: ElevatedButton(
            //         onPressed: () {}, // TODO: implement call action
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor: AppColors.secondaryColor,
            //           foregroundColor: AppColors.textPrimary,
            //           padding: const EdgeInsets.symmetric(vertical: 12),
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            //           ),
            //         ),
            //         child: const Text('Call'),
            //       ),
            //     ),
            //     const SizedBox(width: 12),
            //     Expanded(
            //       child: ElevatedButton(
            //         onPressed: () {}, // TODO: implement deals action
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor: AppColors.primaryColor,
            //           foregroundColor: AppColors.white,
            //           padding: const EdgeInsets.symmetric(vertical: 12),
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            //           ),
            //         ),
            //         child: const Text('Deals'),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
