import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class ClaimStepsCard extends StatelessWidget {
  final List<String> steps;

  const ClaimStepsCard({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    if (steps.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        children: List.generate(steps.length, (index) {
          final isLast = index == steps.length - 1;
          return Padding(
            padding: EdgeInsets.only(
              bottom: isLast ? 0 : AppDimensions.spacingMedium,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.successLight,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusXSmall,
                    ),
                  ),
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: AppColors.successDark,
                      fontWeight: FontWeight.w700,
                      fontSize: AppDimensions.fontSizeLabelLarge,
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.spacingMedium),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: AppText.bodyLarge(
                      steps[index],
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
