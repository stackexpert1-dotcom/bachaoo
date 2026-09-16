import 'package:bachaoo/common_widgets/primary_button.dart';
import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:flutter/material.dart';

class LoginRequiredScreen extends StatelessWidget {
  final VoidCallback onCreateCard;
  final VoidCallback onHaveAccount;

  const LoginRequiredScreen({
    super.key,
    required this.onCreateCard,
    required this.onHaveAccount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusMedium,
                        ),
                      ),
                      child: const Text(
                        'B',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: AppDimensions.fontSizeTitleLarge,
                        ),
                      ),
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
                          'Bachat Ka "\u0633" On Hai',
                          style: TextStyle(
                            color: AppColors.white.withValues(alpha: 0.7),
                            fontSize: AppDimensions.fontSizeBodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const Spacer(flex: 3),

                // --- Card preview ---
                const MemberCardPreview(),

                const Spacer(flex: 3),

                // --- Headline + copy ---
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Save at 140+ places across Sargodha.',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: AppDimensions.fontSizeHeadlineLarge,
                      height: AppDimensions.lineHeightTight,
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.spacingMedium),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Scan the Bachaoo QR at the counter, pick a deal, '
                    'pay less \u2014 restaurants, pharmacies, workshops, '
                    'salons and more.',
                    style: TextStyle(
                      color: AppColors.white.withValues(alpha: 0.75),
                      fontSize: AppDimensions.fontSizeBodyLarge,
                      height: AppDimensions.lineHeightRelaxed,
                    ),
                  ),
                ),

                const Spacer(flex: 4),

                // --- Buttons ---
                PrimaryButton(
                  label: 'Create your card',
                  backgroundColor: AppColors.secondaryColor,
                  textColor: AppColors.primaryColor,
                  onTap: onCreateCard,
                ),
                const SizedBox(height: AppDimensions.spacingMedium),
                DarkOutlineButton(
                  label: 'I already have an account',
                  onTap: onHaveAccount,
                ),

                const SizedBox(height: AppDimensions.spacingLarge),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DarkOutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const DarkOutlineButton({super.key, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeightLarge,
      child: Material(
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              border: Border.all(color: AppColors.white.withValues(alpha: 0.3)),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
                fontSize: AppDimensions.buttonTextSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MemberCardPreview extends StatelessWidget {
  final String membershipTier;
  final String nameLine;
  final String referralPlaceholder;
  final String validTillLabel;

  const MemberCardPreview({
    super.key,
    this.membershipTier = 'Standard',
    this.nameLine = 'Shafqat Ullah',
    this.referralPlaceholder = '\u2022\u2022\u2022\u2022\u2022\u2022\u2022',
    this.validTillLabel = 'Valid till 31 Dec 2026',
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.035,
      child: AspectRatio(
        aspectRatio: 1.6,
        child: Container(
          padding: const EdgeInsets.all(AppDimensions.paddingLarge),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryColor.withValues(alpha: 0.9),
                const Color(0xFF0F3319),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.35),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Stack(
            children: [
              // faint watermark glyph, bottom-right
              Positioned(
                right: -6,
                bottom: -10,
                child: Text(
                  '\u0633',
                  style: TextStyle(
                    fontSize: 90,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white.withValues(alpha: 0.06),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'BACHAOO!',
                              style: TextStyle(
                                color: AppColors.secondaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: AppDimensions.fontSizeTitleMedium,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Text(
                              'MEMBER CARD',
                              style: TextStyle(
                                color: AppColors.white.withValues(alpha: 0.75),
                                fontWeight: FontWeight.w700,
                                fontSize: AppDimensions.fontSizeLabelSmall,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingMedium,
                          vertical: AppDimensions.spacingXXSmall,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusSmall,
                          ),
                          border: Border.all(
                            color: AppColors.secondaryColor.withValues(
                              alpha: 0.6,
                            ),
                          ),
                        ),
                        child: Text(
                          membershipTier,
                          style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: AppDimensions.fontSizeLabelMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: 34,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacingSmall),
                  Text(
                    nameLine,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: AppDimensions.fontSizeTitleLarge,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacingXSmall),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Referral code',
                              style: TextStyle(
                                color: AppColors.white.withValues(alpha: 0.65),
                                fontSize: AppDimensions.fontSizeBodySmall,
                              ),
                            ),
                            // const SizedBox(height: 2),
                            AppDimensions.verticalSpace1,
                            Text(
                              referralPlaceholder,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: AppDimensions.fontSizeBodyMedium,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            validTillLabel,
                            style: TextStyle(
                              color: AppColors.white.withValues(alpha: 0.65),
                              fontSize: AppDimensions.fontSizeBodySmall,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            width: 28,
                            height: 1.5,
                            color: AppColors.white.withValues(alpha: 0.6),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
