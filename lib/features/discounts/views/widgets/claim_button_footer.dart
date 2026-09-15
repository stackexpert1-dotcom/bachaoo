import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/primary_button.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class ClaimButtonFooter extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const ClaimButtonFooter({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.pagePaddingSmall,
        vertical: AppDimensions.spacingMedium,
      ),
        child: PrimaryButton(label: label, onTap: onTap),
      ),
    );
  }
}
