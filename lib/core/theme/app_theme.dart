import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// The single typography entry point for Bachaoo.
///
/// Widget-level styles should override only the attributes that differ from
/// these defaults. Keeping the family here ensures Material controls, text
/// spans, dialogs, and other framework-owned UI use Sora as well.
class AppTheme {
  AppTheme._();

  static final TextTheme _textTheme = GoogleFonts.soraTextTheme().copyWith(
    displayLarge: GoogleFonts.sora(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      height: 1.1,
      letterSpacing: -0.8,
      color: AppColors.textPrimary,
    ),
    displayMedium: GoogleFonts.sora(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      height: 1.12,
      letterSpacing: -0.6,
      color: AppColors.textPrimary,
    ),
    headlineLarge: GoogleFonts.sora(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      height: 1.18,
      letterSpacing: -0.4,
      color: AppColors.textPrimary,
    ),
    headlineMedium: GoogleFonts.sora(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      height: 1.2,
      letterSpacing: -0.3,
      color: AppColors.textPrimary,
    ),
    headlineSmall: GoogleFonts.sora(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      height: 1.25,
      color: AppColors.textPrimary,
    ),
    titleLarge: GoogleFonts.sora(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      height: 1.25,
      color: AppColors.textPrimary,
    ),
    titleMedium: GoogleFonts.sora(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.3,
      color: AppColors.textPrimary,
    ),
    titleSmall: GoogleFonts.sora(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.3,
      color: AppColors.textPrimary,
    ),
    bodyLarge: GoogleFonts.sora(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.45,
      color: AppColors.textPrimary,
    ),
    bodyMedium: GoogleFonts.sora(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.4,
      color: AppColors.textSecondary,
    ),
    bodySmall: GoogleFonts.sora(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.35,
      color: AppColors.textHint,
    ),
    labelLarge: GoogleFonts.sora(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.2,
      color: AppColors.textPrimary,
    ),
    labelMedium: GoogleFonts.sora(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.2,
      color: AppColors.textPrimary,
    ),
    labelSmall: GoogleFonts.sora(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      height: 1.2,
      color: AppColors.textHint,
    ),
  );

  static ThemeData get light {
    final buttonText = _textTheme.labelLarge!;
    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.sora().fontFamily,
      textTheme: _textTheme,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.appBackroundColor,
      appBarTheme: AppBarTheme(
        titleTextStyle: _textTheme.titleLarge,
        foregroundColor: AppColors.textPrimary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(textStyle: WidgetStatePropertyAll(buttonText)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(textStyle: WidgetStatePropertyAll(buttonText)),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(textStyle: WidgetStatePropertyAll(buttonText)),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(textStyle: WidgetStatePropertyAll(buttonText)),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        extendedTextStyle: _textTheme.labelLarge,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: _textTheme.labelMedium,
        hintStyle: _textTheme.bodyMedium!.copyWith(color: AppColors.inputHint),
        helperStyle: _textTheme.bodySmall,
        errorStyle: _textTheme.bodySmall!.copyWith(
          color: AppColors.error,
          fontWeight: FontWeight.w500,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedLabelStyle: _textTheme.labelSmall!.copyWith(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: _textTheme.labelSmall,
      ),
      navigationBarTheme: NavigationBarThemeData(
        labelTextStyle: WidgetStatePropertyAll(_textTheme.labelSmall),
      ),
      chipTheme: ChipThemeData(
        labelStyle: _textTheme.labelMedium,
        secondaryLabelStyle: _textTheme.labelMedium,
      ),
      listTileTheme: ListTileThemeData(
        titleTextStyle: _textTheme.titleSmall,
        subtitleTextStyle: _textTheme.bodySmall,
      ),
      dialogTheme: DialogThemeData(
        titleTextStyle: _textTheme.titleLarge,
        contentTextStyle: _textTheme.bodyMedium,
      ),
      snackBarTheme: SnackBarThemeData(contentTextStyle: _textTheme.bodyMedium),
      tooltipTheme: TooltipThemeData(textStyle: _textTheme.bodySmall),
    );
  }
}
