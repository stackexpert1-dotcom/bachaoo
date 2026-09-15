import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBackButton extends StatelessWidget {
  final double size;
  final double iconSize;
  final VoidCallback? onTap;

  const CustomBackButton({
    super.key,
    this.size = 40,
    this.iconSize = 24,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => Get.back(),
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          Icons.chevron_left_rounded,
          color: AppColors.textPrimary,
          size: iconSize,
        ),
      ),
    );
  }
}
