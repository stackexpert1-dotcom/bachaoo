import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.pagePaddingSmall,
        vertical: AppDimensions.spacingSmall,
      ),
      child: Row(
        children: [
          // --- Avatar ---
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFC79A4B), Color(0xFF8A6A2F)],
              ),
            ),
            alignment: Alignment.center,
            child: const Text(
              'SU',
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
                fontSize: AppDimensions.fontSizeBodyMedium,
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.spacingSmall),

          // --- Date + greeting ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Thursday, 10 Sep',
                  style: TextStyle(
                    color: AppColors.textHint,
                    fontSize: AppDimensions.fontSizeBodySmall,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Hi, Shafqat',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                        fontSize: AppDimensions.fontSizeTitleSmall,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.check_circle,
                      color: AppColors.success,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // --- Points pill ---
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.star_rounded,
                  color: AppColors.secondaryColor,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  '2,000 pts',
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: AppDimensions.fontSizeLabelLarge,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppDimensions.spacingSmall),

          // --- Notification button ---
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(
                  Icons.notifications_none_rounded,
                  color: AppColors.iconPrimaryColor,
                  size: AppDimensions.iconSizeLarge,
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
