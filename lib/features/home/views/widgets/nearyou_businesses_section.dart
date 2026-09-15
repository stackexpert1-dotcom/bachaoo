import 'package:bachaoo/features/businesses/models/nearby_business_model.dart';
import 'package:bachaoo/features/businesses/views/widgets/business_card.dart';
import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class NearYouSection extends StatelessWidget {
  final List<BusinessModel> businesses;
  final void Function(BusinessModel business)? onBusinessTap;
  final VoidCallback? onMapTap;

  /// Admin controls which businesses appear here via `isFeatured`.
  /// Defaults to true so this section only ever shows admin picks.
  final bool featuredOnly;

  /// Hard cap — "Near you" only ever shows 4 businesses.
  final int maxItems;

  const NearYouSection({
    super.key,
    required this.businesses,
    this.onBusinessTap,
    this.onMapTap,
    this.featuredOnly = true,
    this.maxItems = 4,
  });

  @override
  Widget build(BuildContext context) {
    final filtered = featuredOnly
        ? businesses.where((b) => b.isFeatured).toList()
        : businesses;
    final visible = filtered.take(maxItems).toList();

    if (visible.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Header ---
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText.headlineXSmall('Near you'),
            GestureDetector(
              onTap: onMapTap,
              child: AppText.titleSmall('Map', color: AppColors.primaryColor),
            ),
          ],
        ),
        AppDimensions.verticalSpace16,

        // --- List ---
        ...List.generate(visible.length, (index) {
          final business = visible[index];
          return Padding(
            padding: EdgeInsets.only(
              bottom: index == visible.length - 1
                  ? 0
                  : AppDimensions.spacingMedium,
            ),
            child: NearbyBusinessCard(
              business: business,
              onTap: onBusinessTap == null
                  ? null
                  : () => onBusinessTap!(business),
            ),
          );
        }),
      ],
    );
  }
}
