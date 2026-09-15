import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/profile/widgets/status_chip.dart';
import 'package:flutter/material.dart';

class ContactMethodTile extends StatelessWidget {
  final String tag;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const ContactMethodTile({
    super.key,
    required this.tag,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatusChip(
              label: tag,
              background: AppColors.successLight,
              textColor: AppColors.successDark,
            ),
            const SizedBox(height: AppDimensions.spacingSmall),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
                fontSize: AppDimensions.fontSizeTitleSmall,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: AppDimensions.fontSizeBodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
