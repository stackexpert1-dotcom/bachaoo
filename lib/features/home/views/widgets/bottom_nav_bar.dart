import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/features/profile/widgets/profile_bottom_sheet.dart';
import 'package:bachaoo/routes/bachaoo_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onCenterTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onCenterTap,
  });

  static const double _barHeight = AppDimensions.bottomNavHeight;
  static const double _outerCircle = 78.0;
  static const double _innerCircle = 68.0;
  static const double _overlap = 44.0;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return SizedBox(
      height: _barHeight + bottomInset,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // --- Bar background ---
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: _barHeight + bottomInset,
              padding: EdgeInsets.only(bottom: bottomInset),
              decoration: BoxDecoration(
                color: AppColors.surfaceColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 16,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavItem(
                    icon: Icons.home_outlined,
                    selectedIcon: Icons.home,
                    label: 'Home',
                    selected: currentIndex == 0,
                    onTap: () => onTap(0),
                  ),
                  _NavItem(
                    icon: Icons.credit_card_outlined,
                    selectedIcon: Icons.credit_card,
                    label: 'Card',
                    selected: currentIndex == 1,
                    onTap: () {
                      onTap(1);
                      Get.toNamed(AppRoutes.cardScreen);
                    },
                  ),
                  const SizedBox(
                    width: _outerCircle - AppDimensions.spacingSmall,
                  ),
                  _NavItem(
                    icon: Icons.share_outlined,
                    selectedIcon: Icons.share,
                    label: 'Refer',
                    selected: currentIndex == 3,
                    onTap: () {
                      onTap(3);
                      Get.toNamed(AppRoutes.referralScreen);
                    },
                  ),
                  _NavItem(
                    icon: Icons.grid_view_outlined,
                    selectedIcon: Icons.grid_view_rounded,
                    label: 'More',
                    selected: currentIndex == 4,
                    onTap: () {
                      onTap(4);
                      ProfileBottomSheet.show(
                        context,
                        initials: 'SU',
                        fullName: 'Shafqat Ullah',
                        membershipLabel: 'Standard member',
                        points: 2000,
                        onEditProfile: () =>
                            Get.toNamed(AppRoutes.editProfileScreen),
                        onLogout: () {},
                        onInboxTap: () => Get.toNamed(AppRoutes.inboxScreen),
                        onHelpTap: () =>
                            Get.toNamed(AppRoutes.helpSupportScreen),
                        onAboutTap: () => Get.toNamed(
                          AppRoutes.policiesScreen,
                          arguments: 'about',
                        ),
                        onPoliciesTap: () =>
                            Get.toNamed(AppRoutes.policiesScreen),
                        onContactTap: () =>
                            Get.toNamed(AppRoutes.contactUsScreen),
                        onVouchersTap: () {
                          Get.toNamed(AppRoutes.voucherScreen);
                        },
                        onVirtualCardTap: () =>
                            Get.toNamed(AppRoutes.memberShipCardScreen),
                        onCategoriesTap: () =>
                            Get.toNamed(AppRoutes.categoryScreen),
                        onReferTap: () => Get.toNamed(AppRoutes.referralScreen),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // --- Floating center button ---
          Positioned(
            bottom: _barHeight + bottomInset - (_outerCircle / 2) - 4,
            child: GestureDetector(
              onTap: onCenterTap,
              child: Container(
                width: _outerCircle,
                height: _outerCircle,
                decoration: const BoxDecoration(
                  color: AppColors.surfaceColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 20,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Container(
                  width: _innerCircle,
                  height: _innerCircle,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.qr_code_2,
                    color: AppColors.secondaryColor,
                    size: AppDimensions.iconSizeLarge,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final IconData selectedIcon;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.selectedIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primaryColor : AppColors.iconMuted;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            selected ? selectedIcon : icon,
            color: color,
            size: AppDimensions.bottomNavIconSize,
          ),
          AppDimensions.verticalSpace4,
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: AppDimensions.bottomNavLabelSize,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
