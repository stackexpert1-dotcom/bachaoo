import 'package:flutter/material.dart';

/// Describes one entry in the share-options row. The row is built by
/// iterating a `List<ShareChannelModel>` from the controller, so adding or
/// removing a channel (WhatsApp, SMS, email...) never touches the widget.
class ShareChannelModel {
  final String id;
  final String label; // shown next to the icon; empty for an icon-only button
  final IconData? icon; // Material icon (e.g. SMS / share)
  final Widget? faIcon; // Font Awesome icon (e.g. real WhatsApp brand glyph)
  final Color? accentColor; // null = use the theme's default text color

  const ShareChannelModel({
    required this.id,
    required this.label,
    this.icon,
    this.faIcon,
    this.accentColor,
  });

  bool get isIconOnly => label.isEmpty;
}
