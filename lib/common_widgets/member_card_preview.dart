import 'package:flutter/material.dart';
import 'package:bachaoo/core/constants/bachaoo_assets.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

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
              // Add a celebratory member illustration to the subscription
              // card, with a right-edge crop that preserves the card details.
              Positioned(
                right: 16,
                top: 30,
                bottom: 36,
                child: Image.asset(
                  AppAssets.loginRequiredScreenquala,
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.centerRight,
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
