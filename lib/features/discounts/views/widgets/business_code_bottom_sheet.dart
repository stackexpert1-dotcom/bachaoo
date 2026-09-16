import 'package:bachaoo/features/discounts/models/claim_summary_model.dart';
import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/common_widgets/business_code_input.dart';
import 'package:bachaoo/common_widgets/primary_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class BusinessCodeBottomSheet extends StatefulWidget {
  final ClaimSummary summary;
  final void Function(String code)? onConfirm;
  final VoidCallback? onReportIssue;

  const BusinessCodeBottomSheet({
    super.key,
    required this.summary,
    this.onConfirm,
    this.onReportIssue,
  });

  static Future<void> show(
    BuildContext context, {
    required ClaimSummary summary,
    void Function(String code)? onConfirm,
    VoidCallback? onReportIssue,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BusinessCodeBottomSheet(
        summary: summary,
        onConfirm: onConfirm,
        onReportIssue: onReportIssue,
      ),
    );
  }

  @override
  State<BusinessCodeBottomSheet> createState() =>
      _BusinessCodeBottomSheetState();
}

class _BusinessCodeBottomSheetState extends State<BusinessCodeBottomSheet> {
  String _code = '';

  /// Shared focus node for the hidden code field. We hold onto it so we can
  /// dismiss the software keyboard before the sheet closes — otherwise the
  /// keyboard lingers over the confirm-discount screen during the route
  /// transition, its viewInsets briefly shrink the visible area, and the
  /// debug "overflowed" indicator flashes on screen.
  late final FocusNode _codeFocusNode;

  @override
  void initState() {
    super.initState();
    _codeFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _codeFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: AppDimensions.pagePaddingSmall,
        right: AppDimensions.pagePaddingSmall,
        top: AppDimensions.spacingSmall,
        bottom:
            MediaQuery.of(context).viewInsets.bottom +
            AppDimensions.pagePaddingSmall,
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
          // --- Drag handle ---
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

          AppText.headlineSmall('Ask staff for the business code'),
          const SizedBox(height: 6),
          AppText.bodyLarge(
            'Show this screen at the counter. The 4-digit code confirms '
            'your discount was honoured.',
            color: AppColors.textSecondary,
          ),
          AppDimensions.verticalSpace20,

          // --- Bill summary ---
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
            ),
            child: Column(
              children: [
                _summaryRow('Total bill', widget.summary.totalBill),
                const SizedBox(height: 10),
                _summaryRow('Paid', widget.summary.amountPaid),
                const SizedBox(height: 10),
                _summaryRow(
                  'Discount',
                  widget.summary.discountAmount,
                  valueColor: AppColors.primaryColor,
                ),
              ],
            ),
          ),
          AppDimensions.verticalSpace20,

          // --- Code input ---
          BusinessCodeInput(
            focusNode: _codeFocusNode,
            unfocusOnComplete: true,
            onChanged: (value) => setState(() => _code = value),
          ),
          AppDimensions.verticalSpace20,

          // --- Confirm ---
          PrimaryButton(
            label: 'Confirm discount',
            isEnabled: _code.length == 4,
            backgroundColor: AppColors.secondaryColor,
            textColor: AppColors.primaryColor,
            onTap: () async {
              // _codeFocusNode.unfocus();
              // FocusManager.instance.primaryFocus?.unfocus();
              await Future.delayed(const Duration(milliseconds: 100));
              if (!context.mounted) return;
              Navigator.of(context).pop();
              widget.onConfirm?.call(_code);
            },
          ),
          AppDimensions.verticalSpace12,

          Center(
            child: GestureDetector(
              onTap: widget.onReportIssue,
              child: Text.rich(
                TextSpan(
                  text: "Staff don't have the code? ",
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppDimensions.fontSizeBodyMedium,
                  ),
                  children: const [
                    TextSpan(
                      text: 'Report an issue',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // AppDimensions.verticalSpace48,
        ],
      ),
    );
  }

  Widget _summaryRow(String label, double value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText.bodyLarge(label, color: AppColors.textSecondary),
        Text(
          'Rs ${value.toStringAsFixed(0)}',
          style: TextStyle(
            color: valueColor ?? AppColors.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: AppDimensions.fontSizeBodyLarge,
          ),
        ),
      ],
    );
  }
}
