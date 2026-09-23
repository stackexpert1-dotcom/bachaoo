import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_assets.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class ReferralHeroCard extends StatelessWidget {
  final String eyebrowText;
  final String statValue;
  final String statLabel;
  final String descriptionText;

  const ReferralHeroCard({
    super.key,
    required this.eyebrowText,
    required this.statValue,
    required this.statLabel,
    required this.descriptionText,
  });

  static Color _shade(Color c, double delta) {
    final hsl = HSLColor.fromColor(c);
    return hsl.withLightness((hsl.lightness + delta).clamp(0.0, 1.0)).toColor();
  }

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primaryColor;

    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_shade(primary, 0.04), primary, _shade(primary, -0.08)],
        ),
        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        child: Stack(
          children: [
            // Soft decorative circles
            Positioned(
              right: -40,
              top: -50,
              child: Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.07),
                ),
              ),
            ),
            Positioned(
              right: 30,
              bottom: -60,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withValues(alpha: 0.08),
                ),
              ),
            ),

            // Image, bottom-right
            Positioned(
              right: 2,
              bottom: 0,
              child: Image.asset(
                AppAssets.referScreenquala,
                height: 130,
                fit: BoxFit.contain,
                alignment: Alignment.bottomRight,
              ),
            ),

            // Text content (left ~60%)
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 18, 0, 18),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.62,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        eyebrowText,
                        style: appFont(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: AppDimensions.fontSizeBodySmall,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            statValue,
                            style: appFont(
                              color: Colors.white,
                              fontSize: 38,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            statLabel,
                            style: appFont(
                              color: AppColors.secondaryColor,
                              fontSize: AppDimensions.fontSizeBodyMedium,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        descriptionText,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: appFont(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: AppDimensions.fontSizeBodySmall,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
