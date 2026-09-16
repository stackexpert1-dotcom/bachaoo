import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:flutter/material.dart';

class CartSummaryCard extends StatelessWidget {
  final int dealCount;
  final String subtotal;
  final String savings;
  final String total;
  final String currency;

  const CartSummaryCard({
    super.key,
    required this.dealCount,
    required this.subtotal,
    required this.savings,
    required this.total,
    this.currency = 'Rs',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SummaryRow(
            label: '$dealCount deals',
            value: '$currency $subtotal',
            labelColor: AppColors.textSecondary,
            valueWeight: FontWeight.w700,
          ),
          const SizedBox(height: AppDimensions.spacingSmall),
          _SummaryRow(
            label: 'Bachaoo saving',
            value: '\u2212 $currency $savings',
            labelColor: AppColors.textSecondary,
            valueColor: AppColors.success,
            valueWeight: FontWeight.w700,
          ),
          const SizedBox(height: AppDimensions.spacingMedium),
          const _DashedDivider(),
          const SizedBox(height: AppDimensions.spacingMedium),
          _SummaryRow(
            label: 'You pay',
            value: '$currency $total',
            labelColor: AppColors.textPrimary,
            labelWeight: FontWeight.w600,
            valueColor: AppColors.primaryColor,
            valueFontSize: AppDimensions.fontSizeHeadlineSmall,
            valueWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color labelColor;
  final Color? valueColor;
  final FontWeight labelWeight;
  final FontWeight valueWeight;
  final double valueFontSize;

  const _SummaryRow({
    required this.label,
    required this.value,
    required this.labelColor,
    this.valueColor,
    this.labelWeight = FontWeight.w600,
    this.valueWeight = FontWeight.w700,
    this.valueFontSize = AppDimensions.fontSizeTitleSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: labelColor,
            fontWeight: labelWeight,
            fontSize: AppDimensions.fontSizeBodyLarge,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? AppColors.textPrimary,
            fontWeight: valueWeight,
            fontSize: valueFontSize,
          ),
        ),
      ],
    );
  }
}

class _DashedDivider extends StatelessWidget {
  const _DashedDivider();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const dashWidth = 6.0;
        const dashSpace = 4.0;
        final dashCount = (constraints.maxWidth / (dashWidth + dashSpace))
            .floor();
        return Row(
          children: List.generate(dashCount, (_) {
            return Padding(
              padding: const EdgeInsets.only(right: dashSpace),
              child: Container(
                width: dashWidth,
                height: AppDimensions.dividerThickness,
                color: AppColors.borderStrong,
              ),
            );
          }),
        );
      },
    );
  }
}
