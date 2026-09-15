import 'package:bachaoo/features/category/views/widgets/sub_category_list_items.dart'
    show SubCategoryListItem;
import 'package:flutter/material.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/category/models/sub_category_model.dart';

class SubCategoriesCard extends StatelessWidget {
  final List<SubCategoryModel> subCategories;
  final void Function(SubCategoryModel subCategory)? onSubCategoryTap;

  const SubCategoriesCard({
    super.key,
    required this.subCategories,
    this.onSubCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    if (subCategories.isEmpty) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        border: Border.all(color: AppColors.borderColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: List.generate(subCategories.length, (index) {
          final subCategory = subCategories[index];
          final isLast = index == subCategories.length - 1;

          return Column(
            children: [
              SubCategoryListItem(
                subCategory: subCategory,
                onTap: () {
                  if (subCategory.onTap != null) {
                    subCategory.onTap!();
                  } else if (onSubCategoryTap != null) {
                    onSubCategoryTap!(subCategory);
                  }
                },
              ),
              if (!isLast)
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColors.divider,
                  indent: AppDimensions.paddingMedium,
                  endIndent: AppDimensions.paddingMedium,
                ),
            ],
          );
        }),
      ),
    );
  }
}
