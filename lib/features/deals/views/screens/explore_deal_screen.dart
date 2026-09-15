import 'package:bachaoo/features/deals/models/deal_detail_model.dart';
import 'package:bachaoo/features/deals/views/widgets/included_card_itmes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bachaoo/common_widgets/app_text.dart';

import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/deals/views/widgets/claim_steps_card.dart';
import 'package:bachaoo/features/deals/views/widgets/contact_info_card.dart';
import 'package:bachaoo/features/deals/views/widgets/deal_header_image.dart';
import 'package:bachaoo/features/deals/views/widgets/deal_price_row.dart';
import 'package:bachaoo/features/deals/views/widgets/deal_quantity_footer.dart';
import 'package:bachaoo/features/deals/views/widgets/bullet_list.dart';
import 'package:bachaoo/routes/bachaoo_routes.dart';

class DealsExploreScreen extends StatefulWidget {
  const DealsExploreScreen({super.key});

  @override
  State<DealsExploreScreen> createState() => _DealsExploreScreenState();
}

class _DealsExploreScreenState extends State<DealsExploreScreen> {
  int _quantity = 1;
  late final DealDetailModel _deal;

  @override
  void initState() {
    super.initState();
    final arg = Get.arguments;
    if (arg is DealDetailModel) {
      _deal = arg;
    } else {
      // TEMP: hardcoded demo data matching DealDetailModel.
      _deal = const DealDetailModel(
        title: 'Bachaoo Deal 1',
        businessName: 'Dhuaan N Dhukan',
        location: 'Satellite Town',
        imageUrl: 'https://picsum.photos/seed/deal1-header/1200/900',
        saveLabel: 'Save Rs 150',
        price: 333,
        originalPrice: 483,
        discountPercentLabel: '31% less',
        includedItems: [
          '300g Dhuaan rice',
          '2 chicken tikka',
          'Maghoolta',
          '345ml drink',
        ],
        claimSteps: [
          'Scan the Bachaoo QR at the counter, or add this deal to your cart.',
          'Ask staff for the 4-digit business code.',
          'Enter it, pay the discounted amount.',
        ],
        contactName: 'Naveed Anwar',
        contactRole: 'CEO',
        contactPhone: '0304 7665454',
        contactAddress: 'Main Zafar Ullah Chowk, Satellite Town, Sargodha',
        terms: [
          'Credit is not allowed for Bachaoo members.',
          'Membership must be shown and verified at billing.',
          'Cannot be combined with other offers.',
          'Dine‑in and takeaway only.',
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header: image, save badge, title, back/share buttons ---
            DealHeaderImage(
              imageUrl: _deal.imageUrl ?? '',
              saveLabel: _deal.saveLabel,
              title: _deal.title,
              subtitle: '${_deal.businessName} · ${_deal.location}',
              onBackTap: () => Get.back(),
              onShareTap: () {},
            ),

            Padding(
              padding: const EdgeInsets.all(AppDimensions.pagePaddingSmall),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Price ---
                  DealPriceRow(
                    price: _deal.price,
                    originalPrice: _deal.originalPrice,
                    discountPercentLabel: _deal.discountPercentLabel,
                  ),
                  AppDimensions.verticalSpace24,

                  // --- What's included ---
                  AppText.titleLarge("What's included"),
                  AppDimensions.verticalSpace12,
                  IncludedItemsCard(items: _deal.includedItems),
                  AppDimensions.verticalSpace24,

                  // --- How to claim ---
                  AppText.titleLarge('How to claim'),
                  AppDimensions.verticalSpace12,
                  ClaimStepsCard(steps: _deal.claimSteps),
                  AppDimensions.verticalSpace24,

                  // --- Contact ---
                  AppText.titleLarge('Contact'),
                  AppDimensions.verticalSpace12,
                  ContactInfoCard(
                    name: _deal.contactName,
                    role: _deal.contactRole,
                    phone: _deal.contactPhone,
                    address: _deal.contactAddress,
                    onCallTap: () {},
                  ),
                  AppDimensions.verticalSpace24,

                  // --- Terms ---
                  AppText.titleLarge('Terms'),
                  AppDimensions.verticalSpace12,
                  BulletList(items: _deal.terms),

                  // Space so the last section clears the sticky footer
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: DealQuantityFooter(
        quantity: _quantity,
        onQuantityChanged: (value) => setState(() => _quantity = value),
        unitPrice: _deal.price,
        onAddToCart: () => Get.toNamed(
          AppRoutes.cartScreen,
          arguments: {
            'vendorName': _deal.businessName,
            'vendorLocation': _deal.location,
            'deal': _deal,
            'quantity': _quantity,
          },
        ),
      ),
    );
  }
}
