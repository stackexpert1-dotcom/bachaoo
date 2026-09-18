import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/subscription/models/bank_account_model.dart';

class BankAccountCard extends StatelessWidget {
  final BankAccountModel account;

  const BankAccountCard({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.account_balance_rounded,
                  color: AppColors.secondaryColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: AppDimensions.spacingSmall),
              AppText.titleMedium(account.bankName, color: AppColors.white),
            ],
          ),
          AppDimensions.verticalSpace16,
          for (int i = 0; i < account.fields.length; i++) ...[
            _CopyableRow(field: account.fields[i]),
            if (i != account.fields.length - 1) AppDimensions.verticalSpace12,
          ],
        ],
      ),
    );
  }
}

class _CopyableRow extends StatelessWidget {
  final BankAccountField field;

  const _CopyableRow({required this.field});

  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: field.value));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${field.label} copied'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.bodySmall(field.label, color: Colors.white),
              const SizedBox(height: 2),
              AppText.bodyMedium(
                field.value,
                color: AppColors.white,
                //  style: const TextStyle(
                //     color: AppColors.white,
                //     fontWeight: FontWeight.w700,
                //     fontSize: AppDimensions.fontSizeBodyMedium,
                //     letterSpacing: 0.3,§
                //   ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => _copy(context),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            ),
            child: const Icon(
              Icons.copy_rounded,
              size: 16,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
