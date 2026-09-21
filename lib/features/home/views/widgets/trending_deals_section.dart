import 'package:bachaoo/features/deals/models/deal_model.dart';
import 'package:bachaoo/features/deals/views/widgets/deal_card.dart';
import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class TrendingDealsSection extends StatefulWidget {
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
  State<TrendingDealsSection> createState() => _TrendingDealsSectionState();
}

class _TrendingDealsSectionState extends State<TrendingDealsSection> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // FIX: was .take(4) — the grid needed exactly 4 to fill a 2x2 layout.
    // A slider has no such cap; every admin-flagged home deal is swipeable.
    final homeDeals = widget.deals.where((d) => d.showOnHome).toList()
      ..sort((a, b) => (a.homePriority ?? 0).compareTo(b.homePriority ?? 0));

    if (homeDeals.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText.headlineXSmall('Trending deals'),
            GestureDetector(
              onTap: widget.onSeeAllTap,
              child: AppText.bodySmall(
                'See all',
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        AppDimensions.verticalSpace16,

        // FIX: was a shrinkWrap GridView (2x2) — now a full-width, one
        // card at a time PageView. viewportFraction: 1.0 means each
        // card takes the entire available width, matching "should come
        // full on screen".
        SizedBox(
          height: 320,
          child: PageView.builder(
            controller: _pageController,
            itemCount: homeDeals.length,
            itemBuilder: (context, index) {
              final deal = homeDeals[index];
              return Padding(
                // A little horizontal inset so the card doesn't touch
                // the screen edges even at full "page" width.
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: DealCard.fromDeal(
                  deal,
                  onTap: widget.onDealTap == null
                      ? null
                      : () => widget.onDealTap!(deal),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
