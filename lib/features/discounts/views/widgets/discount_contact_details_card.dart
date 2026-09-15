import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class ContactDetailCard extends StatelessWidget {
  final String role; // e.g. "Owner"
  final String name;
  final String phone;
  final String address;
  final VoidCallback? onDirectionsTap;

  const ContactDetailCard({
    super.key,
    required this.role,
    required this.name,
    required this.phone,
    required this.address,
    this.onDirectionsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        border: Border.all(color: AppColors.borderColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // --- Owner tag + name + phone ---
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.successLight,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusSmall,
                    ),
                  ),
                  child: Text(
                    role,
                    style: const TextStyle(
                      color: AppColors.successDark,
                      fontWeight: FontWeight.w700,
                      fontSize: AppDimensions.fontSizeBodyMedium,
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.spacingXSmall),
                Expanded(
                  child: AppText.bodySmall(name, color: AppColors.textPrimary),
                ),
                Text(
                  phone,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                    fontSize: AppDimensions.fontSizeBodySmall,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: AppColors.divider),

          // --- Address + Directions ---
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: AppText.bodyMedium(
                    address,
                    color: AppColors.textSecondary,
                  ),
                ),
                GestureDetector(
                  onTap: onDirectionsTap,
                  child: AppText.titleSmall(
                    'Directions',
                    color: AppColors.primaryColor,
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
