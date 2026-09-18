import 'package:bachaoo/features/subscription/views/widgets/bank_account_card.dart';
import 'package:bachaoo/features/subscription/views/widgets/payment_proof_upload.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/common_widgets/primary_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/subscription/models/bank_account_model.dart';

class PaymentSubmissionScreen extends StatefulWidget {
  final int amountDue;
  final String currencyUnit;

  const PaymentSubmissionScreen({
    super.key,
    this.amountDue = 7500,
    this.currencyUnit = 'PKR',
  });

  @override
  State<PaymentSubmissionScreen> createState() =>
      _PaymentSubmissionScreenState();
}

class _PaymentSubmissionScreenState extends State<PaymentSubmissionScreen> {
  PlatformFile? _proofFile;
  bool _isSubmitting = false;

  // TODO: replace with real bank details from your backend/config —
  // hardcoded here from the reference content only.
  static const _accounts = [
    BankAccountModel(
      bankName: 'Bank Al Habib',
      fields: [
        BankAccountField(
          label: 'Account Number',
          value: '564-0081-0010-6801-9',
        ),
        BankAccountField(
          label: 'IBAN Number',
          value: 'PK BAHL 5564-0081-0010-6801-9',
        ),
      ],
    ),
    BankAccountModel(
      bankName: 'Easypaisa',
      fields: [BankAccountField(label: 'Account Number', value: '03126664123')],
    ),
  ];

  Future<void> _submit() async {
    if (_proofFile == null) {
      Get.snackbar(
        'Payment submitted',
        'Please attach your payment screenshot first',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    setState(() => _isSubmitting = true);
    // TODO: replace with a real upload/submit API call, sending
    // widget.amountDue and _proofFile.
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isSubmitting = false);

    Get.snackbar(
      'Payment submitted',
      "We'll review it and notify you within a few hours.",
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // --- App bar ---
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.pagePaddingSmall,
                vertical: AppDimensions.spacingSmall,
              ),
              child: Row(
                children: [
                  const CustomBackButton(size: 36, iconSize: 22),
                  const SizedBox(width: AppDimensions.spacingSmall),
                  AppText.headlineMedium('Complete Payment'),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.pagePaddingSmall,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Amount due banner ---
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
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryColor.withValues(
                                alpha: 0.18,
                              ),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.receipt_long_rounded,
                              color: AppColors.secondaryColor,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: AppDimensions.spacingMedium),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Amount to pay',
                                  style: TextStyle(
                                    color: AppColors.white.withValues(
                                      alpha: 0.75,
                                    ),
                                    fontSize: AppDimensions.fontSizeBodySmall,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${widget.currencyUnit == "PKR" ? "Rs" : widget.currencyUnit} '
                                  '${_formatNumber(widget.amountDue)}',
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize:
                                        AppDimensions.fontSizeHeadlineSmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    AppDimensions.verticalSpace16,

                    // --- Instructions ---
                    AppText.bodyLarge(
                      'Make the payment to any of the accounts below and upload '
                      'your payment screenshot. Your subscription will be '
                      'approved within a few hours, and you\'ll be notified by '
                      'email or SMS.',
                      color: AppColors.textSecondary,
                    ),

                    AppDimensions.verticalSpace20,

                    // --- Bank accounts ---
                    for (int i = 0; i < _accounts.length; i++) ...[
                      BankAccountCard(account: _accounts[i]),
                      if (i != _accounts.length - 1)
                        AppDimensions.verticalSpace12,
                    ],

                    AppDimensions.verticalSpace24,

                    // --- Upload ---
                    PaymentProofUpload(
                      selectedFile: _proofFile,
                      onFileSelected: (file) =>
                          setState(() => _proofFile = file),
                    ),

                    AppDimensions.verticalSpace24,
                  ],
                ),
              ),
            ),

            // --- Submit — pinned at the bottom, outside the scroll area ---
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.pagePaddingSmall,
                AppDimensions.spacingSmall,
                AppDimensions.pagePaddingSmall,
                AppDimensions.spacingMedium,
              ),
              child: PrimaryButton(
                label: 'Submit',
                isLoading: _isSubmitting,
                onTap: _isSubmitting ? null : _submit,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatNumber(int value) {
    final str = value.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buffer.write(',');
      buffer.write(str[i]);
    }
    return buffer.toString();
  }
}
