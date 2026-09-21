import 'package:bachaoo/features/deals/views/widgets/bullet_list.dart';
import 'package:bachaoo/features/discounts/models/claim_summary_model.dart';
import 'package:bachaoo/features/discounts/views/widgets/discount_business_code_bottom_sheet.dart';
import 'package:bachaoo/features/discounts/views/widgets/claim_button_footer.dart';
import 'package:bachaoo/features/discounts/views/widgets/discount_contact_details_card.dart';
import 'package:bachaoo/features/discounts/views/widgets/discount_header_image.dart';
import 'package:bachaoo/features/discounts/views/widgets/discount_tags_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/discounts/models/discount_model.dart';
import 'package:bachaoo/routes/bachaoo_routes.dart';

class DiscountViewScreen extends StatefulWidget {
  const DiscountViewScreen({super.key});

  @override
  State<DiscountViewScreen> createState() => _DiscountViewScreenState();
}

class _DiscountViewScreenState extends State<DiscountViewScreen> {
  late final DiscountModel _discount;

  @override
  void initState() {
    super.initState();
    final arg = Get.arguments;
    if (arg is DiscountModel) {
      _discount = arg;
    } else {
      // TEMP: hardcoded demo data until this is wired to real navigation.
      _discount = const DiscountModel(
        imageUrl: 'https://picsum.photos/seed/chobara-restaurant/1200/900',
        discountLabel: '12%',
        title: 'off your entire bill',
        subtitle: 'Chobara Restaurant · Queen Road',
        tags: ['Dine-in', 'Takeaway', 'Cash & card', 'Cap Rs 1,500'],
        description:
            'Quality dining on the Toheed Mall rooftop. Good for family '
            'dinners, gatherings and casual meals with friends.',
        contactName: 'Ghulsher Afghan',
        contactRole: 'Owner',
        contactPhone: '0324 9300001',
        contactAddress: 'Rooftop, Toheed Shopping Mall, Queen Road',
        terms: [
          'Credit is not allowed for Bachaoo members.',
          'Membership must be shown and verified at billing.',
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
            // --- Header: photo, percent, description, back button ---
            DiscountHeaderImage(
              imageUrl: _discount.imageUrl,
              subtitle: _discount.subtitle,
              percentLabel: _discount.discountLabel,
              description: _discount.title,
              onBackTap: () => Navigator.of(context).maybePop(),
            ),

            Padding(
              padding: const EdgeInsets.all(AppDimensions.pagePaddingSmall),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Info tags ---
                  if (_discount.tags != null)
                    DiscountTagsRow(tags: _discount.tags!),
                  AppDimensions.verticalSpace24,

                  // --- What to expect ---
                  if (_discount.description != null) ...[
                    AppText.titleLarge('What to expect'),
                    AppDimensions.verticalSpace12,
                    AppText.bodyLarge(
                      _discount.description!,
                      color: AppColors.textSecondary,
                    ),
                    AppDimensions.verticalSpace24,
                  ],

                  // --- Contact ---
                  if (_discount.contactName != null) ...[
                    AppText.titleLarge('Contact'),
                    AppDimensions.verticalSpace12,
                    ContactDetailCard(
                      role: _discount.contactRole ?? 'Contact',
                      name: _discount.contactName!,
                      phone: _discount.contactPhone ?? '',
                      address: _discount.contactAddress ?? '',
                      onDirectionsTap: () {},
                    ),
                    AppDimensions.verticalSpace24,
                  ],

                  // --- Terms & conditions ---
                  if (_discount.terms != null &&
                      _discount.terms!.isNotEmpty) ...[
                    AppText.titleLarge('Terms & conditions'),
                    AppDimensions.verticalSpace12,
                    BulletList(items: _discount.terms!),
                  ],

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ClaimButtonFooter(
        label: 'Claim ${_discount.discountLabel} discount',
        onTap: () {
          // BusinessCodeBottomSheet.show(
          //   context,
          //   summary: ClaimSummary(
          //     totalBill: 2000,
          //     amountPaid: 1800,
          //     discountAmount: 200,
          //   ),
          // );
          Get.toNamed(AppRoutes.claimDiscountScreen, arguments: _discount);
        },
      ),
    );
  }
}
