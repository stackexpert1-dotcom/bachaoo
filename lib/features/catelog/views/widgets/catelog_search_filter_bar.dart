import 'package:bachaoo/common_widgets/custom_text_feild.dart';
import 'package:bachaoo/features/catelog/views/widgets/rating_category_filter_bottom_sheet.dart';
import 'package:bachaoo/features/catelog/views/widgets/sort_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/catelog/controllers/catelog_controller.dart';
import 'package:bachaoo/features/catelog/models/sort_option.dart';
import 'package:bachaoo/features/catelog/views/widgets/catelog_button_icon.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class CatalogSearchFilterBar<T> extends StatelessWidget {
  final CatalogController<T> controller;
  final String searchHint;

  const CatalogSearchFilterBar({
    super.key,
    required this.controller,
    this.searchHint = 'Search',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                hintText: searchHint,
                prefixIcon: Icon(Icons.search_rounded),
                onChanged: controller.setSearchQuery,
              ),
            ),
            const SizedBox(width: AppDimensions.spacingSmall),
            Obx(
              () => CatalogIconButton(
                icon: Icons.tune_rounded,
                isActive: controller.hasActiveFilters,
                onTap: () => RatingCategoryFilterBottomSheet.show(
                  context,
                  controller: controller,
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.spacingSmall),
            Obx(
              () => CatalogIconButton(
                icon: Icons.swap_vert_rounded,
                isActive:
                    controller.sortOption.value != SortOption.defaultOrder,
                onTap: () =>
                    SortBottomSheet.show(context, controller: controller),
              ),
            ),
          ],
        ),
        Obx(() {
          if (!controller.hasActiveFilters) return const SizedBox.shrink();
          return Padding(
            padding: const EdgeInsets.only(top: AppDimensions.spacingSmall),
            child: GestureDetector(
              onTap: controller.clearFilters,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.close_rounded,
                    size: 16,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(width: 4),
                  AppText.labelLarge(
                    'Clear filters',
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
