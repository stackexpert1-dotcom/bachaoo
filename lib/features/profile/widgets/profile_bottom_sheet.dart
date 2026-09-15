import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:flutter/material.dart';

class ProfileBottomSheet extends StatelessWidget {
  final String initials;
  final String fullName;
  final String membershipLabel;
  final int points;
  final VoidCallback onEditProfile;
  final VoidCallback onLogout;
  final VoidCallback? onProfileTap;
  final VoidCallback? onVouchersTap;
  final VoidCallback? onVirtualCardTap;
  final VoidCallback? onInboxTap;
  final VoidCallback? onCategoriesTap;
  final VoidCallback? onReferTap;
  final VoidCallback? onContactTap;
  final VoidCallback? onHelpTap;
  final VoidCallback? onAboutTap;
  final VoidCallback? onPoliciesTap;

  const ProfileBottomSheet({
    super.key,
    required this.initials,
    required this.fullName,
    required this.membershipLabel,
    required this.points,
    required this.onEditProfile,
    required this.onLogout,
    this.onProfileTap,
    this.onVouchersTap,
    this.onVirtualCardTap,
    this.onInboxTap,
    this.onCategoriesTap,
    this.onReferTap,
    this.onContactTap,
    this.onHelpTap,
    this.onAboutTap,
    this.onPoliciesTap,
  });

  static Future<void> show(
    BuildContext context, {
    required String initials,
    required String fullName,
    required String membershipLabel,
    required int points,
    required VoidCallback onEditProfile,
    required VoidCallback onLogout,
    VoidCallback? onProfileTap,
    VoidCallback? onVouchersTap,
    VoidCallback? onVirtualCardTap,
    VoidCallback? onInboxTap,
    VoidCallback? onCategoriesTap,
    VoidCallback? onReferTap,
    VoidCallback? onContactTap,
    VoidCallback? onHelpTap,
    VoidCallback? onAboutTap,
    VoidCallback? onPoliciesTap,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => ProfileBottomSheet(
        initials: initials,
        fullName: fullName,
        membershipLabel: membershipLabel,
        points: points,
        onEditProfile: onEditProfile,
        onLogout: onLogout,
        onProfileTap: onProfileTap,
        onVouchersTap: onVouchersTap,
        onVirtualCardTap: onVirtualCardTap,
        onInboxTap: onInboxTap,
        onCategoriesTap: onCategoriesTap,
        onReferTap: onReferTap,
        onContactTap: onContactTap,
        onHelpTap: onHelpTap,
        onAboutTap: onAboutTap,
        onPoliciesTap: onPoliciesTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Closes the sheet first so the destination screen doesn't open on top of
    // the modal, then runs the actual navigation action.
    void go(VoidCallback? action) {
      Navigator.of(context).pop();
      action?.call();
    }

    final actions = <_QuickAction>[
      _QuickAction(
        icon: Icons.person_outline_rounded,
        label: 'Profile',
        background: const Color(0xFFDCE8F5),
        iconColor: const Color(0xFF2B5E8C),
        onTap: () => go(onEditProfile),
      ),
      _QuickAction(
        icon: Icons.confirmation_number_outlined,
        label: 'Vouchers',
        background: const Color(0xFFF7DCE4),
        iconColor: const Color(0xFFB13B5C),
        onTap: () => go(onVouchersTap),
      ),
      _QuickAction(
        icon: Icons.credit_card_rounded,
        label: 'Virtual card',
        background: const Color(0xFFDCEBDD),
        iconColor: AppColors.primaryColor,
        onTap: () => go(onVirtualCardTap),
      ),
      _QuickAction(
        icon: Icons.chat_bubble_outline_rounded,
        label: 'Inbox',
        background: const Color(0xFFDDE1E6),
        iconColor: const Color(0xFF3A4652),
        onTap: () => go(onInboxTap),
      ),
      _QuickAction(
        icon: Icons.grid_view_rounded,
        label: 'Categories',
        background: const Color(0xFFE6DFF5),
        iconColor: const Color(0xFF6A4CA0),
        onTap: () => go(onCategoriesTap),
      ),
      _QuickAction(
        icon: Icons.share_outlined,
        label: 'Refer & earn',
        background: const Color(0xFFF6DFD3),
        iconColor: const Color(0xFFC1602A),
        onTap: () => go(onReferTap),
      ),
      _QuickAction(
        icon: Icons.phone_outlined,
        label: 'Contact us',
        background: const Color(0xFFE1E9D6),
        iconColor: const Color(0xFF5C7A3A),
        onTap: () => go(onContactTap),
      ),
    ];

    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(AppDimensions.bottomSheetRadius),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppDimensions.pagePadding,
            AppDimensions.spacingSmall,
            AppDimensions.pagePadding,
            AppDimensions.spacingLarge,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // drag handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(
                    bottom: AppDimensions.spacingLarge,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.borderStrong,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusRound,
                    ),
                  ),
                ),
              ),

              // profile row
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: AppDimensions.avatarLarge,
                    height: AppDimensions.avatarLarge,
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
                        fontSize: AppDimensions.fontSizeTitleLarge,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacingMedium),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fullName,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w800,
                            fontSize: AppDimensions.fontSizeTitleLarge,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '$membershipLabel \u00b7 ${_formatPoints(points)} pts',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: AppDimensions.fontSizeBodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: onEditProfile,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppDimensions.spacingXXSmall,
                      ),
                      child: Text(
                        'Edit profile',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: AppDimensions.fontSizeBodySmall,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppDimensions.spacingXXLarge),

              // quick actions grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: actions.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: AppDimensions.spacingSmall,
                  crossAxisSpacing: AppDimensions.spacingSmall,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) => actions[index],
              ),

              const SizedBox(height: AppDimensions.spacingLarge),

              // menu list card
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor),
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusXLarge,
                  ),
                ),
                child: Column(
                  children: [
                    _MenuListItem(
                      title: 'Help & support',
                      onTap: () => go(onHelpTap),
                    ),
                    const _MenuDivider(),
                    _MenuListItem(
                      title: 'About Bachaoo',
                      onTap: () => go(onAboutTap),
                    ),
                    const _MenuDivider(),
                    _MenuListItem(
                      title: 'Policies',
                      subtitle: 'Privacy \u00b7 Terms \u00b7 Refund \u00b7 Cancellation',
                      onTap: () => go(onPoliciesTap),
                    ),
                    const _MenuDivider(),
                    _MenuListItem(
                      title: 'Log out',
                      titleColor: AppColors.error,
                      showChevron: false,
                      onTap: () => go(onLogout),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppDimensions.spacingXLarge),

              Center(
                child: Text(
                  'Powered by De Virtual Club \u00b7 v3.0',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: AppDimensions.fontSizeBodyMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _formatPoints(int points) {
    final s = points.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final posFromEnd = s.length - i;
      buffer.write(s[i]);
      if (posFromEnd > 1 && posFromEnd % 3 == 1) buffer.write(',');
    }
    return buffer.toString();
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color background;
  final Color iconColor;
  final VoidCallback? onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.background,
    required this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: AppDimensions.avatarLarge,
            height: AppDimensions.avatarLarge,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: AppDimensions.iconSizeLarge,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingXSmall),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: AppDimensions.fontSizeBodyXSmall,
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Color? titleColor;
  final bool showChevron;
  final VoidCallback? onTap;

  const _MenuListItem({
    required this.title,
    this.subtitle,
    this.titleColor,
    this.showChevron = true,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: titleColor ?? AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: AppDimensions.fontSizeTitleSmall,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: AppDimensions.fontSizeBodyMedium,
                        height: AppDimensions.lineHeightNormal,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (showChevron)
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

class _MenuDivider extends StatelessWidget {
  const _MenuDivider();

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
