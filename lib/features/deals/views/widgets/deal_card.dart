import 'package:flutter/material.dart';

import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/businesses/models/nearby_business_model.dart';
import 'package:bachaoo/features/deals/models/deal_model.dart';

/// Universal deal / business card.
///
/// Photo on top with a discount badge, and a floating info panel that
/// overlaps the photo's bottom edge (logo, title, subtitle, rating, price).
/// Use it for Popular Discounts, Trending Deals, or any other deal list.
class DealCard extends StatelessWidget {
  /// Default image width-to-height ratio used by this card.
  static const double defaultImageAspectRatio = 1.9;

  /// Extra vertical space needed below the image for the overlapping panel.
  ///
  /// Use this when a parent must give a [DealCard] an explicit height, such
  /// as a grid or a horizontal list. Keeping the calculation here prevents a
  /// parent from becoming shorter than the card at larger screen widths.
  static const double _panelHeightAllowance = 112;

  final String? imageUrl;
  final String? badgeLabel;

  /// Brand logo. If null or it fails to load, [logoFallback] is shown instead.
  final String? logoUrl;
  final String logoFallback;
  final Color? logoFallbackColor;

  final String title;

  /// e.g. "Food • 0.03 km"
  final String subtitle;

  final double? rating;
  final int? reviewCount;

  /// Optional price row, e.g. "Rs 499" and the struck-through "Rs 599".
  final String? price;
  final String? originalPrice;

  /// Photo width / height. Higher = shorter photo.
  final double imageAspectRatio;
  final Color? badgeColor;
  final VoidCallback? onTap;

  const DealCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.imageUrl,
    this.badgeLabel,
    this.logoUrl,
    this.logoFallback = '',
    this.logoFallbackColor,
    this.rating,
    this.reviewCount,
    this.price,
    this.originalPrice,
    this.imageAspectRatio = defaultImageAspectRatio,
    this.badgeColor,
    this.onTap,
  });

  /// Convenience constructor so existing [DealModel] lists keep working.
  factory DealCard.fromDeal(DealModel deal, {Key? key, VoidCallback? onTap}) {
    return DealCard(
      key: key,
      imageUrl: deal.imageUrl,
      badgeLabel: deal.badgeLabel,
      logoUrl: deal.logoUrl,
      logoFallback: deal.brandTagShort,
      logoFallbackColor: deal.brandColor,
      title: deal.title,
      subtitle: deal.subtitle,
      rating: deal.rating,
      price: deal.currentPrice == null
          ? null
          : '${deal.currency} ${deal.currentPrice}',
      originalPrice: deal.originalPrice,
      onTap: onTap,
    );
  }

  /// Displays a business discount with the same layout as a deal card.
  factory DealCard.fromBusiness(
    BusinessModel business, {
    Key? key,
    VoidCallback? onTap,
  }) {
    return DealCard(
      key: key,
      imageUrl: business.coverImageUrl ?? business.imageUrl,
      badgeLabel: business.discountLabel,
      logoUrl: business.logoUrl,
      logoFallback: business.name.isEmpty
          ? ''
          : business.name.substring(0, 1).toUpperCase(),
      title: business.name,
      subtitle: business.discountSubtitle.isEmpty
          ? business.location
          : business.discountSubtitle,
      rating: business.rating,
      reviewCount: business.reviewCount,
      onTap: onTap,
    );
  }

  static const double _overlap = 20; // how far the panel covers the photo
  static const double _panelInset = 12;

  static double recommendedHeightForWidth(
    double width, {
    double imageAspectRatio = defaultImageAspectRatio,
  }) => width / imageAspectRatio + _panelHeightAllowance;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final photoHeight = constraints.maxWidth / imageAspectRatio;

          return Stack(
            children: [
              // Photo (fixed height from the aspect ratio)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: photoHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusXLarge,
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _buildPhoto(),
                      if (badgeLabel != null)
                        Positioned(
                          top: AppDimensions.spacingSmall,
                          left: AppDimensions.spacingSmall,
                          child: _buildBadge(),
                        ),
                    ],
                  ),
                ),
              ),

              // Info panel: sized by its content, pushed down so it
              // overlaps the bottom of the photo. This child also decides
              // the total card height, so it can never overflow.
              Padding(
                padding: EdgeInsets.fromLTRB(
                  _panelInset,
                  photoHeight - _overlap,
                  _panelInset,
                  0,
                ),
                child: _buildPanel(),
              ),
            ],
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------- photo

  Widget _buildPhoto() {
    final placeholder = Container(
      color: AppColors.disabledBackground,
      alignment: Alignment.center,
      child: const Icon(
        Icons.image_not_supported_outlined,
        color: AppColors.iconMuted,
      ),
    );

    // Brand-tile mode is intentionally gone: on every screen the big media
    // is the business/deal photo (food/banner image) and the small circle in
    // the info panel is the business logo. That keeps images consistent
    // between the home "Popular discounts", All Discounts and the explore
    // screen.

    if (imageUrl == null) return placeholder;

    return Image.network(
      imageUrl!,
      fit: BoxFit.cover,
      width: double.infinity,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          color: AppColors.disabledBackground,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.primaryColor,
          ),
        );
      },
      errorBuilder: (_, _, _) => placeholder,
    );
  }

  // ---------------------------------------------------------------- badge

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color:
            badgeColor ?? AppColors.appBackroundColor.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.discount_rounded,
            size: 20,
            color: AppColors.textPrimary,
          ),
          const SizedBox(width: 6),
          Text(
            badgeLabel!,
            maxLines: 1,
            softWrap: false,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------- panel

  Widget _buildPanel() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          _buildLogo(),
          const SizedBox(width: AppDimensions.spacingMedium),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                    fontSize: AppDimensions.fontSizeBodyMedium,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                _buildMetaRow(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    final fallback = Center(
      child: Text(
        logoFallback,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: AppDimensions.fontSizeBodyMedium,
          color: logoFallbackColor ?? AppColors.primaryColor,
        ),
      ),
    );

    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        child: logoUrl == null
            ? fallback
            : Image.network(
                logoUrl!,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => fallback,
              ),
      ),
    );
  }

  Widget _buildMetaRow() {
    return Row(
      children: [
        const Icon(
          Icons.storefront_outlined,
          size: 18,
          color: AppColors.textPrimary,
        ),
        if (rating != null) ...[
          const SizedBox(width: 8),
          const Icon(
            Icons.star_rounded,
            size: 18,
            color: AppColors.secondaryColor,
          ),
          const SizedBox(width: 2),
          Text(
            rating!.toStringAsFixed(1),
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: AppDimensions.fontSizeBodyMedium,
            ),
          ),
          if (reviewCount != null) ...[
            const SizedBox(width: 4),
            Text(
              '($reviewCount)',
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: AppDimensions.fontSizeBodyMedium,
              ),
            ),
          ],
        ],
        if (price != null) ...[
          const SizedBox(width: 8),
          Flexible(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: price,
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (originalPrice != null)
                    TextSpan(
                      text: '  $originalPrice',
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        decoration: TextDecoration.lineThrough,
                        fontSize: AppDimensions.fontSizeLabelMedium,
                      ),
                    ),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: AppDimensions.fontSizeBodyMedium,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
