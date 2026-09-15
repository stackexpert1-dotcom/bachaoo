import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:flutter/material.dart';

/// The dark-green rounded gradient container that shows up on the member
/// card AND the "Refer & earn" header. Pulled out on its own so every
/// screen that needs "the green card" reuses one shape/shadow/gradient
/// definition instead of each copying its own BoxDecoration.
///
/// Content is entirely up to the caller via [child] — this widget only
/// owns the shell (gradient, radius, shadow, optional watermark icon), so
/// what's printed on top of it — and whether a big number is shown at all
/// — is decided by whoever builds that child.
class GradientPromoCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final IconData? watermarkIcon;

  const GradientPromoCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.watermarkIcon,
  });

  @override
  Widget build(BuildContext context) {
    // Use the app's primary green instead of the (default Material = blue)
    // theme color, so the promo card matches the brand everywhere.
    final primary = AppColors.primaryColor;
    final hsl = HSLColor.fromColor(primary);
    final darker = hsl
        .withLightness((hsl.lightness * 0.55).clamp(0.0, 1.0))
        .toColor();

    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primary, darker],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (watermarkIcon != null)
            Positioned(
              right: -16,
              bottom: -16,
              child: Icon(
                watermarkIcon,
                size: 130,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          child,
        ],
      ),
    );
  }
}
