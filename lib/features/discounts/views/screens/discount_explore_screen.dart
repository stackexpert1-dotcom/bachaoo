import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/common_widgets/business_header_image.dart';
import 'package:bachaoo/common_widgets/business_info_card.dart';
import 'package:bachaoo/common_widgets/member_promo_banner.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/businesses/models/nearby_business_model.dart';
import 'package:bachaoo/features/deals/models/deal_detail_model.dart';
import 'package:bachaoo/features/discounts/models/discount_model.dart';
import 'package:bachaoo/features/discounts/views/widgets/discount_card.dart';
import 'package:bachaoo/features/discounts/views/widgets/segmeted_tab_bar.dart';
import 'package:bachaoo/features/reviews/models/review_model.dart';
import 'package:bachaoo/features/reviews/views/widgets/review_section.dart';
import 'package:bachaoo/routes/bachaoo_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscountExploreScreen extends StatefulWidget {
  const DiscountExploreScreen({super.key});

  @override
  State<DiscountExploreScreen> createState() => _DiscountExploreScreenState();
}

class _DiscountExploreScreenState extends State<DiscountExploreScreen> {
  int _selectedTabIndex = 0;
  late final BusinessModel _business;

  @override
  void initState() {
    super.initState();
    final arg = Get.arguments;
    if (arg is BusinessModel) {
      _business = arg;
    } else {
      _business = const BusinessModel(
        name: 'Dhuaan N Dhukan',
        location: 'Old Satellite Town',
        address: 'Zafarullah Chowk, Block A, Old Satellite Town',
        distanceKm: 2.8,
        isOpenNow: true,
        dealsCount: 3,
        rating: 5.0,
        reviewCount: 4,
        phoneNumber: '0304 7665454',
        discountLabel: 'Up to 15%',
        discountSubtitle: 'on select deals',
        isFeatured: true,
        coverImageUrl: 'https://picsum.photos/seed/dhuaan-cover/1200/600',
        logoUrl: 'https://picsum.photos/seed/dhuaan-logo/200/200',
      );
    }
  }

  final List<DiscountModel> _deals = const [
    DiscountModel(
      imageUrl: 'https://picsum.photos/seed/deal1/600/600',
      discountLabel: 'Save 150',
      title: 'Deal 1',
      subtitle: 'Valid all week',
    ),
    DiscountModel(
      imageUrl: 'https://picsum.photos/seed/deal2/600/600',
      discountLabel: 'Save 150',
      title: 'Deal 2',
      subtitle: 'Dine-in only',
    ),
    DiscountModel(
      imageUrl: 'https://picsum.photos/seed/deal3/600/600',
      discountLabel: 'Save 100',
      title: 'Deal 3',
      subtitle: 'Fri–Sun only',
    ),
  ];

  // NEW: the "Discounts" tab was previously just a placeholder — now
  // populated the same way as _deals, using the same DiscountCard.
  final List<DiscountModel> _discounts = const [
    DiscountModel(
      imageUrl: 'https://picsum.photos/seed/discount1/600/600',
      discountLabel: '10% off',
      title: 'Weekday lunch',
      subtitle: 'Mon–Thu, 12–3pm',
      description:
          'A quick, light lunch deal available Monday to Thursday between noon '
          'and 3pm. Perfect for a fast bite without the weekend rush.',
      tags: ['Dine-in', 'Takeaway', 'Cash & card'],
      contactName: 'Naveed Anwar',
      contactRole: 'Owner',
      contactPhone: '0304 7665454',
      contactAddress: 'Main Zafar Ullah Chowk, Satellite Town, Sargodha',
      terms: [
        'Membership must be shown and verified at billing.',
        'Cannot be combined with other offers.',
      ],
    ),
    DiscountModel(
      imageUrl: 'https://picsum.photos/seed/discount2/600/600',
      discountLabel: 'Rs 200 off',
      title: 'Family bundle',
      subtitle: 'Minimum order Rs 1,500',
      description:
          'Feed the whole family with this bundle. Applied automatically at '
          'billing once your order crosses Rs 1,500.',
      tags: ['Dine-in', 'Cash & card', 'Cap Rs 200'],
      contactName: 'Naveed Anwar',
      contactRole: 'Owner',
      contactPhone: '0304 7665454',
      contactAddress: 'Main Zafar Ullah Chowk, Satellite Town, Sargodha',
      terms: [
        'Minimum order of Rs 1,500 before discount.',
        'Cannot be combined with other offers.',
      ],
    ),
  ];
  final List<ReviewModel> _reviews = [
    const ReviewModel(
      reviewerName: 'Ahmed K.',
      rating: 5,
      comment: 'Deal 2 easily fed two of us. Staff knew the Bachaoo card right away.',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final cardWidth =
        (MediaQuery.of(context).size.width -
            (AppDimensions.pagePaddingSmall * 2) -
            AppDimensions.spacingMedium) /
        2;

    return Scaffold(
      backgroundColor: AppColors.appBackroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header image: coverImageUrl (banner) ---
            BusinessHeaderImage(
              imageUrl: _business.coverImageUrl,
              onBackTap: () => Get.back(),
            ),

            // --- Info card overlapping the header image (shows logoUrl) ---
            Transform.translate(
              offset: const Offset(0, -40),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.pagePaddingSmall,
                ),
                child: BusinessInfoCard(
                  business: _business,
                  onDirectionsTap: () {},
                  onCallTap: () {},
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.pagePaddingSmall,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Member promo banner — imageUrl was missing before ---
                  MemberPromoBanner(
                    badgeLabel: 'This weekend',
                    brandInitial: 'B',
                    title: 'Extra 5% off Deal 3 for members',
                    subtitle:
                        'Fri–Sun · dine-in only · scan the QR at the counter',
                    imageUrl: 'https://picsum.photos/seed/promo-banner/900/500',
                  ),
                  AppDimensions.verticalSpace24,

                  // --- Tabs ---
                  SegmentedTabBar(
                    tabs: [
                      'Deals · ${_deals.length}',
                      'Discounts · ${_discounts.length}',
                      'Reviews · ${_business.reviewCount ?? 0}',
                    ],
                    selectedIndex: _selectedTabIndex,
                    onChanged: (index) =>
                        setState(() => _selectedTabIndex = index),
                  ),
                  AppDimensions.verticalSpace20,

                  // --- Deals / Discounts / Reviews content ---
                  if (_selectedTabIndex == 0)
                    Wrap(
                      spacing: AppDimensions.spacingMedium,
                      runSpacing: AppDimensions.spacingMedium,
                      children: _deals.map((deal) {
                        return DiscountCard(
                          discount: deal,
                          width: cardWidth,
                          onTap: () {
                            final dummyDeal = const DealDetailModel(
                              title: 'Bachaoo Deal from Discount',
                              businessName: 'Dhuaan N Dhukan',
                              location: 'Satellite Town',
                              imageUrl: 'https://picsum.photos/seed/deal-from-discount/1200/900',
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
                            Get.toNamed(
                              AppRoutes.dealsExploreScreen,
                              arguments: dummyDeal,
                            );
                          },
                        );
                      }).toList(),
                    )
                  else if (_selectedTabIndex == 1)
                    _discounts.isEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 40),
                              child: AppText.bodyMedium('No discounts yet'),
                            ),
                          )
                        : Wrap(
                            spacing: AppDimensions.spacingMedium,
                            runSpacing: AppDimensions.spacingMedium,
                            children: _discounts.map((discount) {
                              return DiscountCard(
                                discount: discount,
                                width: cardWidth,
                                onTap: () => Get.toNamed(
                                  AppRoutes.discountViewScreen,
                                  arguments: discount,
                                ),
                              );
                            }).toList(),
                          )
                  else
                    ReviewsSection(
                      reviews: _reviews, // a List<ReviewModel>, state-held so it updates on submit
                      onReviewSubmitted: (review) {
                        setState(() => _reviews.insert(0, review));
                      },
                    ),

                  AppDimensions.verticalSpace24,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
