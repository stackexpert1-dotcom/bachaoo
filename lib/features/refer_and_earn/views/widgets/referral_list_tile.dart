import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/features/refer_and_earn/models/refer_and_earn_model.dart';
import 'package:flutter/material.dart';

class ReferralListTile extends StatelessWidget {
  final ReferralModel referral;

  const ReferralListTile({super.key, required this.referral});

  @override
  Widget build(BuildContext context) {
    final isPending = referral.status == ReferralStatus.pending;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: isPending
                ? AppColors.secondaryColor.withValues(alpha: 0.15)
                : AppColors.primaryColor.withValues(alpha: 0.12),
            child: Text(
              isPending ? '?' : referral.initials,
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  referral.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  referral.statusLabel,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                ),
              ],
            ),
          ),
          if (isPending)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Pending',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            )
          else if (referral.pointsEarned != null)
            Text(
              '+${_formatNumber(referral.pointsEarned!)}',
              style: const TextStyle(
                color: AppColors.secondaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
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
