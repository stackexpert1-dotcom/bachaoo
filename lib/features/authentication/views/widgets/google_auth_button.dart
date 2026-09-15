import 'package:bachaoo/core/constants/bachaoo_assets.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:flutter/material.dart';

class GoogleAuthButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isLoading;

  const GoogleAuthButton({
    super.key,
    this.label = 'Continue with Google',
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeightLarge,
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        child: InkWell(
          onTap: isLoading ? null : onTap,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
              border: Border.all(
                color: AppColors.inputBorder,
                width: AppDimensions.borderWidth,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      color: AppColors.textPrimary,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.googleLogo,
                        width: AppDimensions.iconSizeMedium,
                        height: AppDimensions.iconSizeMedium,
                      ),
                      const SizedBox(width: AppDimensions.spacingSmall),
                      Text(
                        label,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: AppDimensions.fontSizeBodyLarge,
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
