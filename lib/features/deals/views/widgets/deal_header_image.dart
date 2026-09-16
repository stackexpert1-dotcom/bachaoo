import 'package:bachaoo/common_widgets/app_image.dart';
import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class DealHeaderImage extends StatelessWidget {
  final String? imageUrl;
  final String saveLabel; // "Save Rs 150"
  final String title; // "Bachaoo Deal 1"
  final String subtitle; // "Dhuaan N Dhukan · Satellite Town"
  final VoidCallback onBackTap;
  final VoidCallback? onShareTap;
  final double height;

  const DealHeaderImage({
    super.key,
    this.imageUrl,
    required this.saveLabel,
    required this.title,
    required this.subtitle,
    required this.onBackTap,
    this.onShareTap,
    this.height = 380,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          imageUrl != null
              ? AppImage(
                  imagePath: imageUrl!,
                  width: double.infinity,
                  height: height,
                )
              : Container(color: AppColors.disabledBackground),

          // --- Scrim: darker at top (buttons) and bottom (title text) ---
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black45,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black87,
                ],
                stops: [0.0, 0.25, 0.5, 1.0],
              ),
            ),
          ),

          // --- Back button (reuses shared CustomBackButton) ---
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: AppDimensions.spacingMedium,
                  top: AppDimensions.spacingMedium,
                ),
                child: CustomBackButton(onTap: onBackTap),
              ),
            ),
          ),
          if (onShareTap != null)
            Positioned(
              top: AppDimensions.spacingMedium,
              right: AppDimensions.spacingMedium,
              child: _HeaderIconButton(
                icon: Icons.ios_share_rounded,
                onTap: onShareTap!,
              ),
            ),

          // --- Save badge + title + subtitle, overlaid at the bottom ---
          Positioned(
            left: AppDimensions.pagePaddingSmall,
            right: AppDimensions.pagePaddingSmall,
            bottom: AppDimensions.spacingLarge,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
                    saveLabel,
                    style: const TextStyle(
                      color: AppColors.warningDark,
                      fontWeight: FontWeight.w700,
                      fontSize: AppDimensions.fontSizeBodyMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: AppDimensions.fontSizeHeadlineMedium,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppColors.white.withValues(alpha: 0.85),
                    fontSize: AppDimensions.fontSizeBodyLarge,
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

class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        child: Icon(icon, color: AppColors.white),
      ),
    );
  }
}
