import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/chat/models/conversational_model.dart';
import 'package:flutter/material.dart';

class ConversationTile extends StatelessWidget {
  final ConversationModel conversation;
  final VoidCallback onTap;

  const ConversationTile({
    super.key,
    required this.conversation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
          vertical: AppDimensions.paddingMedium,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              child: conversation.avatarUrl != null
                  ? Image.network(
                      conversation.avatarUrl!,
                      width: AppDimensions.avatarLarge,
                      height: AppDimensions.avatarLarge,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _InitialsAvatar(
                        initials: conversation.avatarInitials ?? '?',
                      ),
                    )
                  : _InitialsAvatar(
                      initials: conversation.avatarInitials ?? '?',
                    ),
            ),
            const SizedBox(width: AppDimensions.spacingMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (conversation.hasUnread) ...[
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.secondaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: AppDimensions.spacingXSmall),
                      ],
                      Expanded(
                        child: Text(
                          conversation.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w800,
                            fontSize: AppDimensions.fontSizeTitleSmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    conversation.lastMessage,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: AppDimensions.fontSizeBodyMedium,
                      height: AppDimensions.lineHeightNormal,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppDimensions.spacingSmall),
            Text(
              conversation.timeLabel,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: AppDimensions.fontSizeBodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InitialsAvatar extends StatelessWidget {
  final String initials;

  const _InitialsAvatar({required this.initials});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.avatarLarge,
      height: AppDimensions.avatarLarge,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      child: Text(
        initials,
        style: const TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.w800,
          fontSize: AppDimensions.fontSizeTitleSmall,
        ),
      ),
    );
  }
}
