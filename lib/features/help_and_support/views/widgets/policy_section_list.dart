import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
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
        AppText.bodySmall(metaLabel, color: AppColors.textMuted),
        const SizedBox(height: AppDimensions.spacingLarge),
        for (int i = 0; i < sections.length; i++) ...[
          AppText.titleSmall(sections[i].heading, color: AppColors.textPrimary),
          const SizedBox(height: AppDimensions.spacingXSmall),
          AppText.bodyMedium(sections[i].body, color: AppColors.textSecondary),
          if (i != sections.length - 1)
            const SizedBox(height: AppDimensions.spacingLarge),
        ],
      ],
    );
  }
}
