import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileBottomSheet extends StatelessWidget {
  final String initials;
  final String fullName;
  final String? profileImageUrl;
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
  final VoidCallback? onMyDealsTap;
  final VoidCallback? onWhatsappTap;

  /// Scroll controller supplied by the enclosing [DraggableScrollableSheet].
  /// Lets the sheet expand/collapse when the user drags the content up/down,
  /// and keeps the inner content scrolling once fully expanded.

  final ScrollController? scrollController;

  const ProfileBottomSheet({
    super.key,
    required this.initials,
    required this.fullName,
    this.profileImageUrl,
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
    this.onMyDealsTap,
    this.onWhatsappTap,
    this.scrollController,
  });

  static Future<void> show(
    BuildContext context, {
    required String initials,
    required String fullName,
    String? profileImageUrl,
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
    VoidCallback? onMyDealsTap,
    required VoidCallback onWhatsappTap,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      // Cap the sheet at ~70% of the screen height; the inner
      // bottom. Dragging / scrolling up expands its height: full content first,
      // No fixed height cap — the enclosing DraggableScrollableSheet manages
      // the sheet's height (starts at~70%, expands on drag up).
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.7,
        minChildSize: 0.3,
        maxChildSize: 1.0,
        builder: (_, scrollController) => ProfileBottomSheet(
          initials: initials,
          fullName: fullName,
          profileImageUrl: profileImageUrl,
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
          onMyDealsTap: onMyDealsTap,
          scrollController: scrollController,
        ),
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
        background: AppColors.successLight,
        iconColor: AppColors.primaryColor,
        onTap: () => go(onEditProfile),
      ),
      _QuickAction(
        icon: Icons.confirmation_number_outlined,
        label: 'Vouchers',
        background: AppColors.warningLight,
        iconColor: AppColors.warningDark,
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
        background: const Color(0xFFE5F1E8),
        iconColor: AppColors.successDark,
        onTap: () => go(onInboxTap),
      ),
      _QuickAction(
        icon: Icons.grid_view_rounded,
        label: 'Categories',
        background: const Color(0xFFE8F1F7),
        iconColor: AppColors.info,
        onTap: () => go(onCategoriesTap),
      ),
      _QuickAction(
        icon: Icons.share_outlined,
        label: 'Refer & earn',
        background: const Color(0xFFFAF2DE),
        iconColor: AppColors.warningDark,
        onTap: () => go(onReferTap),
      ),
      _QuickAction(
        icon: Icons.phone_outlined,
        label: 'Contact us',
        background: const Color(0xFFE5F1E8),
        iconColor: AppColors.successDark,
        onTap: () => go(onContactTap),
      ),
      _QuickAction(
        icon: Icons.local_offer_outlined,
        label: 'My deals',
        background: const Color(0xFFFAF2DE),
        iconColor: AppColors.warningDark,
        onTap: () => go(onMyDealsTap),
      ),
      _QuickAction(
        faIcon: FontAwesomeIcons.whatsapp,
        label: "WhatsApp",
        background: const Color(0xffE5F1E8),
        iconColor: Colors.green,
        onTap: () => go(onWhatsappTap),
      ),
    ];

    return SafeArea(
      top: false,
      bottom: false,
      child: Container(
        // Full width of the screen — no side margins.
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDimensions.bottomSheetRadius),
          ),
        ),
        child: SingleChildScrollView(
          controller: scrollController,
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
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                  bottom: AppDimensions.spacingLarge,
                ),
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF0A321A), AppColors.primaryColor],
                  ),
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusXLarge,
                  ),
                ),
                child: Column(
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
                          color: AppColors.white.withValues(alpha: 0.45),
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
                          child: profileImageUrl == null
                              ? Text(
                                  initials,
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: AppDimensions.fontSizeTitleLarge,
                                  ),
                                )
                              : ClipOval(
                                  child: Image.network(
                                    profileImageUrl!,
                                    width: AppDimensions.avatarLarge,
                                    height: AppDimensions.avatarLarge,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, _, _) => Center(
                                      child: Text(
                                        initials,
                                        style: const TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize:
                                              AppDimensions.fontSizeTitleLarge,
                                        ),
                                      ),
                                    ),
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
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: AppDimensions.fontSizeTitleLarge,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '$membershipLabel \u00b7 ${_formatPoints(points)} pts',
                                style: const TextStyle(
                                  color: Color(0xD9FFFFFF),
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
                              horizontal: AppDimensions.spacingXSmall,
                              vertical: AppDimensions.spacingXXSmall,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.edit_outlined,
                                  color: AppColors.white,
                                  size: AppDimensions.iconSizeXSmall,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Edit',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: AppDimensions.fontSizeBodySmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // quick actions grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: actions.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: AppDimensions.spacingSmall,
                  crossAxisSpacing: AppDimensions.spacingSmall,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) => actions[index],
              ),

              const SizedBox(height: AppDimensions.spacingSmall),

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
                      icon: Icons.help_outline_rounded,
                      title: 'Help & support',
                      onTap: () => go(onHelpTap),
                    ),
                    const _MenuDivider(),
                    _MenuListItem(
                      icon: Icons.info_outline_rounded,
                      title: 'About Bachaoo',
                      onTap: () => go(onAboutTap),
                    ),
                    const _MenuDivider(),
                    _MenuListItem(
                      icon: Icons.shield_outlined,
                      title: 'Policies',
                      subtitle: 'Privacy \u00b7 Terms \u00b7 Refund \u00b7 Cancellation',
                      onTap: () => go(onPoliciesTap),
                    ),
                    const _MenuDivider(),
                    _MenuListItem(
                      icon: Icons.logout_rounded,
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
  final IconData? icon;
  final FaIconData? faIcon;
  final String label;
  final Color background;
  final Color iconColor;
  final VoidCallback? onTap;

  const _QuickAction({
    this.icon,
    required this.label,
    this.faIcon,
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
            child: faIcon != null
                ? FaIcon(
                    faIcon,
                    color: iconColor,
                    size: AppDimensions.iconSizeLarge,
                  )
                : Icon(
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
              fontWeight: FontWeight.w700,
              fontSize: AppDimensions.fontSizeBodyXSmall,
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuListItem extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String? subtitle;
  final Color? titleColor;
  final bool showChevron;
  final VoidCallback? onTap;

  const _MenuListItem({
    this.icon,
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
            Container(
              width: 36,
              height: 36,
              margin: const EdgeInsets.only(right: AppDimensions.spacingSmall),
              decoration: BoxDecoration(
                color: (titleColor ?? AppColors.primaryColor).withValues(
                  alpha: 0.10,
                ),
                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              ),
              child: Icon(
                icon,
                color: titleColor ?? AppColors.primaryColor,
                size: AppDimensions.iconSizeSmall,
              ),
            ),
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
