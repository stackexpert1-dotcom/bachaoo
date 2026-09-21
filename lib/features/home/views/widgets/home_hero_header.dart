import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bachaoo/common_widgets/app_text.dart'; // for appFont (Sora)
import 'package:bachaoo/core/constants/bachaoo_assets.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class HomeHeroHeader extends StatelessWidget {
  final String userInitials;
  final String userName;
  final String? profileImageUrl;
  final DateTime date;
  final VoidCallback? onNotificationTap;
  final bool hasUnreadNotifications;
  final VoidCallback? onSearchTap;
  final bool isSearchOpen;

  const HomeHeroHeader({
    super.key,
    this.userInitials = 'SU',
    required this.userName,
    this.profileImageUrl,
    required this.date,
    this.onNotificationTap,
    this.hasUnreadNotifications = true,
    this.onSearchTap,
    this.isSearchOpen = false,
  });

  /// Height of the rounded "sheet" strip that overlaps the header bottom.
  static const double _sheetOverlap = 24;

  static const SystemUiOverlayStyle _lightIcons = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  );

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _lightIcons,
      child: _buildExpanded(topInset),
    );
  }

  Widget _buildExpanded(double topInset) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // ---------- gradient background + decorations ----------
        ClipRect(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0A2313), AppColors.primaryColor],
              ),
            ),
            child: Stack(
              children: [
                // Soft decorative circles
                Positioned(
                  top: -50,
                  right: -40,
                  child: _DecorCircle(
                    size: 190,
                    color: AppColors.secondaryColor.withValues(alpha: 0.12),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: -60,
                  child: _DecorCircle(
                    size: 170,
                    color: AppColors.white.withValues(alpha: 0.05),
                  ),
                ),
                Positioned(
                  top: 120,
                  right: 90,
                  child: _DecorCircle(
                    size: 26,
                    color: AppColors.secondaryColor.withValues(alpha: 0.35),
                  ),
                ),

                // Content
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppDimensions.pagePaddingSmall,
                    topInset + AppDimensions.spacingSmall,
                    AppDimensions.pagePaddingSmall,
                    _sheetOverlap + 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ------------------------------------------------
                      // TOP ROW
                      // ------------------------------------------------
                      Row(
                        children: [
                          _buildAvatar(),
                          const SizedBox(width: AppDimensions.spacingXSmall),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _formatDate(date),
                                  style: TextStyle(
                                    color: AppColors.white.withValues(
                                      alpha: 0.75,
                                    ),
                                    fontSize: AppDimensions.fontSizeBodyMedium,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                AppDimensions.verticalSpace1,
                                Text(
                                  'Hi, $userName',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                    height: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _HeaderIconButton(
                            icon: isSearchOpen
                                ? Icons.close_rounded
                                : Icons.search_rounded,
                            onTap: onSearchTap,
                            color: AppColors.white,
                          ),
                          const SizedBox(width: AppDimensions.spacingSmall),
                          _HeaderIconButton(
                            icon: Icons.notifications_none_rounded,
                            onTap: onNotificationTap,
                            showDot: hasUnreadNotifications,
                            color: AppColors.white,
                          ),
                        ],
                      ),

                      const SizedBox(height: AppDimensions.spacingMedium),

                      // ------------------------------------------------
                      // BRAND BLOCK (left) + MASCOT (right)
                      // ------------------------------------------------
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: _buildBrandBlock()),
                          const SizedBox(width: AppDimensions.spacingXSmall),

                          // Fixed-size area prevents the mascot from
                          // overflowing or getting squeezed by the Row.
                          SizedBox(
                            width: 125,
                            height: 140,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                AppAssets.mascotKoala,
                                width: 125,
                                height: 140,
                                fit: BoxFit.cover,
                                alignment: Alignment.centerRight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // ---------- rounded top corners of the sheet ----------
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: _sheetOverlap,
            decoration: const BoxDecoration(
              color: AppColors.appBackroundColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppDimensions.radiusXXLarge),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------------
  // Brand block: logo, headline, tagline
  // ------------------------------------------------------------------
  Widget _buildBrandBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // // Logo on a white rounded tile so it stays visible on the dark
        // // gradient whatever its colors are.
        // Container(
        //   width: 56,
        //   height: 56,
        //   padding: const EdgeInsets.all(8),
        //   decoration: BoxDecoration(
        //     color: AppColors.white,
        //     borderRadius: BorderRadius.circular(16),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.black.withValues(alpha: 0.25),
        //         blurRadius: 12,
        //         offset: const Offset(0, 4),
        //       ),
        //     ],
        //   ),
        //   child: Image.asset(AppAssets.bachaooLogo, fit: BoxFit.contain),
        // ),

        // const SizedBox(height: 14),

        // Headline
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Save More with ',
                style: appFont(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
              TextSpan(
                text: 'Bachaoo',
                style: appFont(
                  color: AppColors.secondaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),
            ],
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),

        const SizedBox(height: 10),

        // Tagline with gold accent bar
        Row(
          children: [
            Container(
              width: 22,
              height: 3,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Your Deals, Your Savings',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: appFont(
                  color: AppColors.white.withValues(alpha: 0.85),
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 44,
      height: 44,
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFC79A4B), Color(0xFF8A6A2F)],
        ),
      ),
      child: profileImageUrl == null
          ? _buildInitials()
          : Image.network(
              profileImageUrl!,
              width: 44,
              height: 44,
              fit: BoxFit.cover,
              // Fall back to the initial-based avatar while the photo loads
              // or if it ever fails, instead of a broken-image box.
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return _buildInitials();
              },
              errorBuilder: (_, _, _) => _buildInitials(),
            ),
    );
  }

  Widget _buildInitials() {
    return Text(
      userInitials,
      style: const TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w700,
        fontSize: AppDimensions.fontSizeBodyMedium,
      ),
    );
  }

  String _formatDate(DateTime date) {
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${weekdays[date.weekday - 1]}, '
        '${date.day} ${months[date.month - 1]}';
  }
}

class _DecorCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _DecorCircle({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool showDot;
  final Color color;

  const _HeaderIconButton({
    required this.icon,
    this.onTap,
    this.showDot = false,
    this.color = AppColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 40,
        height: 40,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(icon, color: color, size: AppDimensions.iconSizeLarge),
            if (showDot)
              Positioned(
                top: 8,
                right: 9,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
