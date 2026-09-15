import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String timeLabel;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isMe,
    required this.timeLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: AppDimensions.spacingXXSmall,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
          vertical: AppDimensions.paddingSmall,
        ),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primaryColor : AppColors.surfaceColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(AppDimensions.radiusSmall),
            topRight: const Radius.circular(AppDimensions.radiusSmall),
            bottomLeft: Radius.circular(
              isMe ? AppDimensions.radiusSmall : AppDimensions.radiusXXXSmall,
            ),
            bottomRight: Radius.circular(
              isMe ? AppDimensions.radiusXXXSmall : AppDimensions.radiusSmall,
            ),
          ),
          border: isMe ? null : Border.all(color: AppColors.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                color: isMe ? AppColors.white : AppColors.textPrimary,
                fontSize: AppDimensions.fontSizeBodyLarge,
                height: AppDimensions.lineHeightNormal,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              timeLabel,
              style: TextStyle(
                color: isMe
                    ? AppColors.white.withValues(alpha: 0.7)
                    : AppColors.textMuted,
                fontSize: AppDimensions.fontSizeBodyXSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
