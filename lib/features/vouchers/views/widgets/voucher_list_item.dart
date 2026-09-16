import 'package:bachaoo/features/vouchers/views/models/voucher_model.dart';
import 'package:flutter/material.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

/// A single voucher rendered as a ticket stub.
///
/// The entire ticket is a single white card with a shadow.
/// The left amount block is colored and has scallops cut out of its right edge.
/// Because the card background is white, these scallops appear as white dots,
/// matching the right side of the ticket perfectly.
class VoucherListItem extends StatelessWidget {
  final VoucherModel voucher;

  const VoucherListItem({super.key, required this.voucher});

  bool get _isFree => voucher.type == VoucherType.free;

  Color get _blockColor =>
      _isFree ? AppColors.secondaryColor : AppColors.primaryColor;

  Color get _blockTextColor =>
      _isFree ? AppColors.textOnSecondary : AppColors.textOnPrimary;

  static const double _cornerRadius = AppDimensions.cardRadius;
  static const double _scallopRadius = 5.0;
  static const double _amountWidth = 110.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(_cornerRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Scalloped amount block ──────────────────
            // Cuts scallops on the right edge, revealing the white card underneath.
            ClipPath(
              clipper: const _RightScallopClipper(
                scallopRadius: _scallopRadius,
                cornerRadius: _cornerRadius,
              ),
              child: Container(
                width: _amountWidth,
                color: _blockColor,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: AppDimensions.paddingLarge,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      voucher.amountLabel,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: _blockTextColor,
                        height: AppDimensions.lineHeightTight,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      voucher.amountCaption,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: AppDimensions.fontSizeBodyMedium,
                        fontWeight: FontWeight.w500,
                        color: _blockTextColor.withValues(alpha: 0.80),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Details block ──────────────────────────
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(AppDimensions.paddingSmall),
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Vertically center the image
                  children: [
                    // Thumbnail
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.cardImageRadius,
                      ),
                      child: Image.network(
                        voucher.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 60,
                          height: 60,
                          color: AppColors.disabledBackground,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Text content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Title
                          Text(
                            voucher.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: AppDimensions.fontSizeBodySmall,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                              height: AppDimensions.lineHeightTight,
                            ),
                          ),
                          const SizedBox(height: 2),

                          // Subtitle
                          Text(
                            voucher.subtitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: AppDimensions.fontSizeBodyXSmall,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textHint,
                              height: AppDimensions.lineHeightNormal,
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Expiry + Use now
                          Row(
                            children: [
                              Expanded(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    voucher.expiryLabel,
                                    style: const TextStyle(
                                      fontSize:
                                          AppDimensions.fontSizeBodyXSmall,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textHint,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              GestureDetector(
                                onTap: voucher.onUseNow,
                                child: const Text(
                                  'Use now',
                                  style: TextStyle(
                                    fontSize: AppDimensions.fontSizeBodySmall,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryColor,
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
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────
//  Scalloped-edge clipper (Only right side)
// ──────────────────────────────────────────────────────────────────

class _RightScallopClipper extends CustomClipper<Path> {
  final double scallopRadius;
  final double cornerRadius;

  const _RightScallopClipper({
    required this.scallopRadius,
    required this.cornerRadius,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    final cr = cornerRadius;
    final r = scallopRadius;
    final d = r * 2;

    path.moveTo(0, cr);
    path.arcToPoint(Offset(cr, 0), radius: Radius.circular(cr));
    path.lineTo(size.width, 0);

    final count = (size.height / d).floor();
    final totalScallopHeight = count * d;
    final startY = (size.height - totalScallopHeight) / 2;

    path.lineTo(size.width, startY);

    for (int i = 0; i < count; i++) {
      final y = startY + i * d;
      path.arcToPoint(
        Offset(size.width, y + d),
        radius: Radius.circular(r),
        clockwise: false,
      );
    }

    path.lineTo(size.width, size.height);
    path.lineTo(cr, size.height);
    path.arcToPoint(Offset(0, size.height - cr), radius: Radius.circular(cr));

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _RightScallopClipper oldClipper) =>
      oldClipper.scallopRadius != scallopRadius ||
      oldClipper.cornerRadius != cornerRadius;
}
