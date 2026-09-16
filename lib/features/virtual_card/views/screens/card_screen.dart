import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/features/activity/views/widgets/activity_list_tile.dart';
import 'package:bachaoo/features/virtual_card/controllers/card_controller.dart';
import 'package:bachaoo/features/virtual_card/views/widgets/member_card_widget.dart';
import 'package:bachaoo/features/virtual_card/views/widgets/points_progress_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemberCardScreen extends StatelessWidget {
  const MemberCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CardController>();
    return Scaffold(
      backgroundColor: AppColors.appBackroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBackroundColor,
        elevation: 0,
        title: AppText.appBarTitle('Your Card'),
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(width: 40, height: 40, child: CustomBackButton()),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: controller.refreshAll,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          child: Obx(() {
            if (controller.isLoadingCard.value &&
                controller.card.value == null) {
              return const _CardSkeletonLoader();
            }

            if (controller.errorMessage.value.isNotEmpty) {
              return _ErrorState(
                message: controller.errorMessage.value,
                onRetry: controller.loadCard,
              );
            }

            final card = controller.card.value!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MemberCardWidget(card: card),
                const SizedBox(height: 16),
                _ActionButtonsRow(controller: controller),
                const SizedBox(height: 16),
                PointsProgressCard(card: card),
                const SizedBox(height: 24),
                _RecentActivitySection(controller: controller),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _ActionButtonsRow extends StatelessWidget {
  final CardController controller;
  const _ActionButtonsRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _actionButton(
            icon: Icons.qr_code_scanner,
            label: 'Scan partner QR',
            onTap: controller.goToScanPartner,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _actionButton(
            icon: Icons.account_balance_wallet_outlined,
            label: 'Add to wallet',
            onTap: controller.addToWallet,
          ),
        ),
      ],
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return OutlinedButton.icon(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        side: BorderSide(color: Colors.grey.shade300),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      icon: Icon(icon, size: 18),
      label: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w600),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _RecentActivitySection extends StatelessWidget {
  final CardController controller;
  const _RecentActivitySection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText.titleLarge('Recent activity'),
            TextButton(
              onPressed: controller.goToFullActivity,
              child: const Text(
                'All',
                style: TextStyle(
                  color: Color(0xFF1E5631),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Obx(() {
            if (controller.isLoadingActivity.value) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final items = controller.previewActivities;
            if (items.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Center(
                  child: Text(
                    'No activity yet',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ),
              );
            }
            return Column(
              children: [
                for (int i = 0; i < items.length; i++) ...[
                  ActivityListTile(item: items[i]),
                  if (i != items.length - 1)
                    Divider(height: 1, color: Colors.grey.shade200),
                ],
              ],
            );
          }),
        ),
      ],
    );
  }
}

class _CardSkeletonLoader extends StatelessWidget {
  const _CardSkeletonLoader();

  @override
  Widget build(BuildContext context) {
    Widget block(double height, {double? width}) => Container(
      width: width,
      height: height,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(16),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [block(220), block(52), block(180), block(140)],
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Column(
        children: [
          Icon(Icons.error_outline, color: Colors.grey.shade400, size: 40),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 16),
          OutlinedButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
