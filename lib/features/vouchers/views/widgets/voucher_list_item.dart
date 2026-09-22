import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/vouchers/views/models/voucher_model.dart';
import 'package:flutter/material.dart';

/// Business-led voucher card. No amount stub: the business image is the
/// leading visual and all redemption information lives in the details area.
class VoucherListItem extends StatelessWidget {
  final VoucherModel voucher;
  final VoidCallback? onTap;
  final VoidCallback? onUseNow;

  const VoucherListItem({
    super.key,
    required this.voucher,
    this.onTap,
    this.onUseNow,
  });

  @override
  Widget build(BuildContext context) {
    final isAvailable = voucher.canUse;
    final isUsed = voucher.status == VoucherStatus.redeemed;
    final isExpired = voucher.status == VoucherStatus.expired || voucher.isExpired;
    final canOpen = isAvailable || isUsed;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: canOpen ? onTap : null,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        child: Ink(
          height: 158,
          decoration: BoxDecoration(
            color: AppColors.surfaceColor,
            borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
            border: Border.all(
              color: isAvailable ? AppColors.borderColor : AppColors.divider,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(
                width: 116,
                height: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(AppDimensions.radiusXLarge),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        voucher.businessImageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Container(
                          color: AppColors.successLight,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.storefront_outlined,
                            color: AppColors.primaryColor,
                            size: AppDimensions.iconSizeLarge,
                          ),
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.40),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 9,
                        bottom: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white.withValues(alpha: 0.92),
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusRound,
                            ),
                          ),
                          child: Text(
                            voucher.status.label,
                            style: TextStyle(
                              color: isAvailable
                                  ? AppColors.primaryColor
                                  : AppColors.textSecondary,
                              fontSize: AppDimensions.fontSizeBodyXSmall,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 13, 13, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        voucher.businessName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: AppDimensions.fontSizeBodySmall,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        voucher.voucherName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: AppDimensions.fontSizeTitleSmall,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        voucher.secondaryText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: AppDimensions.fontSizeBodyXSmall,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.stars_rounded,
                                      color: AppColors.secondaryColor,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      '${voucher.points} PTS',
                                      style: const TextStyle(
                                        color: AppColors.warningDark,
                                        fontSize:
                                            AppDimensions.fontSizeBodyXSmall,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.event_outlined,
                                      color: AppColors.iconMuted,
                                      size: 15,
                                    ),
                                    const SizedBox(width: 3),
                                    Expanded(
                                      child: Text(
                                        voucher.expiryLabel,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: AppColors.textHint,
                                          fontSize:
                                              AppDimensions.fontSizeBodyXSmall,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 6),
                          SizedBox(
                            height: 30,
                            child: TextButton(
                              onPressed: canOpen ? onUseNow : null,
                              style: TextButton.styleFrom(
                                backgroundColor: isAvailable
                                    ? AppColors.primaryColor
                                    : isUsed
                                    ? AppColors.successLight
                                    : AppColors.disabledBackground,
                                foregroundColor: isUsed
                                    ? AppColors.successDark
                                    : AppColors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppDimensions.radiusSmall,
                                  ),
                                ),
                              ),
                              child: Text(
                                isAvailable
                                    ? 'Use now'
                                    : isUsed
                                    ? 'View details'
                                    : 'Expired',
                                style: TextStyle(
                                  color: isUsed
                                      ? AppColors.successDark
                                      : AppColors.white,
                                  fontSize: AppDimensions.fontSizeBodyXSmall,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
