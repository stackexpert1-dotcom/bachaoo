import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/vouchers/views/models/voucher_model.dart';
import 'package:bachaoo/features/vouchers/views/widgets/voucher_provider_card.dart';
import 'package:bachaoo/routes/bachaoo_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Voucher provider discovery. API integration should return
/// [VoucherProviderModel] records from GET /voucher-providers.
class VouchersScreen extends StatelessWidget {
  const VouchersScreen({super.key});

  static const List<VoucherProviderModel> _providers = [
    VoucherProviderModel(
      businessId: 'mcdonalds-sargodha',
      businessName: "McDonald's",
      imageUrl: 'https://www.narcity.com/media-library/the-exterior-of-a-mcdonald-s.jpg?coordinates=0%2C353%2C0%2C0&height=600&id=51173894&width=1200',
      category: 'Fast food',
      description: 'Member rewards on value meals and favourites',
      activeVoucherCount: 2,
      startingPoints: 500,
    ),
    VoucherProviderModel(
      businessId: 'kfc-club-road',
      businessName: 'KFC',
      imageUrl: 'https://www.retail4growth.com/public/uploads/editor/2021-03-31/1617167390.jpg',
      category: 'Fried chicken',
      description: 'Exclusive bucket and meal rewards',
      activeVoucherCount: 2,
      startingPoints: 750,
    ),
    VoucherProviderModel(
      businessId: 'sapphire-university-road',
      businessName: 'Sapphire',
      imageUrl: 'https://cdn.shopify.com/s/files/1/1592/0041/files/1_2bb9308c-2663-4910-93b0-7bcf7ba61fd2.jpg?v=1701169889',
      category: 'Fashion',
      description: 'Member-only savings on selected collections',
      activeVoucherCount: 1,
      startingPoints: 1000,
    ),
    VoucherProviderModel(
      businessId: 'cinepax-lahore',
      businessName: 'Cinepax',
      imageUrl: 'https://primelandproperties.pk/wp-content/uploads/2025/10/lahore-top-malls-by-prime-land-properties-1024x666.webp',
      category: 'Cinema',
      description: 'Enjoy more screen time for fewer points',
      activeVoucherCount: 1,
      startingPoints: 600,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackroundColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppDimensions.pagePadding,
            AppDimensions.paddingMedium,
            AppDimensions.pagePadding,
            AppDimensions.paddingXXLarge,
          ),
          children: [
            Row(
              children: [
                CustomBackButton(),
                const SizedBox(width: AppDimensions.spacingSmall),
                AppText.headlineLarge('Voucher providers'),
              ],
            ),
            // AppDimensions.verticalSpace16,
            // const Text(
            //   'Choose a business to explore the vouchers you can redeem.',
            //   style: TextStyle(
            //     color: AppColors.textSecondary,
            //     fontSize: AppDimensions.fontSizeBodyMedium,
            //     height: AppDimensions.lineHeightNormal,
            //   ),
            // ),
            AppDimensions.verticalSpace48,
            for (final provider in _providers) ...[
              VoucherProviderCard(
                provider: provider,
                onTap: () => Get.toNamed(
                  AppRoutes.providerVouchersScreen,
                  arguments: provider,
                ),
              ),
              AppDimensions.verticalSpace16,
            ],
          ],
        ),
      ),
    );
  }
}
