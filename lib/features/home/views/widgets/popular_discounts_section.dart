import 'package:bachaoo/features/businesses/models/nearby_business_model.dart';
import 'package:bachaoo/features/deals/views/widgets/deal_card.dart';
import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class PopularDiscountsSection extends StatefulWidget {
  final List<BusinessModel> discounts;
  final void Function(BusinessModel discount)? onDiscountTap;
  final VoidCallback? onSeeAllTap;

  const PopularDiscountsSection({
    super.key,
    required this.discounts,
    this.onDiscountTap,
    this.onSeeAllTap,
  });

  @override
  State<PopularDiscountsSection> createState() =>
      _PopularDiscountsSectionState();
}

class _PopularDiscountsSectionState extends State<PopularDiscountsSection> {
  late final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.discounts.isEmpty) return const SizedBox.shrink();

    // The host home screen applies this horizontal padding on both sides, so
    // a full viewport here is exactly the width of one discount card.
    const parentPadding = AppDimensions.pagePaddingSmall; // 16 px
    final contentWidth = MediaQuery.of(context).size.width - parentPadding * 2;
    final cardHeight = contentWidth / 1.9 + 112;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Section header ---
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText.headlineXSmall('Popular discounts'),
            GestureDetector(
              onTap: widget.onSeeAllTap,
              child: AppText.bodySmall(
                'See All',
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        AppDimensions.verticalSpace16,

        // One full-width card per page. PageView snaps to a complete card when
        // the user releases a swipe, with no next-card peek at rest.
        SizedBox(
          height: cardHeight,
          child: PageView.builder(
            controller: _pageController,
            clipBehavior: Clip.hardEdge,
            itemCount: widget.discounts.length,
            itemBuilder: (context, index) {
              final discount = widget.discounts[index];
              return Padding(
                // Match the subtle horizontal breathing room used by the
                // Trending Deals carousel; adjacent cards stay distinct while
                // swiping without showing a next-card peek at rest.
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: DealCard.fromBusiness(
                  discount,
                  onTap: widget.onDiscountTap == null
                      ? null
                      : () => widget.onDiscountTap!(discount),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
