import 'package:flutter/material.dart';

/// Draws a dashed rounded-rect border around [child] without pulling in an
/// extra package. Used for the "Your code" box, but generic enough to reuse
/// anywhere else a dashed outline is needed.
class DashedBorderContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final double borderRadius;
  final double dashWidth;
  final double dashGap;
  final double strokeWidth;

  const DashedBorderContainer({
    super.key,
    required this.child,
    required this.color,
    this.borderRadius = 16,
    this.dashWidth = 6,
    this.dashGap = 4,
    this.strokeWidth = 1.4,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedRRectPainter(
        color: color,
        radius: borderRadius,
        dashWidth: dashWidth,
        dashGap: dashGap,
        strokeWidth: strokeWidth,
      ),
      child: child,
    );
  }
}

class _DashedRRectPainter extends CustomPainter {
  final Color color;
  final double radius;
  final double dashWidth;
  final double dashGap;
  final double strokeWidth;

  _DashedRRectPainter({
    required this.color,
    required this.radius,
    required this.dashWidth,
    required this.dashGap,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    final path = Path()..addRRect(rrect);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final end = (distance + dashWidth).clamp(0.0, metric.length);
        canvas.drawPath(metric.extractPath(distance, end), paint);
        distance = end + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRRectPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.radius != radius;
}
