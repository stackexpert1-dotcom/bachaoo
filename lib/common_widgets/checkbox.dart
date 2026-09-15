import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double size;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: value ? AppColors.primaryColor : AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusXSmall),
          border: Border.all(
            color: value
                ? AppColors.primaryColor
                : AppColors.primaryColor.withValues(alpha: 0.35),
            width: 1.5,
          ),
        ),
        child: value
            ? const Icon(Icons.check_rounded, color: AppColors.white, size: 16)
            : null,
      ),
    );
  }
}
