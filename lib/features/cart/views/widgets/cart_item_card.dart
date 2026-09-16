import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/deals/views/widgets/quantity_stepper.dart';
import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String currentPrice;
  final String originalPrice;
  final String currency;
  final int quantity;
  final ValueChanged<int> onQuantityChanged;

  const CartItemCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.currentPrice,
    required this.originalPrice,
    required this.quantity,
    required this.onQuantityChanged,
    this.currency = 'Rs',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.cardImageRadius),
            child: Image.network(
              imageUrl,
              width: AppDimensions.imageSmall,
              height: AppDimensions.imageSmall,
              fit: BoxFit.fitHeight,
              errorBuilder: (_, __, ___) => Container(
                width: AppDimensions.imageSmall,
                height: AppDimensions.imageSmall,
                color: AppColors.disabledBackground,
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.spacingSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: AppDimensions.fontSizetitleXSmall,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 1,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppDimensions.fontSizeBodyXSmall,
                    // height: AppDimensions.lineHeightNormal,
                  ),
                ),
                const SizedBox(height: AppDimensions.spacingXXSmall),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      currency,
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: AppDimensions.fontSizeBodySmall,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      currentPrice,
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: AppDimensions.fontSizeTitleMedium,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      originalPrice,
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: AppDimensions.fontSizeBodyMedium,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: AppDimensions.spacingSmall),
          QuantityStepper(
            value: quantity,
            onChanged: onQuantityChanged,
            pillHeight: 36,
            buttonSize: 26,
            iconSize: AppDimensions.iconSizeXSmall,
            valueWidth: 30,
            borderRadius: BorderRadius.circular(AppDimensions.radiusXSmall),
            circleButtons: false,
          ),
        ],
      ),
    );
  }
}
