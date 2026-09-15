import 'package:bachaoo/common_widgets/checkmark_badg.dart';
import 'package:bachaoo/routes/bachaoo_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bachaoo/common_widgets/primary_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class DiscountConfirmedScreen extends StatelessWidget {
  final String businessName;
  final String? businessLogoUrl;
  final double discountAmount;
  final double totalSavedAllTime;
  final int visitCount;
  final VoidCallback? onRateTap;
  final VoidCallback? onBackToHomeTap;

  const DiscountConfirmedScreen({
    super.key,
    required this.businessName,
    this.businessLogoUrl,
    required this.discountAmount,
    required this.totalSavedAllTime,
    required this.visitCount,
    this.onRateTap,
    this.onBackToHomeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.pagePaddingSmall),
          child: Column(
            children: [
              AppDimensions.verticalSpace48,

              const CheckmarkBadge(),
              AppDimensions.verticalSpace24,

              Text(
                'Discount confirmed',
                style: TextStyle(
                  color: AppColors.white.withValues(alpha: 0.85),
                  fontSize: AppDimensions.fontSizeBodyLarge,
                ),
              ),
              const SizedBox(height: 8),

              // --- Rs amount ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const Text(
                    'Rs',
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: AppDimensions.fontSizeTitleLarge,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    discountAmount.toStringAsFixed(0),
                    style: const TextStyle(
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 56,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
              AppDimensions.verticalSpace16,

              // --- Business row ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusMedium,
                    ),
                    child: businessLogoUrl != null
                        ? Image.network(
                            businessLogoUrl!,
                            width: 36,
                            height: 36,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _logoPlaceholder(),
                          )
                        : _logoPlaceholder(),
                  ),
                  const SizedBox(width: AppDimensions.spacingSmall),
                  Flexible(
                    child: Text(
                      'saved at $businessName',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: AppDimensions.fontSizeBodyLarge,
                      ),
                    ),
                  ),
                ],
              ),
              AppDimensions.verticalSpace24,

              // --- Stat pills ---
              Row(
                children: [
                  Expanded(
                    child: _StatPill(
                      value: 'Rs ${totalSavedAllTime.toStringAsFixed(0)}',
                      label: 'Saved all time',
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacingMedium),
                  Expanded(
                    child: _StatPill(value: '$visitCount', label: 'Visits'),
                  ),
                ],
              ),
              AppDimensions.verticalSpace24,

              // --- Tagline ---
              Text.rich(
                TextSpan(
                  style: TextStyle(
                    color: AppColors.white.withValues(alpha: 0.7),
                    fontSize: AppDimensions.fontSizeBodyMedium,
                  ),
                  children: const [
                    TextSpan(text: 'Bachat Ka '),
                    TextSpan(
                      text: '"س"',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(text: ' On Hai'),
                  ],
                ),
              ),

              const Spacer(),

              // --- Buttons ---
              PrimaryButton(
                label: 'Rate $businessName',
                backgroundColor: AppColors.secondaryColor,
                textColor: AppColors.primaryColor,
                onTap: onRateTap ?? () {},
              ),
              AppDimensions.verticalSpace12,
              PrimaryButton(
                label: 'Back to home',
                backgroundColor: AppColors.white.withValues(alpha: 0.15),
                textColor: AppColors.white,
                onTap: onBackToHomeTap ?? () => Get.offAllNamed(AppRoutes.homeScreen),
              ),
              AppDimensions.verticalSpace12,
            ],
          ),
        ),
      ),
    );
  }

  Widget _logoPlaceholder() {
    return Container(
      width: 36,
      height: 36,
      color: AppColors.white.withValues(alpha: 0.2),
    );
  }
}

class _StatPill extends StatelessWidget {
  final String value;
  final String label;

  const _StatPill({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.paddingMedium,
      ),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w800,
              fontSize: AppDimensions.fontSizeTitleLarge,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: AppColors.white.withValues(alpha: 0.7),
              fontSize: AppDimensions.fontSizeBodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
