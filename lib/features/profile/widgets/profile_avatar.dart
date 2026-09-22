import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:flutter/material.dart';

class ProfileAvatarWithBadge extends StatelessWidget {
  final String initials;
  final String? imageUrl;
  final VoidCallback onEditTap;

  const ProfileAvatarWithBadge({
    super.key,
    required this.initials,
    this.imageUrl,
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
          SizedBox(
            width: AppDimensions.avatarXXLarge,
            height: AppDimensions.avatarXXLarge,
            child: ClipOval(
              child: Container(
                alignment: Alignment.center,
                color: AppColors.secondaryColor,
                child: imageUrl == null
                    ? _Initials(initials: initials)
                    : Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) =>
                            _Initials(initials: initials),
                      ),
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

class _Initials extends StatelessWidget {
  final String initials;

  const _Initials({required this.initials});

  @override
  Widget build(BuildContext context) {
    return Text(
      initials,
      style: const TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w700,
        fontSize: AppDimensions.fontSizeHeadlineSmall,
      ),
    );
  }
}
