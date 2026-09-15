import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:flutter/material.dart';

class ProfileAvatarWithBadge extends StatelessWidget {
  final String initials;
  final VoidCallback onEditTap;

  const ProfileAvatarWithBadge({
    super.key,
    required this.initials,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.avatarXXLarge,
      height: AppDimensions.avatarXXLarge,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: AppDimensions.avatarXXLarge,
            height: AppDimensions.avatarXXLarge,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.secondaryColor,
              shape: BoxShape.circle,
            ),
            child: Text(
              initials,
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w800,
                fontSize: AppDimensions.fontSizeHeadlineSmall,
              ),
            ),
          ),
          Positioned(
            right: -2,
            bottom: -2,
            child: GestureDetector(
              onTap: onEditTap,
              child: Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.appBackroundColor,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.edit_outlined,
                  color: AppColors.white,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
