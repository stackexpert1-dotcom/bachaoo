import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class IncludedItemsCard extends StatelessWidget {
  final List<String> items;

  const IncludedItemsCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        border: Border.all(color: AppColors.borderColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: List.generate(items.length, (index) {
          final isLast = index == items.length - 1;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingMedium,
                  vertical: AppDimensions.paddingMedium,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.secondaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.spacingMedium),
                    Expanded(child: AppText.titleSmall(items[index])),
                  ],
                ),
              ),
              if (!isLast)
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColors.divider,
                ),
            ],
          );
        }),
      ),
    );
  }
}
