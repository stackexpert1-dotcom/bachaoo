import 'package:flutter/material.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class DealPriceRow extends StatelessWidget {
  final double price;
  final double originalPrice;
  final String discountPercentLabel; // e.g. "31% less"

  const DealPriceRow({
    super.key,
    required this.price,
    required this.originalPrice,
    required this.discountPercentLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            const Text(
              'Rs ',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w700,
                fontSize: AppDimensions.fontSizeTitleMedium,
              ),
            ),
            Text(
              price.toStringAsFixed(0),
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w700,
                fontSize: AppDimensions.fontSizeDisplaySmall,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Rs ${originalPrice.toStringAsFixed(0)}',
              style: const TextStyle(
                color: AppColors.textHint,
                decoration: TextDecoration.lineThrough,
                fontSize: AppDimensions.fontSizeTitleMedium,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.errorLight,
            borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
          ),
          child: Text(
            discountPercentLabel,
            style: const TextStyle(
              color: AppColors.error,
              fontWeight: FontWeight.w700,
              fontSize: AppDimensions.fontSizeBodyMedium,
            ),
          ),
        ),
      ],
    );
  }
}
