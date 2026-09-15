import 'package:bachaoo/features/discounts/models/discount_model.dart';
import 'package:bachaoo/features/discounts/views/widgets/discount_card.dart';
import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class PopularDiscountsSection extends StatelessWidget {
  final List<DiscountModel> discounts;
  final void Function(DiscountModel discount)? onDiscountTap;
  final VoidCallback? onSeeAllTap;

  const PopularDiscountsSection({
    super.key,
    required this.discounts,
    this.onDiscountTap,
    this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    if (discounts.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Header (host screen applies the shared horizontal padding) ---
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText.headlineXSmall('Popular discounts'),
            GestureDetector(
              onTap: onSeeAllTap,
              child: AppText.bodySmall(
                'See All',
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        AppDimensions.verticalSpace16,

        // --- Horizontal list ---
        SizedBox(
          height: 236,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemCount: discounts.length,
            separatorBuilder: (context, index) =>
                const SizedBox(width: AppDimensions.spacingMedium),
            itemBuilder: (context, index) {
              final discount = discounts[index];
              return DiscountCard(
                discount: discount,
                onTap: onDiscountTap == null
                    ? null
                    : () => onDiscountTap!(discount),
              );
            },
          ),
        ),
      ],
    );
  }
}
