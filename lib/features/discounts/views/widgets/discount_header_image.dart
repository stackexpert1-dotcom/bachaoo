import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class DiscountHeaderImage extends StatelessWidget {
  final String? imageUrl;
  final String subtitle; // e.g. "Chobara Restaurant · Queen Road"
  final String percentLabel; // e.g. "12%"
  final String description; // e.g. "off your entire bill"
  final VoidCallback onBackTap;
  final double height;

  const DiscountHeaderImage({
    super.key,
    this.imageUrl,
    required this.subtitle,
    required this.percentLabel,
    required this.description,
    required this.onBackTap,
    this.height = 420,
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
              ? Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(color: AppColors.disabledBackground),
                )
              : Container(color: AppColors.disabledBackground),

          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black45, Colors.transparent, Colors.black87],
                stops: [0.0, 0.35, 1.0],
              ),
            ),
          ),

          // Back button - top left (kept inside a SafeArea so it never sits
          // under the status bar / notch and stays reliably tappable).
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: AppDimensions.spacingMedium,
                  top: AppDimensions.spacingSmall,
                ),
                child: CustomBackButton(onTap: onBackTap),
              ),
            ),
          ),

          Positioned(
            left: AppDimensions.pagePaddingSmall,
            right: AppDimensions.pagePaddingSmall,
            bottom: AppDimensions.spacingLarge,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppColors.white.withValues(alpha: 0.9),
                    fontSize: AppDimensions.fontSizeBodyLarge,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  percentLabel,
                  style: const TextStyle(
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 56,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: AppDimensions.fontSizeTitleLarge,
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
