import 'package:bachaoo/common_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_image.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/deals/models/deal_model.dart';

class ActiveDealCard extends StatelessWidget {
  final DealModel deal;
  final VoidCallback? onEnterCodeTap;
  final VoidCallback? onTap;

  const ActiveDealCard({
    super.key,
    required this.deal,
    this.onEnterCodeTap,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        child: Ink(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
            border: Border.all(color: AppColors.secondaryColor, width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusLarge,
                    ),
                    child: deal.imageUrl != null
                        ? AppImage(
                            imagePath: deal.imageUrl!,
                            width: 64,
                            height: 64,
                            errorBuilder: (context, error, stackTrace) =>
                                _logoPlaceholder(),
                          )
                        : _logoPlaceholder(),
                  ),
                  const SizedBox(width: AppDimensions.spacingMedium),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.titleMedium(
                          deal.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        AppText.bodyMedium(
                          deal.subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacingSmall),
                  // Matches the Rs+amount baseline pattern used on
                  // DiscountConfirmedScreen, for visual consistency.
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      const Text(
                        'Rs',
                        style: TextStyle(
                          color: AppColors.successDark,
                          fontWeight: FontWeight.w700,
                          fontSize: AppDimensions.fontSizeBodyMedium,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        (deal.amountSaved ?? 0.0).toStringAsFixed(0),
                        style: const TextStyle(
                          color: AppColors.successDark,
                          fontWeight: FontWeight.w800,
                          fontSize: AppDimensions.fontSizeHeadlineSmall,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.spacingMedium),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.warningLight,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusRound,
                  ),
                ),
                child: Text(
                  deal.statusLabel,
                  style: const TextStyle(
                    color: AppColors.warningDark,
                    fontWeight: FontWeight.w700,
                    fontSize: AppDimensions.fontSizeBodyMedium,
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.spacingMedium),
              // SizedBox(
              //   width: double.infinity,
              //   child: ElevatedButton(
              //     onPressed: onEnterCodeTap,
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: AppColors.primaryColor,
              //       padding: const EdgeInsets.symmetric(vertical: 16),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(
              //           AppDimensions.radiusRound,
              //         ),
              //       ),
              //       elevation: 0,
              //     ),
              //     child: AppText.labelLarge(
              //       'Enter business code',
              //       color: AppColors.white,
              //     ),
              //   ),
              //  ),
              PrimaryButton(
                label: 'Enter Business Code',
                onTap: onEnterCodeTap,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logoPlaceholder() {
    return Container(
      width: 64,
      height: 64,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE4E4E4), Color(0xFFB0B0B0)],
        ),
      ),
    );
  }
}
