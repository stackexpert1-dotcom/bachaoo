import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

/// ============================================================
/// BACHOOO APP FONT
/// ============================================================
///
/// Bachaoo uses the Sora font family throughout the application.
///
/// Sora weights:
/// 300 - Light
/// 400 - Regular
/// 500 - Medium
/// 600 - Semi Bold
/// 700 - Bold
/// 800 - Extra Bold
///
/// The UI mainly uses 400, 500, 600 and 700.
/// Weight 800 is intentionally avoided for normal headings
/// because it makes the typography look too heavy.
/// ============================================================

final TextStyle Function({
  TextStyle? textStyle,
  Color? color,
  Color? backgroundColor,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  double? letterSpacing,
  double? wordSpacing,
  TextBaseline? textBaseline,
  double? height,
  Locale? locale,
  Paint? foreground,
  Paint? background,
  List<Shadow>? shadows,
  List<FontFeature>? fontFeatures,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
})
appFont = GoogleFonts.sora;

/// ============================================================
/// CENTRALIZED TEXT WIDGET
/// ============================================================
///
/// Example:
///
/// AppText.headlineSmall('Near you')
///
/// AppText.titleLarge('Al-Buraq')
///
/// AppText.bodyMedium('Satellite Town · 1.2 km')
/// ============================================================

class AppText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const AppText(
    this.text, {
    super.key,
    required this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  // ============================================================
  // DISPLAY
  // ============================================================
  // Large promotional text / hero text / important numbers
  // ============================================================

  factory AppText.displayLarge(
    String text, {
    Color color = AppColors.textPrimary,
    TextAlign? textAlign,
  }) {
    return AppText(
      text,
      textAlign: textAlign,
      style: appFont(
        fontSize: AppDimensions.fontSizeDisplayLarge,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.8,
        height: 1.1,
        color: color,
      ),
    );
  }

  factory AppText.displayMedium(
    String text, {
    Color color = AppColors.textPrimary,
    TextAlign? textAlign,
  }) {
    return AppText(
      text,
      textAlign: textAlign,
      style: appFont(
        fontSize: AppDimensions.fontSizeDisplayMedium,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.6,
        height: 1.1,
        color: color,
      ),
    );
  }

  // ============================================================
  // HEADLINE
  // ============================================================
  // Screen headings / section headings
  // ============================================================

  factory AppText.headlineLarge(
    String text, {
    Color color = AppColors.textPrimary,
    TextAlign? textAlign,
  }) {
    return AppText(
      text,
      textAlign: textAlign,
      style: appFont(
        fontSize: AppDimensions.fontSizeHeadlineLarge,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
        height: 1.18,
        color: color,
      ),
    );
  }

  factory AppText.headlineMedium(
    String text, {
    Color color = AppColors.textPrimary,
    TextAlign? textAlign,
  }) {
    return AppText(
      text,
      textAlign: textAlign,
      style: appFont(
        fontSize: AppDimensions.fontSizeHeadlineMedium,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
        height: 1.2,
        color: color,
      ),
    );
  }

  factory AppText.headlineSmall(
    String text, {
    Color color = AppColors.textPrimary,
    TextAlign? textAlign,
  }) {
    return AppText(
      text,
      textAlign: textAlign,
      style: appFont(
        fontSize: AppDimensions.fontSizeHeadlineSmall,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
        height: 1.2,
        color: color,
      ),
    );
  }

  factory AppText.headlineXSmall(
    String text, {
    Color color = AppColors.textPrimary,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: appFont(
        fontSize: AppDimensions.fontSizeHeadlineXSmall,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.1,
        height: 1.25,
        color: color,
      ),
    );
  }

  /// Compact navigation/app-bar title.
  factory AppText.appBarTitle(
    String text, {
    Color color = AppColors.textPrimary,
    TextAlign? textAlign,
  }) {
    return AppText(
      text,
      textAlign: textAlign,
      style: appFont(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: color,
      ),
    );
  }

  // ============================================================
  // TITLE
  // ============================================================
  // Card titles / restaurant names / list item titles
  // ============================================================

  factory AppText.titleLarge(
    String text, {
    Color color = AppColors.textPrimary,
    TextAlign? textAlign,
  }) {
    return AppText(
      text,
      textAlign: textAlign,
      style: appFont(
        fontSize: AppDimensions.fontSizeTitleLarge,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
        height: 1.2,
        color: color,
      ),
    );
  }

  factory AppText.titleMedium(
    String text, {
    Color color = AppColors.textPrimary,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: appFont(
        fontSize: AppDimensions.fontSizeTitleMedium,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.1,
        height: 1.2,
        color: color,
      ),
    );
  }

  factory AppText.titleSmall(
    String text, {
    Color color = AppColors.textPrimary,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: appFont(
        fontSize: AppDimensions.fontSizeTitleSmall,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        height: 1.2,
        color: color,
      ),
    );
  }

  factory AppText.titleXSmall(
    String text, {
    Color color = AppColors.textPrimary,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: appFont(
        fontSize: AppDimensions.fontSizetitleXSmall,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        height: 1.2,
        color: color,
      ),
    );
  }

  // ============================================================
  // BODY
  // ============================================================
  // Addresses / descriptions / secondary information
  // ============================================================

  factory AppText.bodyLarge(
    String text, {
    Color color = AppColors.textPrimary,
    FontWeight fontWeight = FontWeight.w400,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: appFont(
        fontSize: AppDimensions.fontSizeBodyLarge,
        fontWeight: fontWeight,
        height: 1.45,
        color: color,
      ),
    );
  }

  factory AppText.bodyMedium(
    String text, {
    Color color = AppColors.textSecondary,
    FontWeight fontWeight = FontWeight.w400,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: appFont(
        fontSize: AppDimensions.fontSizeBodyMedium,
        fontWeight: fontWeight,
        height: 1.4,
        color: color,
      ),
    );
  }

  factory AppText.bodySmall(
    String text, {
    Color color = AppColors.textHint,
    FontWeight fontWeight = FontWeight.w400,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: appFont(
        fontSize: AppDimensions.fontSizeBodySmall,
        fontWeight: fontWeight,
        height: 1.35,
        color: color,
      ),
    );
  }

  factory AppText.bodyXSmall(
    String text, {
    Color color = AppColors.textHint,
    FontWeight fontWeight = FontWeight.w400,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: appFont(
        fontSize: AppDimensions.fontSizeBodyXSmall,
        fontWeight: fontWeight,
        height: 1.3,
        color: color,
      ),
    );
  }

  // ============================================================
  // LABEL
  // ============================================================
  // Buttons / chips / small actions / discount labels
  // ============================================================

  factory AppText.labelLarge(
    String text, {
    Color color = AppColors.textPrimary,
    TextAlign? textAlign,
  }) {
    return AppText(
      text,
      textAlign: textAlign,
      style: appFont(
        fontSize: AppDimensions.fontSizeLabelLarge,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.05,
        color: color,
      ),
    );
  }

  factory AppText.labelSmall(
    String text, {
    Color color = AppColors.textHint,
    TextAlign? textAlign,
  }) {
    return AppText(
      text,
      textAlign: textAlign,
      style: appFont(
        fontSize: AppDimensions.fontSizeLabelSmall,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        color: color,
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
