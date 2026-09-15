import 'package:bachaoo/common_widgets/promo_card.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:flutter/material.dart';

/// Sits inside [GradientPromoCard]. Nothing here is hardcoded text — every
/// line is a parameter, and [statValue] is optional: pass it to show a big
/// highlighted number (like "1,000 points"), or leave it null/empty to get
/// a plain eyebrow + description card with no stat at all. That's what lets
/// the same shell serve different screens with different content density.
class PromoStatCard extends StatelessWidget {
  final String eyebrowText;
  final String descriptionText;
  final String? statValue;
  final String? statLabel;
  final IconData? watermarkIcon;

  const PromoStatCard({
    super.key,
    required this.eyebrowText,
    required this.descriptionText,
    this.statValue,
    this.statLabel,
    this.watermarkIcon,
  });

  bool get _hasStat => statValue != null && statValue!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final onPrimary = AppColors.textOnPrimary;

    return GradientPromoCard(
      watermarkIcon: watermarkIcon,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            eyebrowText,
            style: TextStyle(color: onPrimary.withValues(alpha: 0.85), fontSize: 15),
          ),
          if (_hasStat) ...[
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  statValue!,
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (statLabel != null && statLabel!.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  Text(
                    statLabel!,
                    style: TextStyle(
                      color: onPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ],
          SizedBox(height: _hasStat ? 14 : 6),
          Text(
            descriptionText,
            style: TextStyle(
              color: onPrimary.withValues(alpha: 0.85),
              fontSize: 15,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
