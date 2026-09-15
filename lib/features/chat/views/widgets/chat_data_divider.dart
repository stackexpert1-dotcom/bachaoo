import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:flutter/material.dart';

class ChatDateDivider extends StatelessWidget {
  final String label;

  const ChatDateDivider({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.spacingMedium,
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
            vertical: AppDimensions.spacingXXSmall,
          ),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.textMuted,
              fontWeight: FontWeight.w600,
              fontSize: AppDimensions.fontSizeLabelMedium,
            ),
          ),
        ),
      ),
    );
  }
}
