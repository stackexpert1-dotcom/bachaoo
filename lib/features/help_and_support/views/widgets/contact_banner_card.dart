import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:flutter/material.dart';

class ContactBannerCard extends StatelessWidget {
  final String imageUrl;
  final String caption;

  const ContactBannerCard({
    super.key,
    required this.imageUrl,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(color: AppColors.disabledBackground),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    AppColors.black.withValues(alpha: 0.55),
                    AppColors.black.withValues(alpha: 0.0),
                  ],
                  stops: const [0.0, 0.6],
                ),
              ),
            ),
            Positioned(
              left: AppDimensions.paddingMedium,
              bottom: AppDimensions.paddingMedium,
              right: AppDimensions.paddingMedium,
              child: Text(
                caption,
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: AppDimensions.fontSizeTitleSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
