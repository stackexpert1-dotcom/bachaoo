import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isLoading;
  final bool isEnabled;
  final Color backgroundColor;
  final Color textColor;
  final double? width;
  final IconData? icon;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isLoading = false,
    this.isEnabled = true,
    this.backgroundColor = AppColors.primaryColor,
    this.textColor = AppColors.textOnPrimary,
    this.width,
    this.icon,
  });

  bool get _disabled => !isEnabled || isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: AppDimensions.buttonHeightLarge,
      child: Material(
        color: _disabled ? AppColors.disabledBackground : backgroundColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        child: InkWell(
          onTap: _disabled ? null : onTap,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      color: textColor,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) ...[
                        Icon(
                          icon,
                          color: textColor,
                          size: AppDimensions.buttonIconSize,
                        ),
                        const SizedBox(width: AppDimensions.spacingXSmall),
                      ],
                      Text(
                        label,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: AppDimensions.buttonTextSize,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
