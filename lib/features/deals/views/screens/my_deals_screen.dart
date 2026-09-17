import 'package:bachaoo/features/deals/controllers.dart/deals_controllers.dart';
import 'package:bachaoo/features/deals/views/widgets/my_deals/active_deal_card.dart';
import 'package:bachaoo/features/deals/views/widgets/my_deals/deals_empty_state.dart';
import 'package:bachaoo/features/deals/views/widgets/my_deals/deals_tab_switch.dart';
import 'package:bachaoo/features/deals/views/widgets/my_deals/history_deal_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class DealsScreen extends StatelessWidget {
  const DealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DealsController>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.pagePaddingSmall,
                AppDimensions.spacingSmall,
                AppDimensions.pagePaddingSmall,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: Get.back,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusMedium,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.chevron_left_rounded,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppDimensions.spacingSmall),
                      AppText.headlineMedium('My deals'),
                    ],
                  ),
                  AppDimensions.verticalSpace16,
                  Obx(
                    () => DealsTabSwitch(
                      selectedIndex: controller.selectedTab.value,
                      activeCount: controller.activeDeals.length,
                      historyCount: controller.historyDeals.length,
                      onChanged: controller.selectTab,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                final isActiveTab = controller.selectedTab.value == 0;
                final hasActive = controller.activeDeals.isNotEmpty;
                final hasHistory = controller.historyDeals.isNotEmpty;

                // Nothing at all yet — the big empty-state graphic.
                if (!hasActive && !hasHistory) {
                  return SingleChildScrollView(
                    child: DealsEmptyState(
                      memberName:
                          'Shafqat Ullah', // TODO: pull from the profile
                      title: "Your card hasn't saved you anything yet",
                      subtitle:
                          'Pick a deal near you, show your card at billing, '
                          'and the saving shows up here.',
                      buttonLabel: 'Browse deals near me',
                      onButtonTap: controller.onBrowseDeals,
                    ),
                  );
                }

                if (isActiveTab) {
                  // Active tab: active deal card up top (if any),
                  // followed by the full activity history feed.
                  return ListView(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimensions.pagePaddingSmall,
                      AppDimensions.spacingMedium,
                      AppDimensions.pagePaddingSmall,
                      AppDimensions.spacingMedium,
                    ),
                    children: [
                      for (final deal in controller.activeDeals) ...[
                        ActiveDealCard(
                          deal: deal,
                          onEnterCodeTap: () =>
                              controller.onEnterBusinessCode(deal),
                        ),
                        AppDimensions.verticalSpace16,
                      ],
                      if (hasHistory)
                        for (final entry
                            in controller.groupedHistory.entries) ...[
                          HistoryMonthSection(
                            monthLabel: entry.key,
                            deals: entry.value,
                          ),
                          AppDimensions.verticalSpace20,
                        ],
                    ],
                  );
                }

                // History tab: history feed only.
                if (!hasHistory) {
                  return SingleChildScrollView(
                    child: DealsEmptyState(
                      memberName: 'Shafqat Ullah',
                      title: 'No redeemed deals yet',
                      subtitle: 'Deals you redeem will show up here once you use them.',
                      buttonLabel: 'Browse deals near me',
                      onButtonTap: controller.onBrowseDeals,
                    ),
                  );
                }

                return ListView(
                  padding: const EdgeInsets.fromLTRB(
                    AppDimensions.pagePaddingSmall,
                    AppDimensions.spacingMedium,
                    AppDimensions.pagePaddingSmall,
                    AppDimensions.spacingMedium,
                  ),
                  children: [
                    for (final entry in controller.groupedHistory.entries) ...[
                      HistoryMonthSection(
                        monthLabel: entry.key,
                        deals: entry.value,
                      ),
                      AppDimensions.verticalSpace20,
                    ],
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
