import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/help_and_support/models/policy_section_model.dart';
import 'package:flutter/material.dart';

class PolicySectionList extends StatelessWidget {
  final String metaLabel;
  final List<PolicySection> sections;

  const PolicySectionList({
    super.key,
    required this.metaLabel,
    required this.sections,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          metaLabel,
          style: const TextStyle(
            color: AppColors.textMuted,
            fontSize: AppDimensions.fontSizeBodyMedium,
          ),
        ),
        const SizedBox(height: AppDimensions.spacingLarge),
        for (int i = 0; i < sections.length; i++) ...[
          Text(
            sections[i].heading,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
              fontSize: AppDimensions.fontSizeTitleSmall,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingXSmall),
          Text(
            sections[i].body,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: AppDimensions.fontSizeBodyLarge,
              height: AppDimensions.lineHeightRelaxed,
            ),
          ),
          if (i != sections.length - 1)
            const SizedBox(height: AppDimensions.spacingLarge),
        ],
      ],
    );
  }
}
