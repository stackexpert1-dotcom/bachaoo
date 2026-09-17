import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/features/vouchers/notifications/controllers/notification_controllers.dart';
import 'package:bachaoo/features/vouchers/notifications/views/widgets/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/common_widgets/filter_chip_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationsController>();

    return Scaffold(
      backgroundColor: AppColors.appBackroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // --- App bar: back button + centered title ---
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.pagePaddingSmall,
                vertical: AppDimensions.spacingSmall,
              ),
              child: Row(
                children: [
                  CustomBackButton(onTap: Get.back),
                  Expanded(
                    child: Center(child: AppText.appBarTitle('Notification')),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),

            // --- Filter chips ---
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.pagePaddingSmall,
              ),
              child: Row(
                children: [
                  for (
                    int i = 0;
                    i < NotificationsController.filters.length;
                    i++
                  ) ...[
                    Obx(
                      () => FilterChipButton(
                        label: NotificationsController.filters[i],
                        isSelected: controller.selectedFilterIndex.value == i,
                        onTap: () => controller.selectFilter(i),
                      ),
                    ),
                    if (i != NotificationsController.filters.length - 1)
                      const SizedBox(width: AppDimensions.spacingSmall),
                  ],
                ],
              ),
            ),
            AppDimensions.verticalSpace16,

            // --- Notification list ---
            Expanded(
              child: Obx(() {
                final items = controller.filteredNotifications;

                if (items.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                      child: AppText.bodyLarge(
                        'No notifications here yet.',
                        color: AppColors.textSecondary,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(
                    bottom: AppDimensions.spacingMedium,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return NotificationCard(notification: items[index]);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
