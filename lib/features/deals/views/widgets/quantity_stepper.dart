import 'package:flutter/material.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class QuantityStepper extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;
  final double? pillHeight;
  final double buttonSize;
  final double iconSize;
  final double valueWidth;
  final BorderRadius? borderRadius;
  final bool circleButtons;

  const QuantityStepper({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 1,
    this.max = 99,
    this.pillHeight = 56.0,
    this.buttonSize = 40.0,
    this.iconSize = AppDimensions.iconSizeSmall,
    this.valueWidth = 36.0,
    this.borderRadius,
    this.circleButtons = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: pillHeight,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        border: Border.all(color: AppColors.borderColor),
        borderRadius:
            borderRadius ?? BorderRadius.circular(AppDimensions.radiusRound),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepButton(
            icon: Icons.remove_rounded,
            filled: false,
            buttonSize: buttonSize,
            iconSize: iconSize,
            circle: circleButtons,
            onTap: value > min ? () => onChanged(value - 1) : null,
          ),
          SizedBox(
            width: valueWidth,
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: AppDimensions.fontSizeTitleMedium,
              ),
            ),
          ),
          _StepButton(
            icon: Icons.add_rounded,
            filled: true,
            buttonSize: buttonSize,
            iconSize: iconSize,
            circle: circleButtons,
            onTap: value < max ? () => onChanged(value + 1) : null,
          ),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  final IconData icon;
  final bool filled;
  final VoidCallback? onTap;
  final double buttonSize;
  final double iconSize;
  final bool circle;

  const _StepButton({
    required this.icon,
    required this.filled,
    this.onTap,
    this.buttonSize = 40.0,
    this.iconSize = AppDimensions.iconSizeSmall,
    this.circle = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: filled ? AppColors.primaryColor : AppColors.transparent,
          shape: circle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: circle
              ? null
              : BorderRadius.circular(AppDimensions.radiusXSmall),
          border: filled
              ? null
              : Border.all(
                  color: AppColors.borderStrong,
                  width: AppDimensions.borderWidth,
                ),
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: filled
              ? AppColors.white
              : (onTap == null ? AppColors.iconMuted : AppColors.textPrimary),
        ),
      ),
    );
  }
}

