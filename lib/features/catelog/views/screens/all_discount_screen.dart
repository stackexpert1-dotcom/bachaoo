import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/features/catelog/controllers/catelog_controller.dart';
import 'package:bachaoo/features/catelog/views/widgets/catelog_search_filter_bar.dart';
import 'package:bachaoo/features/businesses/models/nearby_business_model.dart';
import 'package:bachaoo/features/deals/views/widgets/deal_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/discounts/models/discount_model.dart';
import 'package:bachaoo/routes/bachaoo_routes.dart';

class AllDiscountsScreen extends StatelessWidget {
  const AllDiscountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // AllDiscountsScreen
    final controller = Get.find<CatalogController<DiscountModel>>(
      tag: 'all_discounts',
    );
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
                      AppText.headlineMedium('All discounts'),
                    ],
                  ),
                  AppDimensions.verticalSpace16,
                  CatalogSearchFilterBar<DiscountModel>(
                    controller: controller,
                    searchHint: 'Search discounts',
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
                      'No discounts match your filters.',
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
                    final discount = items[index];
                    return DealCard.fromBusiness(
                      BusinessModel.fromDiscount(discount),
                      onTap: () => Get.toNamed(
                        AppRoutes.discountExploreScreen,
                        arguments: BusinessModel.fromDiscount(discount),
                      ),
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

  // List<DiscountModel> _fetchDiscounts() {
  //   return [
  //     DiscountModel(
  //       imageUrl: 'https://picsum.photos/seed/dhuaan-disc/400/400',
  //       discountLabel: '15% off',
  //       title: 'Dhuaan N Dhukan',
  //       subtitle: 'Zafarullah Chowk, Old Satellite Town',
  //       description: 'Get 15% off your entire bill on dine-in orders.',
  //       tags: const ['Dine-in', 'Cash & card', 'Cap Rs 1,500'],
  //       category: 'Food',
  //       rating: 5.0,
  //       createdAt: DateTime(2026, 9, 13),
  //       popularityScore: 1400,
  //     ),
  //     DiscountModel(
  //       imageUrl: 'https://picsum.photos/seed/chobara-disc/400/400',
  //       discountLabel: '12% off',
  //       title: 'Chobara Restaurant',
  //       subtitle: 'Queen Road, Sargodha',
  //       description: 'Enjoy 12% off on all food items, dine-in only.',
  //       tags: const ['Dine-in', 'Cash only'],
  //       category: 'Food',
  //       rating: 4.4,
  //       createdAt: DateTime(2026, 9, 4),
  //       popularityScore: 720,
  //     ),
  //     DiscountModel(
  //       imageUrl: 'https://picsum.photos/seed/almart-disc/400/400',
  //       discountLabel: '8% off',
  //       title: 'Al-Barkat Super Store',
  //       subtitle: 'Club Road, Sargodha',
  //       description: 'Flat 8% off on groceries above Rs 2,000.',
  //       tags: const ['In-store', 'Cash & card'],
  //       category: 'Super Market',
  //       rating: 3.8,
  //       createdAt: DateTime(2026, 8, 28),
  //       popularityScore: 150,
  //     ),
  //     DiscountModel(
  //       imageUrl: 'https://picsum.photos/seed/glamour-disc/400/400',
  //       discountLabel: '20% off',
  //       title: 'Glamour Beauty Lounge',
  //       subtitle: 'DHA Phase 2, Sargodha',
  //       description: '20% off on all salon services this month.',
  //       tags: const ['Appointment required'],
  //       category: 'Beauty & Care',
  //       rating: 4.9,
  //       createdAt: DateTime(2026, 9, 16),
  //       popularityScore: 1650,
  //     ),
  //     DiscountModel(
  //       imageUrl: 'https://picsum.photos/seed/skillup-disc/400/400',
  //       discountLabel: '25% off',
  //       title: 'SkillUp Learning Center',
  //       subtitle: 'University Road, Sargodha',
  //       description: '25% off on all short courses enrolled this quarter.',
  //       tags: const ['New students only'],
  //       category: 'Education',
  //       rating: 4.0,
  //       createdAt: DateTime(2026, 8, 25),
  //       popularityScore: 210,
  //     ),
  //     DiscountModel(
  //       imageUrl: 'https://picsum.photos/seed/funzone-disc/400/400',
  //       discountLabel: '10% off',
  //       title: 'FunZone Arcade & Bowling',
  //       subtitle: 'Railway Road, Sargodha',
  //       description: '10% off on game tokens and bowling lanes.',
  //       tags: const ['Weekdays only'],
  //       category: 'Entertainment',
  //       rating: 4.3,
  //       createdAt: DateTime(2026, 9, 8),
  //       popularityScore: 480,
  //     ),
  //     DiscountModel(
  //       imageUrl: 'https://picsum.photos/seed/falcon-disc/400/400',
  //       discountLabel: '20% labour',
  //       title: 'Suzuki Falcon Motors',
  //       subtitle: 'Motorway Road, Sargodha',
  //       description: '20% off labour charges on all servicing.',
  //       tags: const ['Service only', 'No parts'],
  //       category: 'Auto Mobiles',
  //       rating: 3.9,
  //       createdAt: DateTime(2026, 8, 19),
  //       popularityScore: 190,
  //     ),
  //     DiscountModel(
  //       imageUrl: 'https://picsum.photos/seed/careplus-disc/400/400',
  //       discountLabel: '15% off',
  //       title: 'CarePlus Pharmacy & Clinic',
  //       subtitle: 'Farooq-e-Azam Road, Sargodha',
  //       description: '15% off on consultation fee and OTC medicines.',
  //       tags: const ['Walk-in', 'Cash & card'],
  //       category: 'Health',
  //       rating: 4.6,
  //       createdAt: DateTime(2026, 9, 11),
  //       popularityScore: 610,
  //     ),
  //     DiscountModel(
  //       imageUrl: 'https://picsum.photos/seed/stitchhub-disc/400/400',
  //       discountLabel: '30% off',
  //       title: 'StitchHub Fashion House',
  //       subtitle: 'Bhalwal Road, Sargodha',
  //       description: '30% off on ready-to-wear collection, this week only.',
  //       tags: const ['In-store only', 'Limited stock'],
  //       category: 'Fashion',
  //       rating: 4.2,
  //       createdAt: DateTime(2026, 9, 2),
  //       popularityScore: 340,
  //     ),
  //     DiscountModel(
  //       imageUrl: 'https://picsum.photos/seed/swiftfix-disc/400/400',
  //       discountLabel: '10% off',
  //       title: 'SwiftFix Home Services',
  //       subtitle: 'Available across Sargodha',
  //       description: '10% off on electrical and plumbing call-outs.',
  //       tags: const ['Book via app', 'Cash on completion'],
  //       category: 'Services',
  //       rating: 3.6,
  //       createdAt: DateTime(2026, 8, 21),
  //       popularityScore: 88,
  //     ),
  //   ];
  // }
}
