import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/features/catelog/controllers/catelog_controller.dart';
import 'package:bachaoo/features/catelog/views/widgets/catelog_search_filter_bar.dart';
import 'package:bachaoo/features/deals/views/widgets/deal_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/deals/models/deal_model.dart';
import 'package:bachaoo/features/businesses/models/nearby_business_model.dart';
import 'package:bachaoo/routes/bachaoo_routes.dart';

class AllDealsScreen extends StatelessWidget {
  const AllDealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // AllDealsScreen
    final controller = Get.find<CatalogController<DealModel>>(tag: 'all_deals');
    return Scaffold(
      backgroundColor: AppColors.appBackroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.pagePaddingSmall,
                vertical: AppDimensions.spacingSmall,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomBackButton(onTap: Get.back),
                      const SizedBox(width: AppDimensions.spacingSmall),
                      AppText.headlineMedium('All deals'),
                    ],
                  ),
                  AppDimensions.verticalSpace16,
                  CatalogSearchFilterBar<DealModel>(
                    controller: controller,
                    searchHint: 'Search deals',
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                final items = controller.filteredItems;
                if (items.isEmpty) {
                  return Center(
                    child: AppText.bodyLarge(
                      'No deals match your filters.',
                      color: AppColors.textSecondary,
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(
                    AppDimensions.pagePaddingSmall,
                    0,
                    AppDimensions.pagePaddingSmall,
                    AppDimensions.spacingMedium,
                  ),
                  itemCount: items.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppDimensions.spacingMedium),
                  itemBuilder: (context, index) {
                    final deal = items[index];
                    return DealCard.fromDeal(
                      deal,
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.discountExploreScreen,
                          arguments: BusinessModel.fromDeal(deal),
                        );
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // List<DealModel> _fetchDeals() {
  //   return [
  //     DealModel(
  //       id: 'd1',
  //       imageUrl: 'https://picsum.photos/seed/kfc-deal/400/400',
  //       badgeLabel: '1+1 FREE',
  //       brandTag: 'KFC',
  //       brandColor: const Color(0xFFC8102E),
  //       title: 'Zinger Burger Deal 1x1',
  //       subtitle: 'KFC Satellite Town',
  //       currentPrice: '899',
  //       originalPrice: '1,798',
  //       category: 'Food',
  //       rating: 4.6,
  //       createdAt: DateTime(2026, 9, 12),
  //       popularityScore: 980,
  //     ),
  //     DealModel(
  //       id: 'd2',
  //       imageUrl: 'https://picsum.photos/seed/nawaab-deal/400/400',
  //       badgeLabel: 'Family Deal',
  //       brandTag: 'NRR',
  //       brandColor: const Color(0xFF8A6A2F),
  //       title: 'BBQ Platter for 4',
  //       subtitle: 'Nawaab Royal Restaurant',
  //       currentPrice: '2,499',
  //       originalPrice: '3,200',
  //       category: 'Food',
  //       rating: 4.2,
  //       createdAt: DateTime(2026, 9, 9),
  //       popularityScore: 640,
  //     ),
  //     DealModel(
  //       id: 'd3',
  //       imageUrl: 'https://picsum.photos/seed/metro-deal/400/400',
  //       badgeLabel: 'Weekly Deal',
  //       brandTag: 'MET',
  //       brandColor: const Color(0xFF0057A3),
  //       title: 'Grocery Bundle — Rice, Oil & Pulses',
  //       subtitle: 'Metro Cash & Carry',
  //       currentPrice: '3,150',
  //       originalPrice: '3,900',
  //       category: 'Super Market',
  //       rating: 4.0,
  //       createdAt: DateTime(2026, 9, 5),
  //       popularityScore: 410,
  //     ),
  //     DealModel(
  //       id: 'd4',
  //       imageUrl: 'https://picsum.photos/seed/glow-deal/400/400',
  //       badgeLabel: 'Spa Combo',
  //       brandTag: 'GLW',
  //       brandColor: const Color(0xFFD46A9F),
  //       title: 'Facial + Hair Spa Combo',
  //       subtitle: 'Glow Beauty Salon',
  //       currentPrice: '3,000',
  //       originalPrice: '5,500',
  //       category: 'Beauty & Care',
  //       rating: 4.8,
  //       createdAt: DateTime(2026, 9, 14),
  //       popularityScore: 1120,
  //     ),
  //     DealModel(
  //       id: 'd5',
  //       imageUrl: 'https://picsum.photos/seed/brainy-deal/400/400',
  //       badgeLabel: 'Enroll Now',
  //       brandTag: 'BRN',
  //       brandColor: const Color(0xFF2E7D32),
  //       title: 'IELTS Prep Course — 6 Weeks',
  //       subtitle: 'Brainwave Academy',
  //       currentPrice: '8,000',
  //       originalPrice: '12,000',
  //       category: 'Education',
  //       rating: 4.3,
  //       createdAt: DateTime(2026, 8, 30),
  //       popularityScore: 260,
  //     ),
  //     DealModel(
  //       id: 'd6',
  //       imageUrl: 'https://picsum.photos/seed/cinema-deal/400/400',
  //       badgeLabel: 'Couple Pass',
  //       brandTag: 'CNP',
  //       brandColor: const Color(0xFF6A1B9A),
  //       title: '2 Movie Tickets + Popcorn Combo',
  //       subtitle: 'Cinepax Sargodha',
  //       currentPrice: '1,200',
  //       originalPrice: '1,800',
  //       category: 'Entertainment',
  //       rating: 4.5,
  //       createdAt: DateTime(2026, 9, 15),
  //       popularityScore: 875,
  //     ),
  //     DealModel(
  //       id: 'd7',
  //       imageUrl: 'https://picsum.photos/seed/carwash-deal/400/400',
  //       badgeLabel: 'Full Package',
  //       brandTag: 'SFM',
  //       brandColor: const Color(0xFF37474F),
  //       title: 'Full Car Wash + Wax Package',
  //       subtitle: 'Suzuki Falcon Motors',
  //       currentPrice: '1,500',
  //       originalPrice: '2,200',
  //       category: 'Auto Mobiles',
  //       rating: 3.9,
  //       createdAt: DateTime(2026, 8, 19),
  //       popularityScore: 180,
  //     ),
  //     DealModel(
  //       id: 'd8',
  //       imageUrl: 'https://picsum.photos/seed/dentist-deal/400/400',
  //       badgeLabel: 'First Visit',
  //       brandTag: 'SDC',
  //       brandColor: const Color(0xFF00897B),
  //       title: 'Dental Checkup + Scaling',
  //       subtitle: 'Smile Dental Clinic',
  //       currentPrice: '1,800',
  //       originalPrice: '3,000',
  //       category: 'Health',
  //       rating: 4.7,
  //       createdAt: DateTime(2026, 9, 10),
  //       popularityScore: 590,
  //     ),
  //     DealModel(
  //       id: 'd9',
  //       imageUrl: 'https://picsum.photos/seed/threads-deal/400/400',
  //       badgeLabel: 'Season Sale',
  //       brandTag: 'TRD',
  //       brandColor: const Color(0xFF4E342E),
  //       title: 'Unstitched 3-Piece Lawn Suit',
  //       subtitle: 'Threads & Co.',
  //       currentPrice: '2,100',
  //       originalPrice: '3,500',
  //       category: 'Fashion',
  //       rating: 4.1,
  //       createdAt: DateTime(2026, 9, 1),
  //       popularityScore: 330,
  //     ),
  //     DealModel(
  //       id: 'd10',
  //       imageUrl: 'https://picsum.photos/seed/laundry-deal/400/400',
  //       badgeLabel: 'Bulk Discount',
  //       brandTag: 'QCL',
  //       brandColor: const Color(0xFF1565C0),
  //       title: 'Dry Clean 10 Items Bundle',
  //       subtitle: 'QuickClean Laundry Services',
  //       currentPrice: '1,000',
  //       originalPrice: '1,500',
  //       category: 'Services',
  //       rating: 3.7,
  //       createdAt: DateTime(2026, 8, 22),
  //       popularityScore: 95,
  //     ),
  //   ];
  // }
}
