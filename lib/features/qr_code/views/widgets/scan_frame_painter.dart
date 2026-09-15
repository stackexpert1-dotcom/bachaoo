import 'package:flutter/material.dart';

class ScanFramePainter extends CustomPainter {
  final Color color;
  final double cornerLength;
  final double strokeWidth;

  ScanFramePainter({
    required this.color,
    this.cornerLength = 32,
    this.strokeWidth = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final w = size.width;
    final h = size.height;

    // Top-left
    canvas.drawPath(
      Path()
        ..moveTo(cornerLength, 0)
        ..lineTo(0, 0)
        ..lineTo(0, cornerLength),
      paint,
    );
    // Top-right
    canvas.drawPath(
      Path()
        ..moveTo(w - cornerLength, 0)
        ..lineTo(w, 0)
        ..lineTo(w, cornerLength),
      paint,
    );
    // Bottom-left
    canvas.drawPath(
      Path()
        ..moveTo(0, h - cornerLength)
        ..lineTo(0, h)
        ..lineTo(cornerLength, h),
      paint,
    );
    // Bottom-right
    canvas.drawPath(
      Path()
        ..moveTo(w, h - cornerLength)
        ..lineTo(w, h)
        ..lineTo(w - cornerLength, h),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant ScanFramePainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.cornerLength != cornerLength;
}
