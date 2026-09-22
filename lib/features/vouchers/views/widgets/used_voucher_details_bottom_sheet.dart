import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/vouchers/views/models/voucher_model.dart';
import 'package:flutter/material.dart';

/// Read-only redemption receipt for a used voucher. Kept as a bottom sheet so
/// the user stays in the business's voucher list instead of navigating away.
class UsedVoucherDetailsBottomSheet extends StatelessWidget {
  final VoucherModel voucher;

  const UsedVoucherDetailsBottomSheet({super.key, required this.voucher});

  static Future<void> show(BuildContext context, {required VoucherModel voucher}) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => UsedVoucherDetailsBottomSheet(voucher: voucher),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.pagePadding,
        AppDimensions.spacingSmall,
        AppDimensions.pagePadding,
        AppDimensions.paddingXLarge,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.bottomSheetRadius),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: AppDimensions.spacingLarge),
              decoration: BoxDecoration(
                color: AppColors.disabledBackground,
                borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  color: AppColors.successLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded, color: AppColors.successDark),
              ),
              const SizedBox(width: AppDimensions.spacingSmall),
              const Expanded(child: Text('Voucher redeemed', style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: AppDimensions.fontSizeHeadlineXSmall,
                fontWeight: FontWeight.w800,
              ))),
            ],
          ),
          AppDimensions.verticalSpace20,
          _DetailRow(label: 'Business', value: voucher.businessName),
          _DetailRow(label: 'Voucher', value: voucher.voucherName),
          _DetailRow(label: 'Points used', value: '${voucher.points} PTS'),
          _DetailRow(label: 'Expiry', value: voucher.expiryLabel, last: true),
          AppDimensions.verticalSpace12,
          const Text(
            'This voucher has already been used and cannot be redeemed again.',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: AppDimensions.fontSizeBodySmall,
              height: AppDimensions.lineHeightNormal,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool last;

  const _DetailRow({required this.label, required this.value, this.last = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: Row(
            children: [
              Expanded(child: AppText.bodyMedium(label, color: AppColors.textSecondary)),
              Flexible(child: AppText.bodyMedium(value, color: AppColors.textPrimary)),
            ],
          ),
        ),
        if (!last) const Divider(height: 1, color: AppColors.divider),
      ],
    );
  }
}
