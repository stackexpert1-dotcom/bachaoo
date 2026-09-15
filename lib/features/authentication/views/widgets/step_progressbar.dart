import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:flutter/material.dart';

class StepProgressBar extends StatelessWidget {
  final int currentStep; // 1-based, e.g. 1 or 2
  final int totalSteps;

  const StepProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  /// Steps *completed* including the current one.
  double get _progress =>
      totalSteps == 0 ? 0 : (currentStep / totalSteps).clamp(0.0, 1.0);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Container(
              height: 8,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.disabledBackground,
                borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 8,
              width: constraints.maxWidth * _progress,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
              ),
            ),
          ],
        );
      },
    );
  }
}
