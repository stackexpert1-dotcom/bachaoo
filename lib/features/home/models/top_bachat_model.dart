import 'package:flutter/material.dart';

/// A single brand tile for the "Top Bachats" marquee on the home screen.
class TopBachatModel {
  /// Online logo image URL of the brand (e.g. favicon service).
  final String imageUrl;

  /// Brand color rendered as the tile background behind the logo.
  final Color brandColor;

  const TopBachatModel({
    required this.imageUrl,
    required this.brandColor,
  });
}