import 'package:bachaoo/common_widgets/checkbox.dart';
import 'package:bachaoo/common_widgets/custom_text_feild.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:flutter/material.dart';

class ReferralCodeCard extends StatelessWidget {
  final bool referredMe;
  final ValueChanged<bool> onReferredChanged;
  final TextEditingController codeController;
  final bool isValid;

  const ReferralCodeCard({
    super.key,
    required this.referredMe,
    required this.onReferredChanged,
    required this.codeController,
    this.isValid = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.warningLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Checkbox + title + subtitle ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCheckbox(value: referredMe, onChanged: onReferredChanged),
              const SizedBox(width: AppDimensions.spacingSmall),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Someone referred me',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: AppDimensions.fontSizeTitleSmall,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "They earn 1,000 points when you join free for you.",
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: AppDimensions.fontSizeBodyMedium,
                        height: AppDimensions.lineHeightNormal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (referredMe) ...[
            const SizedBox(height: AppDimensions.spacingMedium),
            CustomTextFormField(
              controller: codeController,
              hintText: 'Enter referral code',
              // borderColor: AppColors.borderSecondary,
              textStyle: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: AppDimensions.fontSizeBodyLarge,
                letterSpacing: 1.2,
              ),
              suffixIcon: isValid
                  ? const Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Valid',
                            style: TextStyle(
                              color: AppColors.success,
                              fontWeight: FontWeight.w700,
                              fontSize: AppDimensions.fontSizeBodyMedium,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.check_rounded,
                            color: AppColors.success,
                            size: 16,
                          ),
                        ],
                      ),
                    )
                  : null,
            ),
          ],
        ],
      ),
    );
  }
}
