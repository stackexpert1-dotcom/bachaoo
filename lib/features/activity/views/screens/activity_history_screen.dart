import 'package:bachaoo/features/activity/views/widgets/activity_list_tile.dart';
import 'package:bachaoo/features/virtual_card/controllers/card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityHistoryScreen extends StatelessWidget {
  const ActivityHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CardController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Recent activity',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
          return ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: controller.activities.length,
            separatorBuilder: (_, __) =>
                Divider(height: 1, color: Colors.grey.shade200),
            itemBuilder: (context, index) =>
                ActivityListTile(item: controller.activities[index]),
          );
        }),
      ),
    );
  }
}
