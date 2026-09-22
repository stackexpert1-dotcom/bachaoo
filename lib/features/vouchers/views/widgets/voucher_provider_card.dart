import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/vouchers/views/models/voucher_model.dart';
import 'package:flutter/material.dart';

/// Image-led provider card for the voucher discovery screen.
class VoucherProviderCard extends StatelessWidget {
  final VoucherProviderModel provider;
  final VoidCallback? onTap;

  const VoucherProviderCard({super.key, required this.provider, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        child: Ink(
          height: 210,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow.withValues(alpha: 0.12),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  provider.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    color: AppColors.successLight,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.storefront_outlined,
                      color: AppColors.primaryColor,
                      size: AppDimensions.iconSizeHuge,
                    ),
                  ),
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0x15000000), Color(0xE8001A0B)],
                      stops: [0.20, 1],
                    ),
                  ),
                ),
                Positioned(
                  top: 13,
                  left: 13,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.94),
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusRound,
                      ),
                    ),
                    child: Text(
                      provider.category,
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: AppDimensions.fontSizeLabelSmall,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.businessName,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: AppDimensions.fontSizeHeadlineSmall,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        provider.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.white.withValues(alpha: 0.84),
                          fontSize: AppDimensions.fontSizeBodySmall,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radiusRound,
                              ),
                            ),
                            child: Text(
                              '${provider.activeVoucherCount} voucher${provider.activeVoucherCount == 1 ? '' : 's'}',
                              style: const TextStyle(
                                color: AppColors.textOnSecondary,
                                fontSize: AppDimensions.fontSizeBodyXSmall,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: AppColors.white,
                            size: AppDimensions.iconSizeMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
