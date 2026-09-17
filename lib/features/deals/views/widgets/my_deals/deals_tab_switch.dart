import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class DealsTabSwitch extends StatelessWidget {
  final int selectedIndex;
  final int activeCount;
  final int historyCount;
  final ValueChanged<int> onChanged;

  const DealsTabSwitch({
    super.key,
    required this.selectedIndex,
    required this.activeCount,
    required this.historyCount,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.successLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
      ),
      child: Row(
        children: [
          Expanded(child: _segment(label: 'Active · $activeCount', index: 0)),
          Expanded(child: _segment(label: 'History · $historyCount', index: 1)),
        ],
      ),
    );
  }

  Widget _segment({required String label, required int index}) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onChanged(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: AppText.titleSmall(
          label,
          color: isSelected ? AppColors.successDark : AppColors.textSecondary,
        ),
      ),
    );
  }
}
