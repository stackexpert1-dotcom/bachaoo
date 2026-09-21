import 'package:bachaoo/common_widgets/app_image.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/common_widgets/primary_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/deals/models/deal_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Receipt-style summary for a deal opened from My Deals.
class DealSummaryScreen extends StatelessWidget {
  final DealModel deal;

  const DealSummaryScreen({super.key, required this.deal});

  @override
  Widget build(BuildContext context) {
    final isRedeemed = deal.status == DealStatus.redeemed;
    final savedAmount = deal.amountSaved ?? 0;

    return Scaffold(
      backgroundColor: AppColors.appBackroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.pagePaddingSmall,
                AppDimensions.spacingSmall,
                AppDimensions.pagePaddingSmall,
                AppDimensions.spacingSmall,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: Get.back,
                    icon: const Icon(Icons.chevron_left_rounded),
                    color: AppColors.textPrimary,
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusMedium,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacingSmall),
                  AppText.headlineMedium('Deal summary'),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppDimensions.pagePaddingSmall,
                  AppDimensions.spacingMedium,
                  AppDimensions.pagePaddingSmall,
                  AppDimensions.spacingXXLarge,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DealHero(deal: deal, isRedeemed: isRedeemed),
                    AppDimensions.verticalSpace20,
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusXLarge,
                        ),
                        border: Border.all(color: AppColors.borderColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              AppText.titleMedium('Invoice details'),
                              const Spacer(),
                              const Icon(
                                Icons.receipt_long_rounded,
                                color: AppColors.primaryColor,
                              ),
                            ],
                          ),
                          AppDimensions.verticalSpace16,
                          _InvoiceRow(label: 'Invoice number', value: _invoiceId),
                          _InvoiceRow(label: 'Business', value: deal.subtitle),
                          _InvoiceRow(label: 'Deal', value: deal.title),
                          _InvoiceRow(label: 'Date', value: _formatDate(deal.date)),
                          _InvoiceRow(
                            label: 'Status',
                            value: isRedeemed ? 'Redeemed' : 'Awaiting code',
                            valueColor: isRedeemed
                                ? AppColors.successDark
                                : AppColors.warningDark,
                            showDivider: false,
                          ),
                        ],
                      ),
                    ),
                    AppDimensions.verticalSpace16,
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusXLarge,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryColor.withValues(
                                alpha: 0.18,
                              ),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.savings_rounded,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          const SizedBox(width: AppDimensions.spacingMedium),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'You saved',
                                  style: TextStyle(
                                    color: AppColors.white.withValues(
                                      alpha: 0.74,
                                    ),
                                    fontSize: AppDimensions.fontSizeBodyMedium,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Rs ${savedAmount.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontSize: AppDimensions.fontSizeHeadlineLarge,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppDimensions.verticalSpace20,
                    Text(
                      isRedeemed
                          ? 'This deal has been redeemed successfully. Thank you for saving with Bachaoo!'
                          : 'Show this summary when you enter the business code to complete your deal.',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: AppDimensions.fontSizeBodyMedium,
                        height: AppDimensions.lineHeightRelaxed,
                      ),
                    ),
                    AppDimensions.verticalSpace24,
                    PrimaryButton(label: 'Back to My Deals', onTap: Get.back),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get _invoiceId => 'BCH-${deal.id ?? '0000'}';

  String _formatDate(DateTime? date) {
    final value = date ?? DateTime.now();
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${value.day} ${months[value.month - 1]} ${value.year}';
  }
}

class _DealHero extends StatelessWidget {
  final DealModel deal;
  final bool isRedeemed;

  const _DealHero({required this.deal, required this.isRedeemed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 174,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        color: AppColors.primaryColor,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (deal.imageUrl != null)
            AppImage(imagePath: deal.imageUrl!, fit: BoxFit.cover),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color(0xD90A2313), Color(0x330A2313)],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingSmall,
                    vertical: AppDimensions.paddingXXSmall,
                  ),
                  decoration: BoxDecoration(
                    color: isRedeemed
                        ? AppColors.success
                        : AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusRound,
                    ),
                  ),
                  child: Text(
                    isRedeemed ? 'Redeemed' : 'Active deal',
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: AppDimensions.fontSizeLabelSmall,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  deal.subtitle,
                  style: TextStyle(
                    color: AppColors.white.withValues(alpha: 0.82),
                    fontSize: AppDimensions.fontSizeBodyMedium,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  deal.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: AppDimensions.fontSizeHeadlineSmall,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InvoiceRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool showDivider;

  const _InvoiceRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: AppDimensions.fontSizeBodyMedium,
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.spacingMedium),
            Flexible(
              child: Text(
                value,
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: valueColor ?? AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: AppDimensions.fontSizeBodyMedium,
                ),
              ),
            ),
          ],
        ),
        if (showDivider) ...[
          AppDimensions.verticalSpace12,
          const Divider(height: 1, color: AppColors.divider),
          AppDimensions.verticalSpace12,
        ],
      ],
    );
  }
}
