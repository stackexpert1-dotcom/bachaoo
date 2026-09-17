import 'package:bachaoo/features/deals/models/deal_model.dart';
import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/common_widgets/business_code_input.dart';
import 'package:bachaoo/common_widgets/primary_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class DealBusinessCodeBottomSheet extends StatefulWidget {
  final DealModel deal;
  final void Function(String code)? onConfirm;
  final VoidCallback? onReportIssue;

  const DealBusinessCodeBottomSheet({
    super.key,
    required this.deal,
    this.onConfirm,
    this.onReportIssue,
  });

  static Future<void> show(
    BuildContext context, {
    required DealModel deal,
    void Function(String code)? onConfirm,
    VoidCallback? onReportIssue,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DealBusinessCodeBottomSheet(
        deal: deal,
        onConfirm: onConfirm,
        onReportIssue: onReportIssue,
      ),
    );
  }

  @override
  State<DealBusinessCodeBottomSheet> createState() =>
      _DealBusinessCodeBottomSheetState();
}

class _DealBusinessCodeBottomSheetState
    extends State<DealBusinessCodeBottomSheet> {
  String _code = '';
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
            'The 4-digit code confirms '
            'your deal was honoured.',
            color: AppColors.textSecondary,
          ),
          AppDimensions.verticalSpace20,

          // --- Deal Summary Box ---
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.titleMedium(
                        widget.deal.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      AppText.bodyMedium(
                        widget.deal.subtitle,
                        color: AppColors.textSecondary,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (widget.deal.amountSaved != null) ...[
                  const SizedBox(width: AppDimensions.spacingSmall),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      const Text(
                        'Rs ',
                        style: TextStyle(
                          color: AppColors.successDark,
                          fontWeight: FontWeight.w700,
                          fontSize: AppDimensions.fontSizeBodyMedium,
                        ),
                      ),
                      Text(
                        widget.deal.amountSaved!.toStringAsFixed(0),
                        style: const TextStyle(
                          color: AppColors.successDark,
                          fontWeight: FontWeight.w800,
                          fontSize: AppDimensions.fontSizeHeadlineSmall,
                        ),
                      ),
                    ],
                  ),
                ],
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
            label: 'Confirm deal',
            isEnabled: _code.length == 4,
            backgroundColor: AppColors.secondaryColor,
            textColor: AppColors.primaryColor,
            onTap: () async {
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
        ],
      ),
    );
  }
}
