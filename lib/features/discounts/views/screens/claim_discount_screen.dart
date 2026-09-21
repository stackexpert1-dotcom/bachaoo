import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/common_widgets/custom_text_feild.dart';
import 'package:bachaoo/features/discounts/models/claim_summary_model.dart';
import 'package:bachaoo/features/discounts/views/widgets/discount_business_code_bottom_sheet.dart';
import 'package:bachaoo/features/discounts/views/widgets/discount_summary_row.dart';
import 'package:bachaoo/routes/bachaoo_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/common_widgets/primary_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/discounts/models/discount_model.dart';

class ClaimDiscountScreen extends StatefulWidget {
  const ClaimDiscountScreen({super.key});

  @override
  State<ClaimDiscountScreen> createState() => _ClaimDiscountScreenState();
}

class _ClaimDiscountScreenState extends State<ClaimDiscountScreen> {
  late final DiscountModel _discount;
  late final double _percent;

  // TEMP: would normally come from the user's profile/wallet stats.
  final double _previousTotalSaved = 4320;
  final int _visitCount = 14;

  final _totalBillController = TextEditingController();
  final _amountPaidController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final arg = Get.arguments;
    _discount = arg is DiscountModel
        ? arg
        : const DiscountModel(
            imageUrl: 'https://picsum.photos/seed/nawaab-royal/200/200',
            discountLabel: '10%',
            title: 'Nawaab Royal Restaurant',
            subtitle: '10% off the entire menu',
          );
    _percent =
        double.tryParse(
          _discount.discountLabel.replaceAll(RegExp(r'[^0-9.]'), ''),
        ) ??
        0;

    _totalBillController.addListener(() => setState(() {}));
    _amountPaidController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _totalBillController.dispose();
    _amountPaidController.dispose();
    super.dispose();
  }

  double? get _totalBill =>
      double.tryParse(_totalBillController.text.replaceAll(',', ''));
  double? get _amountPaid =>
      double.tryParse(_amountPaidController.text.replaceAll(',', ''));

  double? get _expectedDiscount =>
      _totalBill == null ? null : _totalBill! * _percent / 100;

  double? get _actualDiscount => (_totalBill != null && _amountPaid != null)
      ? _totalBill! - _amountPaid!
      : null;

  bool get _canContinue => _totalBill != null && _amountPaid != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.pagePaddingSmall),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Header ---
              Row(
                children: [
                  CustomBackButton(onTap: () => Get.back()),
                  const SizedBox(width: AppDimensions.spacingMedium),
                  AppText.titleLarge('Claim your discount'),
                ],
              ),
              AppDimensions.verticalSpace20,

              // --- Business summary ---
              DiscountSummaryRowCard(
                imageUrl: _discount.imageUrl,
                title: _discount.title,
                subtitle: _discount.subtitle,
                percentLabel: _discount.discountLabel,
              ),
              AppDimensions.verticalSpace24,

              AppText.bodyLarge(
                "Enter the amounts from your bill. We'll work out what you saved.",
                color: AppColors.textSecondary,
              ),
              AppDimensions.verticalSpace20,

              // --- Total bill ---
              CustomTextFormField(
                label: 'Total bill before discount',
                controller: _totalBillController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                ],
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    'Rs',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: AppDimensions.fontSizeBodyLarge,
                    ),
                  ),
                ),
                textStyle: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: AppDimensions.fontSizeTitleLarge,
                ),
              ),
              AppDimensions.verticalSpace20,

              // --- Amount paid ---
              CustomTextFormField(
                label: 'Amount you paid',
                controller: _amountPaidController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                ],
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    'Rs',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: AppDimensions.fontSizeBodyLarge,
                    ),
                  ),
                ),
                textStyle: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: AppDimensions.fontSizeTitleLarge,
                ),
              ),

              if (_totalBill != null) ...[
                const SizedBox(height: 8),
                AppText.bodySmall(
                  '$_percent% of Rs ${_totalBill!.toStringAsFixed(0)} is '
                  'Rs ${_expectedDiscount!.toStringAsFixed(0)} — the discounted '
                  'bill should be Rs ${(_totalBill! - _expectedDiscount!).toStringAsFixed(0)}.',
                ),
              ],
              AppDimensions.verticalSpace20,

              // --- Result card ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusXLarge,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Discount on this visit',
                      style: TextStyle(
                        color: AppColors.white.withValues(alpha: 0.85),
                        fontSize: AppDimensions.fontSizeBodyMedium,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        const Text(
                          'Rs',
                          style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: AppDimensions.fontSizeTitleMedium,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          (_actualDiscount ?? 0).toStringAsFixed(0),
                          style: const TextStyle(
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 40,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Total saved with Bachaoo becomes '
                      'Rs ${(_previousTotalSaved + (_actualDiscount ?? 0)).toStringAsFixed(0)}',
                      style: TextStyle(
                        color: AppColors.white.withValues(alpha: 0.75),
                        fontSize: AppDimensions.fontSizeBodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              AppDimensions.verticalSpace24,

              // --- Continue ---
              PrimaryButton(
                label: 'Continue to business code',
                isEnabled: _canContinue,
                onTap: () {
                  BusinessCodeBottomSheet.show(
                    context,
                    summary: ClaimSummary(
                      totalBill: _totalBill!,
                      amountPaid: _amountPaid!,
                      discountAmount: _actualDiscount!,
                    ),
                    onConfirm: (code) {
                      Get.toNamed(
                        AppRoutes.discountConfirmedScreen,
                        arguments: {
                          'businessName': _discount.title,
                          'businessLogoUrl': _discount.imageUrl,
                          'discountAmount': _actualDiscount!,
                          'totalSavedAllTime':
                              _previousTotalSaved + _actualDiscount!,
                          'visitCount': _visitCount,
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
