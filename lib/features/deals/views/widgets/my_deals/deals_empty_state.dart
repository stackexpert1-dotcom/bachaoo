import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_assets.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class DealsEmptyState extends StatelessWidget {
  final String memberName;
  final String tierLabel;
  final String title;
  final String subtitle;
  final String buttonLabel;
  final VoidCallback? onButtonTap;

  const DealsEmptyState({
    super.key,
    required this.memberName,
    this.tierLabel = 'Standard',
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
    this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.pagePaddingSmall,
      ),
      child: Column(
        children: [
          AppDimensions.verticalSpace48,
          _MemberCard(name: memberName, tier: tierLabel),
          AppDimensions.verticalSpace24,
          AppText.headlineSmall(title, textAlign: TextAlign.center),
          const SizedBox(height: 8),
          AppText.bodyLarge(
            subtitle,
            color: AppColors.textSecondary,
            textAlign: TextAlign.center,
          ),
          AppDimensions.verticalSpace20,
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onButtonTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusRound,
                  ),
                ),
                elevation: 0,
              ),
              child: AppText.labelLarge(buttonLabel, color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  final String name;
  final String tier;

  const _MemberCard({required this.name, required this.tier});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.05,
      child: Container(
        width: 260,
        height: 150,
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1F4436), Color(0xFF0F2A20)],
          ),
          borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Faint decorative watermark — reuses the app logo at low
            // opacity for the same effect the reference has. Swap for
            // a dedicated mark asset if you have one.
            Positioned(
              right: -10,
              bottom: -10,
              child: Opacity(
                opacity: 0.08,
                child: Image.asset(
                  AppAssets.bachaooLogo,
                  width: 90,
                  height: 90,
                  color: AppColors.white,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'BACHAOO!',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: AppDimensions.fontSizeTitleSmall,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.secondaryColor.withValues(
                            alpha: 0.6,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusRound,
                        ),
                      ),
                      child: Text(
                        tier,
                        style: const TextStyle(
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: AppDimensions.fontSizeBodySmall,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  name,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: AppDimensions.fontSizeTitleLarge,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
