import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/common_widgets/promo_state_card.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/refer_and_earn/controllers/referral_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/how_it_works_card.dart';
import '../widgets/referral_code_box.dart';
import '../widgets/referral_list_tile.dart';

class ReferEarnScreen extends StatelessWidget {
  const ReferEarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReferralController>();

    return Scaffold(
      backgroundColor: AppColors.appBackroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBackroundColor,
        title: AppText.appBarTitle('Refer & earn'),
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
            if (controller.isLoadingSummary.value &&
                controller.summary.value == null) {
              return const _SummarySkeleton();
            }
            if (controller.errorMessage.value.isNotEmpty) {
              return _ErrorState(
                message: controller.errorMessage.value,
                onRetry: controller.loadSummary,
              );
            }

            final summary = controller.summary.value!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // The big "1,000 points" number is only shown because we
                // pass statValue here — omit it (or pass null) elsewhere to
                // get the same card shell without the stat.
                PromoStatCard(
                  watermarkIcon: Icons.card_giftcard,
                  eyebrowText: 'Each friend who joins earns you',
                  statValue: controller.formatNumber(summary.pointsPerReferral),
                  statLabel: 'points',
                  descriptionText:
                      'Reach ${controller.formatNumber(summary.pointsTarget)} points to unlock ${summary.nextTierLabel} and premium vouchers.',
                ),
                const SizedBox(height: 24),
                ReferralCodeBox(
                  code: summary.referralCode,
                  onCopy: controller.copyCode,
                  channels: controller.shareChannels,
                  onChannelTap: (channel) => controller.shareVia(channel.id),
                ),
                const SizedBox(height: 24),
                HowItWorksCard(steps: controller.howItWorksSteps),
                const SizedBox(height: 24),
                _ReferralsSection(controller: controller),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _ReferralsSection extends StatelessWidget {
  final ReferralController controller;
  const _ReferralsSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText.titleLarge('Your referrals'),
            Obx(
              () => Text(
                '${controller.joinedCount} joined',
                style: appFont(
                  color: Colors.grey.shade500,
                  fontSize: AppDimensions.fontSizeBodySmall,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Obx(() {
            if (controller.isLoadingReferrals.value) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final items = controller.referrals;
            if (items.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Center(
                  child: Text(
                    'No referrals yet',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ),
              );
            }
            return Column(
              children: [
                for (int i = 0; i < items.length; i++) ...[
                  ReferralListTile(referral: items[i]),
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

class _SummarySkeleton extends StatelessWidget {
  const _SummarySkeleton();

  @override
  Widget build(BuildContext context) {
    Widget block(double height) => Container(
      height: height,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(16),
      ),
    );

    return Column(children: [block(190), block(90), block(160)]);
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
