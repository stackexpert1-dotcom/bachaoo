import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/common_widgets/business_header_image.dart';
import 'package:bachaoo/common_widgets/business_info_card.dart';
import 'package:bachaoo/common_widgets/member_promo_banner.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/businesses/models/nearby_business_model.dart';
import 'package:bachaoo/features/deals/models/deal_detail_model.dart';
import 'package:bachaoo/features/deals/models/deal_model.dart';
import 'package:bachaoo/features/discounts/models/discount_model.dart';
import 'package:bachaoo/features/discounts/views/widgets/deal_explore_card.dart';
import 'package:bachaoo/features/discounts/views/widgets/discount_explore_card.dart';
import 'package:bachaoo/features/discounts/views/widgets/segmeted_tab_bar.dart';
import 'package:bachaoo/features/reviews/models/review_model.dart';
import 'package:bachaoo/features/reviews/views/widgets/review_section.dart';
import 'package:bachaoo/routes/bachaoo_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bachaoo/features/cart/controllers/cart_controller.dart';
import 'package:bachaoo/features/cart/models/cart_item_model.dart';
import 'package:bachaoo/common_widgets/primary_button.dart';

class DiscountExploreScreen extends StatefulWidget {
  const DiscountExploreScreen({super.key});

  @override
  State<DiscountExploreScreen> createState() => _DiscountExploreScreenState();
}

class _DiscountExploreScreenState extends State<DiscountExploreScreen> {
  int _selectedTabIndex = 0;
  late final BusinessModel _business;

  /// Selected items are DealModel or DiscountModel instances.
  final Set<Object> _selectedItems = {};

  /// True when the screen was opened from the cart screen ("Add more deals").
  /// Only then do taps select deals to add to the cart; otherwise they open
  /// the deal/discount detail instead.
  bool _selectionMode = false;

  @override
  void initState() {
    super.initState();
    final arg = Get.arguments;
    if (arg is BusinessModel) {
      _business = arg;
    } else if (arg is Map) {
      // Reached from the cart screen ("Add more deals") → selection mode.
      _selectionMode = arg['fromCart'] as bool? ?? false;
      final business = arg['business'];
      _business = business is BusinessModel ? business : _demoBusiness();
    } else {
      _business = _demoBusiness();
    }
  }

  BusinessModel _demoBusiness() => const BusinessModel(
        name: 'Dhuaan N Dhukan',
        location: 'Old Satellite Town',
        address: 'Zafarullah Chowk, Block A, Old Satellite Town, Sargodha',
        distanceKm: 2.8,
        isOpenNow: true,
        dealsCount: 3,
        rating: 5.0,
        reviewCount: 48,
        phoneNumber: '0304 7665454',
        discountLabel: 'Up to 15%',
        discountSubtitle: 'on select deals',
        isFeatured: true,
        coverImageUrl:
            'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=1200',
        logoUrl:
            'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400',
      );

  List<DealModel> get _deals {
    final nameLower = _business.name.toLowerCase();
    if (nameLower.contains('suzuki') || nameLower.contains('motors')) {
      return const [
        DealModel(
          title: 'Periodic Service',
          subtitle: 'Engine Tuning · Lubricants · Filter Change',
          imageUrl:
              'https://images.unsplash.com/photo-1486006920555-c77dce18193b?w=600',
          badgeLabel: 'Save Rs 800',
          brandTag: 'Suzuki',
          currentPrice: '2499',
          originalPrice: '3299',
          currency: 'Rs',
          includedItems: [
            'Engine oil replacement (3.5L)',
            'Oil & air filter tuning',
            'Full 40-point safety check',
            'Complimentary car wash',
          ],
          claimSteps: [
            'Scan the Bachaoo QR at Suzuki Falcon Motors counter.',
            'Show your active membership card.',
            'Pay discounted service charge.',
          ],
          contactName: 'Tariq Mehmood',
          contactRole: 'Service Manager',
          contactPhone: '0300 8645000',
          contactAddress: 'Main University Road, Sargodha',
          terms: [
            'Valid for Suzuki vehicles only.',
            'Must present Bachaoo membership card.',
            'Dine-in or appointment required.',
          ],
        ),
        DealModel(
          title: 'Brake & Suspension',
          subtitle: 'Pad Replacement & Rotor Resurfacing',
          imageUrl:
              'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=600',
          badgeLabel: 'Save Rs 500',
          brandTag: 'Suzuki',
          currentPrice: '1899',
          originalPrice: '2399',
          currency: 'Rs',
          includedItems: [
            'Front brake pad installation',
            'Rotor inspection & cleaning',
            'Brake fluid top-up',
          ],
          claimSteps: [
            'Scan the Bachaoo QR at counter.',
            'Pay discounted amount.',
          ],
          contactName: 'Tariq Mehmood',
          contactRole: 'Service Manager',
          contactPhone: '0300 8645000',
          contactAddress: 'Main University Road, Sargodha',
          terms: ['Valid all days.'],
        ),
        DealModel(
          title: 'AC Gas & Cleaning',
          subtitle: 'Full Climate Control Overhaul',
          imageUrl:
              'https://images.unsplash.com/photo-1619642751034-765dfdf7c58e?w=600',
          badgeLabel: 'Save Rs 600',
          brandTag: 'Suzuki',
          currentPrice: '2199',
          originalPrice: '2799',
          currency: 'Rs',
          includedItems: [
            'R134a refrigerant refill',
            'Cabin AC filter replacement',
            'Leak detection check',
          ],
          claimSteps: ['Scan QR at billing.'],
          contactName: 'Tariq Mehmood',
          contactRole: 'Service Manager',
          contactPhone: '0300 8645000',
          contactAddress: 'Main University Road, Sargodha',
          terms: ['Valid all days.'],
        ),
      ];
    } else if (nameLower.contains('tyre') || nameLower.contains('service')) {
      return const [
        DealModel(
          title: 'Wheel Alignment',
          subtitle: '3D Laser Alignment & Wheel Balancing',
          imageUrl:
              'https://images.unsplash.com/photo-1578844251758-2f71da64c96f?w=600',
          badgeLabel: 'Save Rs 400',
          brandTag: 'Service',
          currentPrice: '1199',
          originalPrice: '1599',
          currency: 'Rs',
          includedItems: [
            '3D Computerized alignment',
            '4 Wheel balancing with weights',
            'Tire pressure & tread check',
          ],
          claimSteps: ['Scan QR at counter.'],
          contactName: 'Imran Service',
          contactRole: 'Store Manager',
          contactPhone: '0301 7654321',
          contactAddress: 'Bypass Road, Sargodha',
          terms: ['Valid for all cars.'],
        ),
        DealModel(
          title: '4 Tyre Set Deal',
          subtitle: 'Buy 4 Tyres & Get Free Alignment',
          imageUrl:
              'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=600',
          badgeLabel: '15% Off',
          brandTag: 'Service',
          currentPrice: '28500',
          originalPrice: '33500',
          currency: 'Rs',
          includedItems: [
            '4 Premium Service radial tyres',
            'Free valve replacement & nitrogen fill',
            'Free 3D wheel alignment',
          ],
          claimSteps: ['Scan QR at counter.'],
          contactName: 'Imran Service',
          contactRole: 'Store Manager',
          contactPhone: '0301 7654321',
          contactAddress: 'Bypass Road, Sargodha',
          terms: ['Valid on complete sets.'],
        ),
      ];
    } else {
      // Default food/restaurant deals with real photos
      return const [
        DealModel(
          title: 'Meal Combo Deal 1',
          subtitle: 'Main Course · Drinks · Side',
          imageUrl:
              'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600',
          badgeLabel: 'Save Rs 200',
          brandTag: 'Special',
          currentPrice: '699',
          originalPrice: '899',
          currency: 'Rs',
          includedItems: [
            'Signature burger / main dish',
            'Crispy fries / appetizer',
            'Chilled 500ml beverage',
          ],
          claimSteps: [
            'Scan Bachaoo QR at billing.',
            'Show active card on mobile app.',
          ],
          contactName: 'Manager On Duty',
          contactRole: 'Branch Manager',
          contactPhone: '0300 1234567',
          contactAddress: 'Sargodha Main Branch',
          terms: ['Dine-in and takeaway.'],
        ),
        DealModel(
          title: 'Family Feast Deal 2',
          subtitle: 'Large Combo Bucket & Pizzas',
          imageUrl:
              'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=600',
          badgeLabel: '25% Off',
          brandTag: 'Family',
          currentPrice: '1499',
          originalPrice: '1999',
          currency: 'Rs',
          includedItems: [
            '2 Large dishes / burgers',
            '4 Crispy chicken pieces',
            '1.5L soft drink',
          ],
          claimSteps: ['Scan QR at counter.'],
          contactName: 'Manager On Duty',
          contactRole: 'Branch Manager',
          contactPhone: '0300 1234567',
          contactAddress: 'Sargodha Main Branch',
          terms: ['Valid all week.'],
        ),
        DealModel(
          title: 'Dessert & Drink Bundle',
          subtitle: 'Sweet Treats & Special Drinks',
          imageUrl:
              'https://images.unsplash.com/photo-1551024506-0bccd828d307?w=600',
          badgeLabel: 'Save Rs 150',
          brandTag: 'Dessert',
          currentPrice: '450',
          originalPrice: '600',
          currency: 'Rs',
          includedItems: [
            '2 Premium scoops or donuts',
            '2 Gourmet coffee / shake drinks',
          ],
          claimSteps: ['Scan QR at counter.'],
          contactName: 'Manager On Duty',
          contactRole: 'Branch Manager',
          contactPhone: '0300 1234567',
          contactAddress: 'Sargodha Main Branch',
          terms: ['Valid all week.'],
        ),
      ];
    }
  }

  List<DiscountModel> get _discounts {
    final nameLower = _business.name.toLowerCase();
    if (nameLower.contains('suzuki') || nameLower.contains('service')) {
      return const [
        DiscountModel(
          title: 'Labour & Service Discount',
          subtitle: 'Mon–Sat, All Day',
          imageUrl:
              'https://images.unsplash.com/photo-1517524008697-84bbe3c3fd98?w=600',
          discountLabel: '20% off',
          tags: ['Parts', 'Labour', 'Workshop'],
          description:
              'Get 20% off total workshop labour bill for Bachaoo card members. Applicable on all maintenance and inspection services.',
          contactName: 'Service Desk',
          contactRole: 'Supervisor',
          contactPhone: '0300 8645000',
          contactAddress: 'Sargodha Workshop',
          terms: ['Must present Bachaoo membership.'],
        ),
        DiscountModel(
          title: 'Spare Parts Discount',
          subtitle: 'Genuine Parts Only',
          imageUrl:
              'https://images.unsplash.com/photo-1619642751034-765dfdf7c58e?w=600',
          discountLabel: '10% off',
          tags: ['Genuine Parts', 'Warranty'],
          description:
              '10% instant discount on OEM spare parts, filters, and synthetic engine oils.',
          contactName: 'Service Desk',
          contactRole: 'Supervisor',
          contactPhone: '0300 8645000',
          contactAddress: 'Sargodha Workshop',
          terms: ['Valid for all cardholders.'],
        ),
      ];
    } else {
      return const [
        DiscountModel(
          title: 'Total Bill Discount',
          subtitle: 'Mon–Thu, 12 pm – 11 pm',
          imageUrl:
              'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=600',
          discountLabel: '15% off',
          tags: ['Dine-in', 'Takeaway', 'Cash & Card'],
          description:
              'Enjoy 15% off your complete bill. Show your Bachaoo digital card at checkout.',
          contactName: 'Branch Manager',
          contactRole: 'Manager',
          contactPhone: '0300 1234567',
          contactAddress: 'Sargodha Branch',
          terms: ['Valid Mon–Thu.'],
        ),
        DiscountModel(
          title: 'Weekend Special',
          subtitle: 'Fri–Sun, Min order Rs 1,000',
          imageUrl:
              'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=600',
          discountLabel: 'Rs 250 off',
          tags: ['Weekend', 'Family', 'Dine-in'],
          description:
              'Save Rs 250 on orders above Rs 1,000 during weekends.',
          contactName: 'Branch Manager',
          contactRole: 'Manager',
          contactPhone: '0300 1234567',
          contactAddress: 'Sargodha Branch',
          terms: ['Minimum order Rs 1,000.'],
        ),
      ];
    }
  }

  final List<ReviewModel> _reviews = [
    const ReviewModel(
      reviewerName: 'Ahmed K.',
      rating: 5,
      comment: 'Deal 2 easily fed two of us. Staff knew the Bachaoo card right away.',
    ),
  ];

  /// Shared tap handler for both Deals and Discounts tabs — toggles selection
  /// in selection mode, or opens the detail screen otherwise.
  void _onCardTap(Object item, {required VoidCallback onOpenDetail}) {
    if (!_selectionMode) {
      onOpenDetail();
      return;
    }
    setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
      } else {
        _selectedItems.add(item);
      }
    });
  }

  void _selectTab(int index) {
    if (index == _selectedTabIndex) return;
    setState(() => _selectedTabIndex = index);
  }

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
                  // --- Member promo banner ---
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
                    onChanged: _selectTab,
                  ),
                  AppDimensions.verticalSpace20,

                  // IndexedStack retains the tallest tab's layout, so changing
                  // tabs swaps content in place without changing scroll extent.
                  IndexedStack(
                    index: _selectedTabIndex,
                    children: [
                      Wrap(
                        spacing: AppDimensions.spacingMedium,
                        runSpacing: AppDimensions.spacingMedium,
                        children: _deals.map((deal) {
                          return SizedBox(
                            width: cardWidth,
                            child: DealExploreCard(
                              deal: deal,
                              onTap: () => _onCardTap(
                                deal,
                                onOpenDetail: () => Get.toNamed(
                                  AppRoutes.dealsExploreScreen,
                                  arguments: DealDetailModel.fromDealModel(deal),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      _discounts.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 40,
                                ),
                                child: AppText.bodyMedium('No discounts yet'),
                              ),
                            )
                          : Wrap(
                              spacing: AppDimensions.spacingMedium,
                              runSpacing: AppDimensions.spacingMedium,
                              children: _discounts.map((discount) {
                                return DiscountExploreCard(
                                  discount: discount,
                                  width: cardWidth,
                                  isSelected: _selectedItems.contains(discount),
                                  onTap: () => _onCardTap(
                                    discount,
                                    onOpenDetail: () => Get.toNamed(
                                      AppRoutes.discountViewScreen,
                                      arguments: discount,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                      ReviewsSection(
                        reviews: _reviews,
                        onReviewSubmitted: (review) {
                          setState(() => _reviews.insert(0, review));
                        },
                      ),
                    ],
                  ),

                  AppDimensions.verticalSpace24,
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _selectionMode && _selectedItems.isNotEmpty
          ? Container(
              padding: const EdgeInsets.all(AppDimensions.pagePadding),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: PrimaryButton(
                label: 'Add ${_selectedItems.length} to Cart',
                onTap: () {
                  final cartController = Get.put<CartController>(
                    CartController(),
                  );
                  for (final item in _selectedItems) {
                    if (item is DealModel) {
                      cartController.addItem(
                        CartItemModel(
                          imageUrl: item.imageUrl ?? '',
                          title: item.title,
                          subtitle: item.subtitle,
                          currentPrice: item.currentPrice ?? '333',
                          originalPrice: item.originalPrice ?? '483',
                          quantity: 1,
                        ),
                      );
                    } else if (item is DiscountModel) {
                      cartController.addItem(
                        CartItemModel(
                          imageUrl: item.imageUrl,
                          title: item.title,
                          subtitle: item.subtitle,
                          currentPrice: '333', // Dummy default price
                          originalPrice: '483', // Dummy default price
                          quantity: 1,
                        ),
                      );
                    }
                  }
                  setState(() => _selectedItems.clear());
                  Get.back();
                },
              ),
            )
          : null,
    );
  }
}
