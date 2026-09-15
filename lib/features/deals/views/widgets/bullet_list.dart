import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class BulletList extends StatelessWidget {
  final List<String> items;

  const BulletList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppDimensions.spacingSmall),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Text('•  '),
              ),
              Expanded(child: AppText.bodyLarge(item)),
            ],
          ),
        );
      }).toList(),
    );
  }
}
