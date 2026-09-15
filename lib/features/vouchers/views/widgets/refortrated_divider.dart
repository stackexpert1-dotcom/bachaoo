import 'package:flutter/material.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';

/// A thin vertical column of small circles that fakes a ticket-style
/// perforation between the colored amount block and the white content
/// block of a voucher list item.
///
/// Uses [CustomPaint] instead of [LayoutBuilder] so it can live inside
/// an [IntrinsicHeight] widget without triggering intrinsic-dimension
/// errors.
class PerforatedDivider extends StatelessWidget {
  final double dotSize;
  final double spacing;

  const PerforatedDivider({super.key, this.dotSize = 7, this.spacing = 9});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: dotSize,
      child: CustomPaint(
        painter: _PerforationPainter(
          dotSize: dotSize,
          spacing: spacing,
          color: AppColors.appBackroundColor,
        ),
      ),
    );
  }
}

class _PerforationPainter extends CustomPainter {
  final double dotSize;
  final double spacing;
  final Color color;

  _PerforationPainter({
    required this.dotSize,
    required this.spacing,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final radius = dotSize / 2;
    final step = dotSize + spacing;
    final count = (size.height / step).floor().clamp(1, 100);

    // Centre the column of dots vertically.
    final totalHeight = count * dotSize + (count - 1) * spacing;
    double y = (size.height - totalHeight) / 2 + radius;

    for (int i = 0; i < count; i++) {
      canvas.drawCircle(Offset(radius, y), radius, paint);
      y += step;
    }
  }

  @override
  bool shouldRepaint(_PerforationPainter old) =>
      old.dotSize != dotSize || old.spacing != spacing || old.color != color;
}
