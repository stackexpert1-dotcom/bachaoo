import 'package:bachaoo/common_widgets/business_code_input.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:flutter/material.dart';

class BusinessCodeCard extends StatelessWidget {
  /// Initial value shown in the input (up to 4 digits). The row is a real
  /// input, so the customer types the staff code (e.g. 1 2 3 4) at billing.
  final String code;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;

  /// Each code box is a square of this size (width == height).
  final double boxSize;

  const BusinessCodeCard({
    super.key,
    this.code = '',
    this.onChanged,
    this.onCompleted,
    this.boxSize = AppDimensions.businessCodeBoxSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.warningLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Business code',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
              fontSize: AppDimensions.fontSizeTitleSmall,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Ask the staff for the 4-digit code at billing. It confirms your deal was honoured.',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: AppDimensions.fontSizeBodyMedium,
              height: AppDimensions.lineHeightNormal,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingMedium),
          BusinessCodeInput(
            initialValue: code,
            boxSize: boxSize,
            onChanged: onChanged,
            onCompleted: onCompleted,
          ),
        ],
      ),
    );
  }
}
