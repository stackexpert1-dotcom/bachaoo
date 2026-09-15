import 'package:bachaoo/features/category/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/category/views/widgets/category_card.dart';

class CategoriesGrid extends StatelessWidget {
  final List<CategoryModel> categories;
  final void Function(int index, CategoryModel category)? onCategoryTap;

  /// When true, only categories with `isFeatured == true` are shown.
  /// Use this on the home screen; leave it false on the "See All" screen
  /// so every category is listed regardless of admin's featured picks.
  final bool featuredOnly;

  /// Caps how many cards are rendered. Pass 6 on the home screen; leave
  /// it null on "See All" to show everything with no limit.
  final int? maxItems;

  const CategoriesGrid({
    super.key,
    required this.categories,
    this.onCategoryTap,
    this.featuredOnly = false,
    this.maxItems,
  });

  @override
  Widget build(BuildContext context) {
    final filtered = featuredOnly
        ? categories.where((c) => c.isFeatured).toList()
        : categories;

    final visible = maxItems != null
        ? filtered.take(maxItems!).toList()
        : filtered;

    if (visible.isEmpty) return const SizedBox.shrink();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: visible.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: AppDimensions.spacingSmall,
        mainAxisSpacing: AppDimensions.spacingSmall,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final category = visible[index];
        return CategoryCard(
          category: category,
          index: index,
          onTap: onCategoryTap,
        );
      },
    );
  }
}
