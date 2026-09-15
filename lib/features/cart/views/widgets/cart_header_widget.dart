import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:flutter/material.dart';

class CartHeaderWidget extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onClear;

  const CartHeaderWidget({
    super.key,
    required this.onBack,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomBackButton(),
        const SizedBox(width: AppDimensions.spacingMedium),
        const Expanded(
          child: Text(
            'Your cart',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
              fontSize: AppDimensions.fontSizeHeadlineMedium,
            ),
          ),
        ),
        GestureDetector(
          onTap: onClear,
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.spacingXSmall,
              vertical: AppDimensions.spacingXXSmall,
            ),
            child: Text(
              'Clear',
              style: TextStyle(
                color: AppColors.error,
                fontWeight: FontWeight.w700,
                fontSize: AppDimensions.fontSizeBodyLarge,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
