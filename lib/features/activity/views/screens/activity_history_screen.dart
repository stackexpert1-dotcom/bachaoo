import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/features/activity/views/widgets/activity_list_tile.dart';
import 'package:bachaoo/features/virtual_card/controllers/card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Full activity history — every card/points/referral event, not just the
/// short preview shown on the card screen.
class ActivityHistoryScreen extends StatelessWidget {
  const ActivityHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CardController>();

    return Scaffold(
      backgroundColor: AppColors.appBackroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBackroundColor,
        elevation: 0,
        title: AppText.appBarTitle('All Activity'),
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(width: 40, height: 40, child: CustomBackButton()),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: controller.loadActivity,
        child: Obx(() {
          if (controller.isLoadingActivity.value &&
              controller.activities.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.activities.isEmpty) {
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 100),
                  child: Center(
                    child: Text(
                      'No activity yet',
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  ),
                ),
              ],
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.activities.length,
                separatorBuilder: (_, _) =>
                    Divider(height: 1, color: Colors.grey.shade200),
                itemBuilder: (context, index) =>
                    ActivityListTile(item: controller.activities[index]),
              ),
            ),
          );
        }),
      ),
    );
  }
}
