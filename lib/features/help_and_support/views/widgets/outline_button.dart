import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:flutter/material.dart';

class OutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const OutlineButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceColor,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        child: Container(
          height: AppDimensions.buttonHeightSmall,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.buttonHorizontalPadding,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderStrong),
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: AppDimensions.fontSizeBodyMedium,
            ),
          ),
        ),
      ),
    );
  }
}
