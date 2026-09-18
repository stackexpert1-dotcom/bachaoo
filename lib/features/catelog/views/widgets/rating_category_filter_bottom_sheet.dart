import 'package:bachaoo/features/catelog/controllers/catelog_controller.dart';
import 'package:bachaoo/features/catelog/models/catelog_filter_constants.dart';
import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class RatingCategoryFilterBottomSheet<T> extends StatefulWidget {
  final CatalogController<T> controller;

  const RatingCategoryFilterBottomSheet({super.key, required this.controller});

  static Future<void> show<T>(
    BuildContext context, {
    required CatalogController<T> controller,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          RatingCategoryFilterBottomSheet<T>(controller: controller),
    );
  }

  @override
  State<RatingCategoryFilterBottomSheet<T>> createState() =>
      _RatingCategoryFilterBottomSheetState<T>();
}

class _RatingCategoryFilterBottomSheetState<T>
    extends State<RatingCategoryFilterBottomSheet<T>> {
  late int? _stagedRating;
  late Set<String> _stagedCategories;

  @override
  void initState() {
    super.initState();
    _stagedRating = widget.controller.minRating.value;
    _stagedCategories = {...widget.controller.selectedCategories};
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
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
          AppText.titleLarge('Filters'),
          AppDimensions.verticalSpace12,
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppDimensions.verticalSpace20,
                  AppText.titleLarge('Ratings'),
                  for (final option in CatalogRatings.all)
                    _RatingRow(
                      label: option.label,
                      isSelected: _stagedRating == option.value,
                      onTap: () => setState(() {
                        // Tapping the already-selected option clears it,
                        // same "only one, or none" behavior as before.
                        _stagedRating = _stagedRating == option.value
                            ? null
                            : option.value;
                      }),
                    ),

                  AppDimensions.verticalSpace16,
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColors.divider,
                  ),
                  AppDimensions.verticalSpace20,

                  AppText.titleLarge('Categories'),
                  // FIX: multi-select list rows with a checkbox square.
                  for (final category in CatalogCategories.all)
                    _CategoryRow(
                      label: category,
                      isSelected: _stagedCategories.contains(category),
                      onTap: () => setState(() {
                        if (_stagedCategories.contains(category)) {
                          _stagedCategories.remove(category);
                        } else {
                          _stagedCategories.add(category);
                        }
                      }),
                    ),
                ],
              ),
            ),
          ),
          AppDimensions.verticalSpace16,
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => setState(() {
                    _stagedRating = null;
                    _stagedCategories = {};
                  }),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: AppColors.borderColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusRound,
                      ),
                    ),
                  ),
                  child: AppText.labelLarge('Clear all'),
                ),
              ),
              const SizedBox(width: AppDimensions.spacingMedium),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.controller.applyFilters(
                      rating: _stagedRating,
                      categories: _stagedCategories,
                    );
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusRound,
                      ),
                    ),
                    elevation: 0,
                  ),
                  child: AppText.labelLarge('Apply', color: AppColors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Ratings row: label + a plain radio-style circle on the right.
/// Whole row is the tap target — the circle itself is purely visual
/// (IgnorePointer) so there's no separate, smaller tap zone.
class _RatingRow extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _RatingRow({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: AppText.bodyLarge(label, color: AppColors.textPrimary),
            ),
            _RadioCircle(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}

class _RadioCircle extends StatelessWidget {
  final bool isSelected;

  const _RadioCircle({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected
              ? AppColors.primaryColor
              : AppColors.textPrimary.withValues(alpha: 0.7),
          width: 2,
        ),
      ),
      alignment: Alignment.center,
      child: isSelected
          ? Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor,
              ),
            )
          : null,
    );
  }
}

/// Categories row: label + a plain checkbox-style square on the right.
/// Same full-row tap target pattern as _RatingRow.
class _CategoryRow extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryRow({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: AppText.bodyLarge(label, color: AppColors.textPrimary),
            ),
            _CheckboxSquare(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}

class _CheckboxSquare extends StatelessWidget {
  final bool isSelected;

  const _CheckboxSquare({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: isSelected ? AppColors.primaryColor : Colors.transparent,
        border: Border.all(
          color: isSelected
              ? AppColors.primaryColor
              : AppColors.textPrimary.withValues(alpha: 0.7),
          width: 2,
        ),
      ),
      alignment: Alignment.center,
      child: isSelected
          ? const Icon(Icons.check_rounded, size: 16, color: AppColors.white)
          : null,
    );
  }
}
