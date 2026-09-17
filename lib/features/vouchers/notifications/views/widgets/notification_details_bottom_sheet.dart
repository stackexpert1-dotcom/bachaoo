import 'package:bachaoo/features/vouchers/notifications/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_image.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class NotificationDetailsBottomSheet extends StatelessWidget {
  final NotificationModel notification;

  const NotificationDetailsBottomSheet({super.key, required this.notification});

  static Future<void> show(
    BuildContext context, {
    required NotificationModel notification,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          NotificationDetailsBottomSheet(notification: notification),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = notification.imageUrl != null;

    return Container(
      padding: EdgeInsets.only(
        left: AppDimensions.pagePaddingSmall,
        right: AppDimensions.pagePaddingSmall,
        top: AppDimensions.spacingSmall,
        bottom:
            MediaQuery.of(context).padding.bottom +
            AppDimensions.pagePaddingSmall,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.bottomSheetRadius),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Drag handle ---
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(
                bottom: AppDimensions.spacingMedium,
              ),
              decoration: BoxDecoration(
                color: AppColors.disabledBackground,
                borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
              ),
            ),
          ),

          // --- Icon + title + time ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  notification.icon,
                  color: notification.iconColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppDimensions.spacingMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.titleMedium(notification.title),
                    const SizedBox(height: 2),
                    AppText.bodySmall(_fullTimestamp(notification.time)),
                  ],
                ),
              ),
            ],
          ),

          AppDimensions.verticalSpace16,
          // --- Full, untruncated description ---
          AppText.bodyLarge(
            notification.description,
            color: AppColors.textSecondary,
          ),

          AppDimensions.verticalSpace16,
          // const Divider(height: 1, thickness: 1, color: AppColors.divider),
          // AppDimensions.verticalSpace16,

          if (hasImage) ...[
            AppDimensions.verticalSpace16,
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
              child: AspectRatio(
                aspectRatio: 1,
                child: AppImage(
                  imagePath: notification.imageUrl!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(color: AppColors.disabledBackground),
                ),
              ),
            ),
          ],

          AppDimensions.verticalSpace20,
        ],
      ),
    );
  }

  String _fullTimestamp(DateTime time) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final hour12 = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final period = time.hour < 12 ? 'AM' : 'PM';
    final minute = time.minute.toString().padLeft(2, '0');
    return '${time.day} ${months[time.month - 1]} · $hour12:$minute $period';
  }
}
