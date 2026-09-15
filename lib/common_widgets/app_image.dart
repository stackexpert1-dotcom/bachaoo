import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:flutter/material.dart';

/// Renders an image from either a bundled asset (paths under `assets/`
/// declared in pubspec.yaml) or the network.
///
/// Network images show a spinner while loading and a fallback icon on error,
/// so a slow or unavailable URL never renders as an empty gray box.
class AppImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final ImageErrorWidgetBuilder? errorBuilder;

  const AppImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return imagePath.startsWith('assets/')
        ? Image.asset(
            imagePath,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: errorBuilder ?? _defaultErrorBuilder,
          )
        : Image.network(
            imagePath,
            width: width,
            height: height,
            fit: fit,
            loadingBuilder: _defaultLoadingBuilder,
            errorBuilder: errorBuilder ?? _defaultErrorBuilder,
          );
  }

  /// Default loading state: a small spinner on the muted background.
  static Widget _defaultLoadingBuilder(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) {
    if (loadingProgress == null) return child;
    return Container(
      color: AppColors.disabledBackground,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        strokeWidth: 2,
        color: AppColors.primaryColor,
      ),
    );
  }

  /// Default error state: a muted image icon instead of a blank box.
  static Widget _defaultErrorBuilder(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return Container(
      color: AppColors.disabledBackground,
      alignment: Alignment.center,
      child: const Icon(
        Icons.image_not_supported_outlined,
        color: AppColors.iconMuted,
        size: 32,
      ),
    );
  }
}