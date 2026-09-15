import 'package:bachaoo/common_widgets/app_image.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class BusinessHeaderImage extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback onBackTap;
  final double height;
  final double? discountSavePercentage;
  final double? dealSavings;
  final String? location;

  const BusinessHeaderImage({
    super.key,
    this.imageUrl,
    required this.onBackTap,
    this.height = 300,
    this.discountSavePercentage,
    this.dealSavings,
    this.location,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Business cover image — prefers a bundled asset and falls back to a
          // network URL, so it always renders a real image (never a box).
          imageUrl != null
              ? AppImage(
                  imagePath: imageUrl!,
                  width: double.infinity,
                  height: height,
                )
              : Container(color: AppColors.disabledBackground),

          // Dark gradient at the top
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black38, Colors.transparent],
                stops: [0.0, 0.3],
              ),
            ),
          ),

          // Back button - top left
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: AppDimensions.spacingLarge,
                  top: AppDimensions.spacingSmall,
                ),
                child: CustomBackButton(onTap: onBackTap),
              ),
            ),
          ),
          if (discountSavePercentage != null ||
              dealSavings != null ||
              location != null)
            SafeArea(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.spacingSmall,
                        vertical: AppDimensions.spacingSmall,
                      ),
                      child: dealSavings != null
                          ? AppText.bodyMedium(
                              '- ${dealSavings!.toStringAsFixed(0)}% OFF',
                            )
                          : AppText.bodyMedium(
                              '- ${discountSavePercentage!.toStringAsFixed(0)}% OFF your entire bill ',
                            ),
                    ),
                    if (location != null)
                      AppText.bodyMedium(
                        location ?? '',
                        color: AppColors.white,
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
