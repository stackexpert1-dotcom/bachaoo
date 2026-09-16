import 'package:bachaoo/features/activity/models/activity_item_model.dart';
import 'package:flutter/material.dart';

class ActivityListTile extends StatelessWidget {
  final ActivityItemModel item;

  const ActivityListTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          _buildLeading(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.subtitle,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                ),
              ],
            ),
          ),
          Text(
            item.amountLabel,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: item.isPositive
                  ? const Color(0xFFB9770E)
                  : const Color(0xFF1E5631),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeading() {
    if (item.imageUrl != null && item.imageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          item.imageUrl!,
          width: 48,
          height: 48,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _iconFallback(),
        ),
      );
    }
    return _iconFallback();
  }

  Widget _iconFallback() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: item.type.iconBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(item.type.icon, color: item.type.iconColor, size: 22),
    );
  }
}
