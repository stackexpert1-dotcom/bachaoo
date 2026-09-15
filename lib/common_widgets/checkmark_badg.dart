import 'package:flutter/material.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';

class CheckmarkBadge extends StatelessWidget {
  final double size;

  const CheckmarkBadge({super.key, this.size = 140});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.secondaryColor.withValues(alpha: 0.25),
        shape: BoxShape.circle,
      ),
      child: Container(
        width: size * 0.72,
        height: size * 0.72,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.secondaryColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.check_rounded,
          color: AppColors.primaryColor,
          size: size * 0.4,
        ),
      ),
    );
  }
}
