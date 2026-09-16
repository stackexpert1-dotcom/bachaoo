import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:flutter/material.dart';

class HowItWorksCard extends StatelessWidget {
  final String title;
  final List<String> steps;

  const HowItWorksCard({
    super.key,
    required this.steps,
    this.title = 'How it works',
  });

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primaryColor;

    if (steps.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade200),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              for (int i = 0; i < steps.length; i++) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${i + 1}',
                          style: TextStyle(
                            color: primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          steps[i],
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 15,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (i != steps.length - 1)
                  Divider(height: 1, color: Colors.grey.shade200),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
