import 'package:bachaoo/features/deals/views/widgets/quantity_stepper.dart';
import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/primary_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class DealQuantityFooter extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onQuantityChanged;
  final double unitPrice;
  final VoidCallback onAddToCart;

  const DealQuantityFooter({
    super.key,
    required this.quantity,
    required this.onQuantityChanged,
    required this.unitPrice,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final total = unitPrice * quantity;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.pagePaddingSmall,
        vertical: AppDimensions.spacingMedium,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            QuantityStepper(
              value: quantity,
              onChanged: onQuantityChanged,
              pillHeight: 50,
              borderRadius: BorderRadius.circular(AppDimensions.radiusXSmall),
              circleButtons: false,
            ),
            const SizedBox(width: AppDimensions.spacingMedium),
            Expanded(
              child: PrimaryButton(
                label: 'Add to cart · Rs ${total.toStringAsFixed(0)}',
                onTap: onAddToCart,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
