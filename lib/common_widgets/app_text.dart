import 'package:flutter/material.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

/// Centralized text styles — use the named constructors instead of
/// writing `Text(..., style: TextStyle(...))` everywhere.
///
/// Example: AppText.headlineSmall('Categories')
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
  // DISPLAY — hero numbers, splash titles
  // ============================================================
  factory AppText.displayLarge(
    String text, {
    Color color = AppColors.textPrimary,
    TextAlign? textAlign,
  }) => AppText(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: AppDimensions.fontSizeDisplayLarge,
      fontWeight: FontWeight.w800,
      color: color,
    ),
  );

  factory AppText.displayMedium(
    String text, {
    Color color = AppColors.textPrimary,
    TextAlign? textAlign,
  }) => AppText(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: AppDimensions.fontSizeDisplayMedium,
      fontWeight: FontWeight.w800,
      color: color,
    ),
  );

  // ============================================================
  // HEADLINE — screen / section titles (e.g. "Categories")
  // ============================================================
  factory AppText.headlineLarge(
    String text, {
    Color color = AppColors.textPrimary,
    TextAlign? textAlign,
  }) => AppText(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: AppDimensions.fontSizeHeadlineLarge,
      fontWeight: FontWeight.w800,
      color: color,
    ),
  );

  factory AppText.headlineMedium(
    String text, {
    Color color = AppColors.textPrimary,
    TextAlign? textAlign,
  }) => AppText(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: AppDimensions.fontSizeHeadlineMedium,
      fontWeight: FontWeight.w800,
      color: color,
    ),
  );

  factory AppText.headlineSmall(
    String text, {
    Color color = AppColors.textPrimary,
    TextAlign? textAlign,
  }) => AppText(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: AppDimensions.fontSizeHeadlineSmall,
      fontWeight: FontWeight.w800,
      color: color,
    ),
  );
  factory AppText.headlineXSmall(
    String text, {
    Color color = AppColors.textPrimary,
    TextAlign? textAlign,
  }) => AppText(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontWeight: FontWeight.w800,
      color: color,
      fontSize: AppDimensions.fontSizeHeadlineXSmall,
    ),
  );

  // ============================================================
  // TITLE — card headings, list item titles
  // ============================================================
  factory AppText.titleLarge(
    String text, {
    Color color = AppColors.textPrimary,
    TextAlign? textAlign,
  }) => AppText(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: AppDimensions.fontSizeTitleLarge,
      fontWeight: FontWeight.w700,
      color: color,
    ),
  );

  factory AppText.titleMedium(
    String text, {
    Color color = AppColors.textPrimary,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) => AppText(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    style: TextStyle(
      fontSize: AppDimensions.fontSizeTitleMedium,
      fontWeight: FontWeight.w700,
      color: color,
    ),
  );

  factory AppText.titleSmall(
    String text, {
    Color color = AppColors.textPrimary,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) => AppText(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    style: TextStyle(
      fontSize: AppDimensions.fontSizeTitleSmall,
      fontWeight: FontWeight.w700,
      color: color,
    ),
  );

  factory AppText.titleXSmall(
    String text, {
    Color color = AppColors.textPrimary,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) => AppText(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    style: TextStyle(
      fontSize: AppDimensions.fontSizetitleXXSmall,
      fontWeight: FontWeight.w700,
      color: color,
    ),
  );

  // ============================================================
  // BODY — normal paragraph / field text
  // ============================================================
  factory AppText.bodyLarge(
    String text, {
    Color color = AppColors.textPrimary,
    FontWeight fontWeight = FontWeight.w400,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) => AppText(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    style: TextStyle(
      fontSize: AppDimensions.fontSizeBodyLarge,
      fontWeight: fontWeight,
      color: color,
    ),
  );

  factory AppText.bodyMedium(
    String text, {
    Color color = AppColors.textSecondary,
    FontWeight fontWeight = FontWeight.w400,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) => AppText(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    style: TextStyle(
      fontSize: AppDimensions.fontSizeBodyMedium,
      fontWeight: fontWeight,
      color: color,
    ),
  );

  factory AppText.bodySmall(
    String text, {
    Color color = AppColors.textHint,
    FontWeight fontWeight = FontWeight.w400,
    TextAlign? textAlign,
  }) => AppText(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: AppDimensions.fontSizeBodySmall,
      fontWeight: fontWeight,
      color: color,
    ),
  );

  factory AppText.bodyXSmall(
    String text, {
    Color color = AppColors.textHint,
    FontWeight fontWeight = FontWeight.w400,
    TextAlign? textAlign,
  }) => AppText(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: AppDimensions.fontSizeBodyXSmall,
      fontWeight: fontWeight,
      color: color,
    ),
  );

  // ============================================================
  // LABEL — buttons, chips, small tags
  // ============================================================
  factory AppText.labelLarge(
    String text, {
    Color color = AppColors.textPrimary,
    TextAlign? textAlign,
  }) => AppText(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: AppDimensions.fontSizeLabelLarge,
      fontWeight: FontWeight.w700,
      color: color,
    ),
  );

  factory AppText.labelSmall(
    String text, {
    Color color = AppColors.textHint,
    TextAlign? textAlign,
  }) => AppText(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: AppDimensions.fontSizeLabelSmall,
      fontWeight: FontWeight.w600,
      color: color,
    ),
  );

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
