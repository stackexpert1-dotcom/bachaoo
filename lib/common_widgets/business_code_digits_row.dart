import 'package:flutter/material.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

/// Renders 4 boxes showing [code]'s characters, one per box. Empty boxes
/// stay blank until the staff-provided code is entered.
/// Purely presentational — pass [focusedIndex] to highlight one box.
class BusinessCodeDigitsRow extends StatelessWidget {
  final String code;
  final int focusedIndex;

  /// Each box is a square of this size (width == height).
  final double boxSize;

  const BusinessCodeDigitsRow({
    super.key,
    required this.code,
    this.focusedIndex = -1,
    this.boxSize = AppDimensions.businessCodeBoxSize,
  });

  @override
  Widget build(BuildContext context) {
    // Boxes are always square. If the requested [boxSize] is wider than the
    // available space we shrink it so the row never overflows on small screens.
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxBox = constraints.maxWidth / 4;
        final size = boxSize <= maxBox ? boxSize : maxBox;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (index) {
            final isFocused = index == focusedIndex;
            final char = index < code.length ? code[index] : null;
            return Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.surfaceColor,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                border: Border.all(
                  color: isFocused
                      ? AppColors.borderFocused
                      : AppColors.borderColor,
                  width: isFocused
                      ? AppDimensions.inputFocusedBorderWidth
                      : AppDimensions.inputBorderWidth,
                ),
              ),
              child: char == null
                  ? null
                  : Text(
                      char,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                        fontSize: AppDimensions.fontSizeHeadlineMedium,
                      ),
                    ),
            );
          }),
        );
      },
    );
  }
}
