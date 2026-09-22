import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/common_widgets/business_code_input.dart';
import 'package:bachaoo/common_widgets/primary_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/vouchers/views/models/voucher_model.dart';
import 'package:flutter/material.dart';

class VoucherBusinessCodeBottomSheet extends StatefulWidget {
  final VoucherModel voucher;
  final void Function(String code)? onConfirm;

  const VoucherBusinessCodeBottomSheet({
    super.key,
    required this.voucher,
    this.onConfirm,
  });

  static Future<void> show(
    BuildContext context, {
    required VoucherModel voucher,
    void Function(String code)? onConfirm,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => VoucherBusinessCodeBottomSheet(
        voucher: voucher,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  State<VoucherBusinessCodeBottomSheet> createState() =>
      _VoucherBusinessCodeBottomSheetState();
}

class _VoucherBusinessCodeBottomSheetState
    extends State<VoucherBusinessCodeBottomSheet> {
  String _code = '';
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppDimensions.pagePaddingSmall,
        AppDimensions.spacingSmall,
        AppDimensions.pagePaddingSmall,
        MediaQuery.of(context).viewInsets.bottom + AppDimensions.paddingLarge,
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
              margin: const EdgeInsets.only(
                bottom: AppDimensions.spacingMedium,
              ),
              decoration: BoxDecoration(
                color: AppColors.disabledBackground,
                borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
              ),
            ),
          ),
          AppText.headlineSmall('Enter the business code'),
          const SizedBox(height: 6),
          AppText.bodyMedium(
            'Ask the staff at ${widget.voucher.businessName} for the 4-digit code to redeem this voucher.',
            color: AppColors.textSecondary,
          ),
          AppDimensions.verticalSpace20,
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            decoration: BoxDecoration(
              color: AppColors.successLight,
              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.confirmation_number_outlined,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: AppDimensions.spacingSmall),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.titleSmall(widget.voucher.voucherName),
                      const SizedBox(height: 2),
                      AppText.bodySmall(
                        '${widget.voucher.points} PTS · ${widget.voucher.expiryLabel}',
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AppDimensions.verticalSpace20,
          BusinessCodeInput(
            focusNode: _focusNode,
            unfocusOnComplete: true,
            onChanged: (code) => setState(() => _code = code),
          ),
          AppDimensions.verticalSpace20,
          PrimaryButton(
            label: 'Redeem voucher',
            isEnabled: _code.length == 4,
            backgroundColor: AppColors.secondaryColor,
            textColor: AppColors.primaryColor,
            onTap: () {
              Navigator.of(context).pop();
              widget.onConfirm?.call(_code);
            },
          ),
        ],
      ),
    );
  }
}
