import 'package:bachaoo/features/deals/models/deal_model.dart';
import 'package:bachaoo/features/deals/views/widgets/deal_card.dart';
import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class TrendingDealsSection extends StatelessWidget {
  final List<DealModel> deals;
  final void Function(DealModel deal)? onDealTap;
  final VoidCallback? onSeeAllTap;

  const TrendingDealsSection({
    super.key,
    required this.deals,
    this.onDealTap,
    this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    // Only admin-flagged deals are eligible for the home grid, sorted by
    // the admin-set priority, capped at 4 to fill the 2x2 grid.
    final homeDeals = deals.where((d) => d.showOnHome).toList()
      ..sort((a, b) => (a.homePriority ?? 0).compareTo(b.homePriority ?? 0));
    final gridDeals = homeDeals.take(4).toList();

    if (gridDeals.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Header (host screen applies the shared horizontal padding) ---
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText.headlineXSmall('Trending deals'),
            GestureDetector(
              onTap: onSeeAllTap,
              child: AppText.bodySmall(
                'See all',
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        AppDimensions.verticalSpace16,

        // --- 2x2 grid ---
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: gridDeals.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: AppDimensions.spacingMedium,
            crossAxisSpacing: AppDimensions.spacingMedium,
            childAspectRatio: 0.64,
          ),
          itemBuilder: (context, index) {
            final deal = gridDeals[index];
            return DealCard(
              deal: deal,
              onTap: onDealTap == null ? null : () => onDealTap!(deal),
            );
          },
        ),
      ],
    );
  }
}
