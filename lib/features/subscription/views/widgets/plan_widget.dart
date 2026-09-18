import 'package:bachaoo/features/subscription/models/subscription_model.dart';
import 'package:flutter/material.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

/// The "interactive" part — tapping a plan updates the price, benefits,
/// and card preview below it in real time via the controller.
class PlanToggle extends StatelessWidget {
  final List<SubscriptionPlanModel> plans;
  final String selectedId;
  final ValueChanged<String> onSelect;

  const PlanToggle({
    super.key,
    required this.plans,
    required this.selectedId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final plan in plans) ...[
          Expanded(
            child: GestureDetector(
              onTap: () => onSelect(plan.id),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: selectedId == plan.id
                      ? AppColors.primaryColor
                      : AppColors.white,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusRound,
                  ),
                  border: Border.all(
                    color: selectedId == plan.id
                        ? AppColors.primaryColor
                        : AppColors.borderColor,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  plan.name,
                  style: TextStyle(
                    color: selectedId == plan.id
                        ? AppColors.white
                        : AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: AppDimensions.fontSizeBodyMedium,
                  ),
                ),
              ),
            ),
          ),
          if (plan != plans.last)
            const SizedBox(width: AppDimensions.spacingSmall),
        ],
      ],
    );
  }
}
