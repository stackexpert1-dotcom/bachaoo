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

  static const double _barHeight = 82.0;
  static const double _outerCircle = 66.0;

  static const double _sideMargin = 14.0;
  static const double _bottomMargin = 12.0;
  static const double _barRadius = 30.0;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    final totalHeight =
        _barHeight + bottomInset + _bottomMargin + (_outerCircle / 2) - 8;

    return SizedBox(
      height: totalHeight,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // ============================================================
          // BOTTOM NAVIGATION BAR
          // ============================================================
          Positioned(
            left: _sideMargin,
            right: _sideMargin,
            bottom: bottomInset + _bottomMargin,
            child: ClipPath(
              clipper: const _NavigationNotchClipper(),
              child: Container(
                height: _barHeight,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(_barRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.10),
                      blurRadius: 16,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // ==================================================
                    // HOME
                    // ==================================================
                    _NavItem(
                      icon: Icons.home_outlined,
                      selectedIcon: Icons.home,
                      label: 'Home',
                      selected: currentIndex == 0,
                      onTap: () => onTap(0),
                    ),

                    // ==================================================
                    // CARD
                    // ==================================================
                    _NavItem(
                      icon: Icons.credit_card_outlined,
                      selectedIcon: Icons.credit_card,
                      label: 'Card',
                      selected: currentIndex == 1,
                      onTap: () {
                        onTap(1);
                        Get.toNamed(AppRoutes.loginRequiredScreen);
                      },
                    ),

                    // ==================================================
                    // CENTER QR SPACE
                    // ==================================================
                    const SizedBox(
                      width: _outerCircle - AppDimensions.spacingSmall,
                    ),

                    // ==================================================
                    // REFER
                    // ==================================================
                    _NavItem(
                      icon: Icons.card_giftcard_outlined,
                      selectedIcon: Icons.card_giftcard,
                      label: 'Refer',
                      selected: currentIndex == 3,
                      onTap: () {
                        onTap(3);
                        Get.toNamed(AppRoutes.referralScreen);
                      },
                    ),

                    // ==================================================
                    // PROFILE
                    // ==================================================
                    _NavItem(
                      icon: Icons.person_outline_rounded,
                      selectedIcon: Icons.person_rounded,
                      label: 'Profile',
                      selected: currentIndex == 4,
                      onTap: () {
                        onTap(4);

                        ProfileBottomSheet.show(
                          context,
                          initials: 'SU',
                          fullName: 'Shafqat Ullah',
                          profileImageUrl: 'https://i.pravatar.cc/300?img=12',
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
                              Get.toNamed(AppRoutes.subscriptionScreen),
                          onCategoriesTap: () =>
                              Get.toNamed(AppRoutes.categoryScreen),
                          onReferTap: () =>
                              Get.toNamed(AppRoutes.referralScreen),
                          onMyDealsTap: () =>
                              Get.toNamed(AppRoutes.myDealsScreen),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ============================================================
          // FLOATING QR BUTTON
          // ============================================================
          Positioned(
            bottom:
                _barHeight +
                bottomInset +
                _bottomMargin -
                (_outerCircle / 2) +
                8,
            child: Material(
              color: AppColors.white,
              shape: const CircleBorder(),
              elevation: 0,
              child: InkWell(
                onTap: onCenterTap,
                customBorder: const CircleBorder(),
                splashColor: AppColors.primaryColor.withValues(alpha: 0.10),
                highlightColor: AppColors.primaryColor.withValues(alpha: 0.06),
                child: Container(
                  width: _outerCircle,
                  height: _outerCircle,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primaryColor.withValues(alpha: 0.12),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.16),
                        blurRadius: 14,
                        spreadRadius: 1,
                        offset: const Offset(0, 7),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.qr_code_2, color: Colors.white, size: 30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// NAVIGATION NOTCH CLIPPER
// ============================================================================

/// Creates a shallow circular recess at the top center of the navigation bar
/// for the floating QR button.
class _NavigationNotchClipper extends CustomClipper<Path> {
  const _NavigationNotchClipper();

  @override
  Path getClip(Size size) {
    const notchHalfWidth = 43.0;
    const notchDepth = 31.0;

    final middle = size.width / 2;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(middle - notchHalfWidth, 0)
      ..cubicTo(middle - 39, 0, middle - 31, notchDepth, middle, notchDepth)
      ..cubicTo(
        middle + 31,
        notchDepth,
        middle + 39,
        0,
        middle + notchHalfWidth,
        0,
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant _NavigationNotchClipper oldClipper) {
    return false;
  }
}

// ============================================================================
// NAVIGATION ITEM
// ============================================================================

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
    // ================================================================
    // COLORS
    // ================================================================

    final Color foregroundColor = selected
        ? AppColors.primaryColor
        : Colors.black54;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      splashColor: AppColors.primaryColor.withValues(alpha: 0.08),
      highlightColor: AppColors.primaryColor.withValues(alpha: 0.05),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ============================================================
          // ICON
          // ============================================================
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
            decoration: BoxDecoration(
              color: selected
                  ? AppColors.primaryColor.withValues(alpha: 0.10)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(
                selected ? selectedIcon : icon,
                key: ValueKey(selected),
                color: foregroundColor,
                size: AppDimensions.bottomNavIconSize,
              ),
            ),
          ),

          const SizedBox(height: 2),

          // ============================================================
          // LABEL
          // ============================================================
          Text(
            label,
            style: TextStyle(
              color: foregroundColor,
              fontSize: AppDimensions.bottomNavLabelSize,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
