import 'package:bachaoo/features/catelog/controllers/catelog_controller.dart';
import 'package:bachaoo/features/catelog/models/sort_option.dart';
import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class SortBottomSheet<T> extends StatelessWidget {
  final CatalogController<T> controller;

  const SortBottomSheet({super.key, required this.controller});

  static Future<void> show<T>(
    BuildContext context, {
    required CatalogController<T> controller,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SortBottomSheet<T>(controller: controller),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: AppDimensions.pagePaddingSmall,
        right: AppDimensions.pagePaddingSmall,
        top: AppDimensions.spacingSmall,
        bottom:
            MediaQuery.of(context).padding.bottom +
            AppDimensions.pagePaddingSmall,
      ),
      decoration: const BoxDecoration(
        color: AppColors.appBackroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.bottomSheetRadius),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(
                bottom: AppDimensions.spacingMedium,
              ),
              decoration: BoxDecoration(
                color: AppColors.disabledBackground,
                borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
              ),
            ),
          ),
          AppText.titleLarge('Sort by'),
          AppDimensions.verticalSpace12,
          // Tapping a row selects it and closes immediately — sort is a
          // single choice, so there's no need for a separate Apply step.
          Obx(
            () => Column(
              children: [
                for (final option in SortOption.values) _row(context, option),
              ],
            ),
          ),
          AppDimensions.verticalSpace12,
        ],
      ),
    );
  }

  Widget _row(BuildContext context, SortOption option) {
    final isSelected = controller.sortOption.value == option;
    return GestureDetector(
      onTap: () {
        controller.setSortOption(option);
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: AppText.bodyLarge(
                option.label,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.textPrimary,
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.primaryColor,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
