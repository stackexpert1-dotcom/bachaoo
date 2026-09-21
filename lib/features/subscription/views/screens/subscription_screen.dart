import 'package:bachaoo/core/constants/bachaoo_assets.dart';
import 'package:bachaoo/routes/bachaoo_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/common_widgets/member_card_preview.dart';
import 'package:bachaoo/common_widgets/primary_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool _isProcessing = false;

  // Gold plan only — hardcoded per this screen's scope. If a second
  // tier needs to come back later, reintroduce the plan-model/toggle
  // approach from the earlier version instead of adding fields here.
  static const _pricePerYear = 7500;
  static const _originalPricePerYear = 11500;
  static const _currencyUnit =
      'PTS'; // matches the reference image — confirm vs "Rs" with design
  static const _benefits = [
    'Exclusive Discounts',
    'Cashback Rewards',
    'Priority Access',
  ];

  Future<void> _completeCheckout() async {
    // setState(() => _isProcessing = true);
    // // TODO: replace with real payment/subscription API call.
    // await Future.delayed(const Duration(seconds: 2));
    // if (!mounted) return;
    // setState(() => _isProcessing = false);
    Get.toNamed(AppRoutes.paymentSubmissionScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // FIX: same dark primary-color gradient as LoginRequiredScreen,
        // per "background should be primary color with gradient".
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF10321C), Color(0xFF0A2313), Color(0xFF071A0E)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.pagePadding,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: AppDimensions.spacingSmall),

                  // --- Logo row ---
                  Row(
                    children: [
                      const CustomBackButton(),
                      const SizedBox(width: AppDimensions.spacingMedium),
                      Container(
                        width: 44,
                        height: 44,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusMedium,
                          ),
                        ),
                        child: Image.asset(AppAssets.bachaooLogo),
                      ),
                      const SizedBox(width: AppDimensions.spacingMedium),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'BACHAOO!',
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: AppDimensions.fontSizeTitleLarge,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            'Bachat Ka "س" On Hai',
                            style: TextStyle(
                              color: AppColors.white.withValues(alpha: 0.7),
                              fontSize: AppDimensions.fontSizeBodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: AppDimensions.spacingXXLarge),

                  // --- Card preview: shared widget, tagged Gold ---
                  const MemberCardPreview(membershipTier: 'Gold'),

                  const SizedBox(height: AppDimensions.spacingXXLarge),

                  // --- Gold plan badge ---
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC46B7C),
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusLarge,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.emoji_events_rounded,
                          color: AppColors.secondaryColor,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Gold Plan',
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: AppDimensions.fontSizeTitleMedium,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppDimensions.spacingLarge),

                  // --- Headline ---
                  const Text(
                    'Upgrade Now for Exclusive Discounts',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: AppDimensions.fontSizeHeadlineLarge,
                      height: AppDimensions.lineHeightTight,
                    ),
                  ),

                  const SizedBox(height: AppDimensions.spacingLarge),

                  // --- Price ---
                  Text(
                    '$_currencyUnit ${_formatNumber(_pricePerYear)}/ year',
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: AppDimensions.fontSizeHeadlineMedium,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$_currencyUnit ${_formatNumber(_originalPricePerYear)}/ year',
                    style: TextStyle(
                      color: AppColors.secondaryColor.withValues(alpha: 0.8),
                      decoration: TextDecoration.lineThrough,
                      fontWeight: FontWeight.w600,
                      fontSize: AppDimensions.fontSizeTitleMedium,
                    ),
                  ),

                  const SizedBox(height: AppDimensions.spacingLarge),

                  // --- Benefits ---
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final benefit in _benefits)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.check_rounded,
                                color: AppColors.secondaryColor,
                                size: 22,
                              ),
                              const SizedBox(width: AppDimensions.spacingSmall),
                              Text(
                                benefit,
                                style: TextStyle(
                                  color: AppColors.white.withValues(
                                    alpha: 0.85,
                                  ),
                                  fontWeight: FontWeight.w600,
                                  fontSize: AppDimensions.fontSizeTitleMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: AppDimensions.spacingXXLarge),

                  // --- Checkout — single button, no second "already have
                  // account" outline button, per the request. ---
                  PrimaryButton(
                    label: 'Complete Checkout',
                    backgroundColor: AppColors.secondaryColor,
                    textColor: AppColors.primaryColor,
                    isLoading: _isProcessing,
                    onTap: _isProcessing ? null : _completeCheckout,
                  ),

                  const SizedBox(height: AppDimensions.spacingLarge),

                  // --- Legal footer ---
                  Text(
                    'This subscription auto-renews at the end of each year term at '
                    '$_currencyUnit ${_formatNumber(_pricePerYear)}, unless cancelled '
                    '24-hours in advance. The fee is charged to your account at '
                    'confirmation of purchase. You may manage your subscriptions and '
                    'turn off the auto-renewal by going to your Settings. No cancellation '
                    'of the current subscription is allowed during active subscription '
                    'period. By joining you accept our Terms of Use and Privacy Policy.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.white.withValues(alpha: 0.55),
                      fontSize: AppDimensions.fontSizeBodySmall,
                      height: AppDimensions.lineHeightRelaxed,
                    ),
                  ),

                  const SizedBox(height: AppDimensions.spacingLarge),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatNumber(int value) {
    final str = value.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buffer.write(',');
      buffer.write(str[i]);
    }
    return buffer.toString();
  }
}
