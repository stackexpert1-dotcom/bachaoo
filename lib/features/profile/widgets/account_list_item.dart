import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:flutter/material.dart';

class AccountListItem extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final bool showChevron;
  final bool showSwitch;
  final bool switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final VoidCallback? onTap;

  const AccountListItem({
    super.key,
    required this.title,
    this.titleColor,
    this.showChevron = true,
    this.showSwitch = false,
    this.switchValue = false,
    this.onSwitchChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingLarge,
          vertical: AppDimensions.paddingMedium,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: titleColor ?? AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: AppDimensions.fontSizeTitleSmall,
                ),
              ),
            ),
            if (showSwitch)
              Switch(
                value: switchValue,
                onChanged: onSwitchChanged,
                activeColor: AppColors.white,
                activeTrackColor: AppColors.primaryColor,
                inactiveThumbColor: AppColors.white,
                inactiveTrackColor: AppColors.disabledBackground,
              )
            else if (showChevron)
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.iconMuted,
                size: AppDimensions.iconSizeMedium,
              ),
          ],
        ),
      ),
    );
  }
}

class AccountDivider extends StatelessWidget {
  const AccountDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      thickness: AppDimensions.dividerThickness,
      color: AppColors.borderColor,
      indent: AppDimensions.paddingLarge,
      endIndent: AppDimensions.paddingLarge,
    );
  }
}
