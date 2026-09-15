import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/virtual_card/models/virtuall_card_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MemberCardWidget extends StatelessWidget {
  final MemberCardModel card;

  const MemberCardWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    final validTillLabel = DateFormat('dd-MMM-yyyy')
        .format(card.validTill)
        .toUpperCase();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryColor, AppColors.primaryColor],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BACHAOO!',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    AppDimensions.verticalSpace1,
                    Text(
                      'MEMBER CARD',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: AppDimensions.fontSizeBodySmall,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
              _TierBadge(label: card.tierLabel),
            ],
          ),
          AppDimensions.verticalSpace16,
          Container(
            width: 40,
            height: 28,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE8B65A), Color(0xFFC98F32)],
              ),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          AppDimensions.verticalSpace16,
          Text(
            card.holderName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          AppDimensions.verticalSpace16,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _CardFooterField(
                  label: 'Referral code',
                  value: card.referralCode,
                ),
              ),
              _CardFooterField(
                label: 'Valid till',
                value: validTillLabel,
                alignEnd: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TierBadge extends StatelessWidget {
  final String label;
  const _TierBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor.withValues(alpha: 0.2),
        border: Border.all(color: AppColors.secondaryColor),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXSmall),
      ),
      child: AppText.bodySmall(
        label,
        fontWeight: FontWeight.w600,
        color: AppColors.secondaryColor,
      ),
    );
  }
}

class _CardFooterField extends StatelessWidget {
  final String label;
  final String value;
  final bool alignEnd;

  const _CardFooterField({
    required this.label,
    required this.value,
    this.alignEnd = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignEnd
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        AppText.bodyMedium(
          label,
          color: AppColors.white.withValues(alpha: 0.6),
          fontWeight: FontWeight.bold,
        ),
        AppDimensions.verticalSpace4,
        AppText.bodyLarge(
          value,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
      ],
    );
  }
}
