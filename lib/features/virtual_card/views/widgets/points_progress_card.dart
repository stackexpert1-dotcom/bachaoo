import 'package:bachaoo/common_widgets/primary_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bachaoo/features/virtual_card/controllers/card_controller.dart';
import 'package:bachaoo/features/virtual_card/models/virtuall_card_model.dart';

class PointsProgressCard extends StatelessWidget {
  final MemberCardModel card;

  const PointsProgressCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CardController>();
    final remaining = card.referralsRemaining;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Points',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: _formatNumber(card.points),
                      style: const TextStyle(
                        color: Color(0xFF1E5631),
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: ' / ${_formatNumber(card.pointsTarget)}',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (context, constraints) {
              final progress = card.pointsProgress.clamp(0.0, 1.0);

              return Container(
                height: 8,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6EFE8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: progress,
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 14),
          Text.rich(
            TextSpan(
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
                height: 1.4,
              ),
              children: [
                TextSpan(
                  text: remaining > 0
                      ? '$remaining more referral${remaining == 1 ? '' : 's'} unlock '
                      : "You've unlocked ",
                ),
                TextSpan(
                  text: card.nextTierLabel,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: remaining > 0
                      ? ' and premium vouchers. Each referral earns ${_formatNumber(card.pointsPerReferral)} points.'
                      : '! Enjoy the premium vouchers.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          PrimaryButton(label: 'Refer Friend', onTap: () {}),
        ],
      ),
    );
  }

  String _formatNumber(int value) {
    final s = value.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final posFromEnd = s.length - i;
      buffer.write(s[i]);
      if (posFromEnd > 1 && posFromEnd % 3 == 1) buffer.write(',');
    }
    return buffer.toString();
  }
}
