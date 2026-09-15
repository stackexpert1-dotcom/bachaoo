import 'package:flutter/material.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class DiscountTagsRow extends StatelessWidget {
  final List<String> tags;

  const DiscountTagsRow({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: AppDimensions.spacingSmall,
      runSpacing: AppDimensions.spacingSmall,
      children: tags.map((tag) {
        final colors = _colorsFor(tag);
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: colors.$1,
            borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
          ),
          child: Text(
            tag,
            style: TextStyle(
              color: colors.$2,
              fontWeight: FontWeight.w700,
              fontSize: AppDimensions.fontSizeBodySmall,
            ),
          ),
        );
      }).toList(),
    );
  }

  // Returns (background, text) colors based on what the tag describes.
  // Falls back to a neutral scheme for anything unrecognized, so a new
  // tag string from the backend never renders unstyled.
  (Color, Color) _colorsFor(String tag) {
    final lower = tag.toLowerCase();
    if (lower.contains('cap') || lower.contains('limit')) {
      return (AppColors.errorLight, AppColors.error);
    }
    if (lower.contains('cash') || lower.contains('card')) {
      return (AppColors.warningLight, AppColors.warningDark);
    }
    if (lower.contains('dine') || lower.contains('takeaway')) {
      return (AppColors.successLight, AppColors.successDark);
    }
    return (AppColors.disabledBackground, AppColors.textSecondary);
  }
}
