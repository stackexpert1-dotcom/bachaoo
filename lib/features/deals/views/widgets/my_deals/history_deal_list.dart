import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_image.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/deals/models/deal_model.dart';

class HistoryMonthSection extends StatelessWidget {
  final String monthLabel;
  final List<DealModel> deals;
  final void Function(DealModel deal)? onDealTap;

  const HistoryMonthSection({
    super.key,
    required this.monthLabel,
    required this.deals,
    this.onDealTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 4,
            bottom: AppDimensions.spacingSmall,
          ),
          child: AppText.bodyMedium(monthLabel, color: AppColors.textHint),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              for (int i = 0; i < deals.length; i++) ...[
                _HistoryRow(deal: deals[i], onTap: onDealTap),
                if (i != deals.length - 1)
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColors.divider,
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _HistoryRow extends StatelessWidget {
  final DealModel deal;
  final void Function(DealModel deal)? onTap;

  const _HistoryRow({required this.deal, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap == null ? null : () => onTap!(deal),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              child: deal.imageUrl != null
                  ? AppImage(
                      imagePath: deal.imageUrl!,
                      width: 48,
                      height: 48,
                      errorBuilder: (context, error, stackTrace) =>
                          _logoPlaceholder(),
                    )
                  : _logoPlaceholder(),
            ),
            const SizedBox(width: AppDimensions.spacingMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.titleSmall(
                    deal.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  AppText.bodySmall(
                    '${deal.title} · ${deal.date != null ? _formatDay(deal.date!) : ''}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppDimensions.spacingSmall),
            // Money is never ellipsis-truncated — letting it wrap to a
            // second line (as in the reference) is safer than hiding
            // part of a real amount.
            Text(
              '− Rs ${(deal.amountSaved ?? 0.0).toStringAsFixed(0)}',
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: AppColors.successDark,
                fontWeight: FontWeight.w800,
                fontSize: AppDimensions.fontSizeTitleSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoPlaceholder() {
    return Container(
      width: 48,
      height: 48,
      color: AppColors.disabledBackground,
    );
  }

  String _formatDay(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month - 1]}';
  }
}
