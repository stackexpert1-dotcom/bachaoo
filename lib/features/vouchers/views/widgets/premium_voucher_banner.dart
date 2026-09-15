import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class PremiumVoucherBanner extends StatelessWidget {
  final int currentPoints;
  final int targetPoints;
  final String description;
  final VoidCallback onReferFriend;

  const PremiumVoucherBanner({
    super.key,
    required this.currentPoints,
    required this.targetPoints,
    required this.description,
    required this.onReferFriend,
  });

  double get _progress =>
      targetPoints == 0 ? 0 : (currentPoints / targetPoints).clamp(0, 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingXLarge),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.titleLarge(
            'Premium vouchers',
            color: AppColors.textOnPrimary,
          ),
          AppDimensions.verticalSpace8,
          AppText(
            description,
            style: TextStyle(
              fontSize: AppDimensions.fontSizeBodyMedium,
              fontWeight: FontWeight.w400,
              color: AppColors.textOnPrimary.withOpacity(0.85),
              height: AppDimensions.lineHeightRelaxed,
            ),
          ),
          AppDimensions.verticalSpace20,
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
            child: LinearProgressIndicator(
              value: _progress,
              minHeight: 8,
              backgroundColor: AppColors.textOnPrimary.withOpacity(0.18),
              valueColor: const AlwaysStoppedAnimation(
                AppColors.secondaryColor,
              ),
            ),
          ),
          AppDimensions.verticalSpace24,
          ElevatedButton(
            onPressed: onReferFriend,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryColor,
              foregroundColor: AppColors.textOnSecondary,
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.buttonHorizontalPadding,
              ),
              minimumSize: const Size(0, AppDimensions.buttonHeightSmall),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
              ),
              elevation: 0,
            ),
            child: AppText.labelLarge(
              'Refer a friend',
              color: AppColors.textOnSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
