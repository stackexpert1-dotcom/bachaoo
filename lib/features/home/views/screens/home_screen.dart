import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/common_widgets/custom_text_feild.dart';

import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/businesses/models/nearby_business_model.dart';
import 'package:bachaoo/features/category/models/category_model.dart';
import 'package:bachaoo/features/deals/models/deal_detail_model.dart';
import 'package:bachaoo/features/deals/models/deal_model.dart';
import 'package:bachaoo/features/discounts/models/discount_model.dart';
import 'package:bachaoo/features/home/models/partner_model.dart';
import 'package:bachaoo/features/home/models/promo_model.dart';
import 'package:bachaoo/features/home/views/widgets/bottom_nav_bar.dart';
import 'package:bachaoo/features/home/views/widgets/category_grid.dart';
import 'package:bachaoo/features/home/views/widgets/custom_app_bar.dart';
import 'package:bachaoo/features/home/views/widgets/featured_partner_section.dart';
import 'package:bachaoo/features/home/views/widgets/nearyou_businesses_section.dart';
import 'package:bachaoo/features/home/views/widgets/popular_discounts_section.dart';
import 'package:bachaoo/features/home/views/widgets/promo_carosel.dart';
import 'package:bachaoo/features/home/controllers/bottom_nav_controller.dart';
import 'package:bachaoo/features/home/views/widgets/trending_deals_section.dart';
import 'package:bachaoo/routes/bachaoo_routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // TEMP: hardcoded demo data until the backend endpoints are wired up.
  static const List<PromoModel> _demoPromos = [
    PromoModel(
      imageUrl:
          'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=800',
      badgeText: 'Members only',
      brandName: "McDonald's",
      subtitle: "McDonald's · Sargodha",
      offerTitle: '15% off every meal',
    ),
    PromoModel(
      imageUrl:
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800',
      offerTitle: 'Buy 1 Get 1 Free',
    ),
  ];

  static final List<CategoryModel> _demoCategories = [
    CategoryModel(
      title: 'Food',
      offersCount: 46,
      icon: Icons.lunch_dining_rounded,
      iconColor: Color(0xFFB33A2E),
      iconBackgroundColor: Color(0xFFFBE2DE),
      isFeatured: true,
    ),
    CategoryModel(
      title: 'Supermarket',
      offersCount: 12,
      icon: Icons.shopping_cart_rounded,
      iconColor: Color(0xFF9A6A12),
      iconBackgroundColor: Color(0xFFFAF2DE),
      isFeatured: true,
    ),
    CategoryModel(
      title: 'Beauty & care',
      offersCount: 9,
      faIcon: FaIcon(FontAwesomeIcons.paintbrush),
      iconColor: Color(0xFF6B4FA0),
      iconBackgroundColor: Color(0xFFE9E2F7),
      isFeatured: true,
    ),
    CategoryModel(
      title: 'Health',
      offersCount: 14,
      faIcon: FaIcon(FontAwesomeIcons.heartPulse),
      iconColor: Color(0xFF247A45),
      iconBackgroundColor: Color(0xFFE5F1E8),
      isFeatured: true,
    ),
    CategoryModel(
      title: 'Automobiles',
      offersCount: 7,
      icon: Icons.directions_car_rounded,
      iconColor: Color(0xFF3578A8),
      iconBackgroundColor: Color(0xFFE8F1F7),
      isFeatured: true,
    ),
    CategoryModel(
      title: 'Fashion',
      offersCount: 18,
      icon: Icons.checkroom_rounded,
      iconColor: Color(0xFFB0632B),
      iconBackgroundColor: Color(0xFFFBE9DD),
      isFeatured: true,
    ),
    CategoryModel(
      title: 'Education',
      offersCount: 18,
      icon: Icons.school_rounded,
      iconColor: Color(0xFF1C4777),
      iconBackgroundColor: Color(0xFFD6E7F5),

      isFeatured: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavController = Get.find<BottomNavController>();

    return Scaffold(
      backgroundColor: AppColors.appBackroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // --- App bar: kept outside the shared padding below, ---
              // --- since it already applies pagePaddingSmall itself. ---
              const CustomAppBar(),
              // AppDimensions.verticalSpace,

              // --- Everything else (search, promo carousel, and all sections) ---
              // --- shares one horizontal padding (16px) ---
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.pagePaddingSmall,
                ),
                child: Column(
                  children: [
                    CustomTextFormField(
                      hintText: 'Search deals, places, categories',
                      hintStyle: TextStyle(
                        fontSize: AppDimensions.fontSizeBodyMedium,
                        color: AppColors.textHint,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.textHint,
                      ),
                      radius: 12,
                    ),
                    AppDimensions.verticalSpace24,

                    // --- Promo carousel ---
                    PromoCarousel(
                      promos: _demoPromos,
                      onPromoTap: (promo) {
                        // navigate to deal details screen
                      },
                    ),
                    AppDimensions.verticalSpace40,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.headlineXSmall('Categories'),
                        AppText.bodySmall(
                          'See All',
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                    AppDimensions.verticalSpace16,

                    // --- Categories grid ---
                    CategoriesGrid(
                      categories: _demoCategories,
                      featuredOnly: true,
                      maxItems: 6,
                      onCategoryTap: (index, category) {
                        Get.toNamed('/categoryScreen', arguments: index);
                      },
                    ),

                    AppDimensions.verticalSpace24,
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     AppText.headlineSmall('Featured Partners'),
                    //     AppText.bodySmall(
                    //       '1/5',
                    //       color: AppColors.primaryColor,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //     AppDimensions.verticalSpace16,
                    //   ],
                    // ),
                    FeaturedPartnersSection(
                      partners: const [
                        PartnerModel(
                          title: 'Suzuki Falcon Motors',
                          subtitle: 'Save on labour, lubricants & spare parts',
                          videoUrl: 'https://progtips.ru/wp-content/uploads/2020/09/car.mp4',
                          isFeatured: true,
                        ),
                        PartnerModel(
                          title: 'Service Tyres',
                          subtitle: 'jb tyre service jaisi to fiker kaisi',
                          videoUrl: 'https://amplifymtrs.com/wp-content/uploads/2024/01/car_driving_720p.mp4',
                        ),
                      ],
                      onArrowTap: (partner) {
                        // e.g. analytics event: partner impression
                      },
                    ),
                    AppDimensions.verticalSpace24,
                    PopularDiscountsSection(
                      discounts: [
                        DiscountModel(
                          imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800',
                          discountLabel: '15% off',
                          title: "McDonald's",
                          subtitle: "Burgers & Meals · Sargodha",
                        ),

                        DiscountModel(
                          imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=800',
                          discountLabel: '20% off',
                          title: 'Pizza Hut',
                          subtitle: 'Pizzas & Deals · Sargodha',
                        ),

                        DiscountModel(
                          imageUrl: 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=800',
                          discountLabel: '15% off',
                          title: "McDonald's",
                          subtitle: "Fries & Sides · Sargodha",
                        ),

                        DiscountModel(
                          imageUrl: 'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?w=800',
                          discountLabel: '25% off',
                          title: 'KFC',
                          subtitle: 'Fried Chicken & Buckets',
                        ),
                        DiscountModel(
                          imageUrl: 'https://images.unsplash.com/photo-1551024506-0bccd828d307?w=800',
                          discountLabel: '20% off',
                          title: 'Dessert House',
                          subtitle: 'Donuts & Sweet Treats',
                        ),
                      ],
                      onDiscountTap: (discount) {
                        final business = BusinessModel(
                          name: discount.title,
                          location: 'Sargodha',
                          distanceKm: 0,
                          discountLabel: discount.discountLabel,
                          discountSubtitle: discount.subtitle,
                          imageUrl: discount.imageUrl,
                        );
                        Get.toNamed(
                          AppRoutes.discountExploreScreen,
                          arguments: BusinessModel.forDetailDemo(business),
                        );
                      },
                      onSeeAllTap: () {
                        Get.toNamed(AppRoutes.discountExploreScreen);
                      },
                    ),
                    AppDimensions.verticalSpace24,
                    TrendingDealsSection(
                      deals: const [
                        DealModel(
                          imageUrl: 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=800',
                          badgeLabel: '15% off',
                          title: "McDonald's",
                          subtitle: "McDonald's · Sargodha",
                          brandTag: 'McDonald\'s',
                          currentPrice: '666',
                          originalPrice: '750',
                          currency: 'Rs.',
                          showOnHome: true,
                          homePriority: 1,
                        ),
                        DealModel(
                          imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800',
                          badgeLabel: 'Buy 1 Get 1 Free',
                          title: 'KFC',
                          subtitle: 'All buckets & meals',
                          brandTag: 'KFC',
                          currentPrice: '999',
                          originalPrice: '1200',
                          currency: 'Rs.',
                          showOnHome: true,
                          homePriority: 2,
                          brandColor: Colors.red,
                        ),
                        DealModel(
                          imageUrl: 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=800',
                          badgeLabel: '20% off',
                          title: 'Pizza Hut',
                          subtitle: 'All buckets & meals',
                          brandTag: 'PH',
                          currentPrice: '899',
                          originalPrice: '1200',
                          currency: 'Rs.',
                          showOnHome: true,
                          homePriority: 3,
                          brandColor: Colors.yellow,
                        ),
                        DealModel(
                          imageUrl: 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=800',
                          badgeLabel: '20% off',
                          title: 'Pizza Hut',
                          subtitle: 'All buckets & meals',
                          brandTag: 'Tehzeeb',
                          currentPrice: '899',
                          originalPrice: '1200',
                          currency: 'Rs.',
                          showOnHome: true,
                          homePriority: 3,
                          brandColor: Colors.redAccent,
                        ),
                      ],
                      onDealTap: (deal) {
                        Get.toNamed(
                          AppRoutes.dealsExploreScreen,
                          arguments: DealDetailModel.fromDealModel(deal),
                        );
                      },
                      onSeeAllTap: () {
                        // navigate to see all discounts screen
                      },
                    ),
                    AppDimensions.verticalSpace24,
                    NearYouSection(
                      businesses: const [
                        BusinessModel(
                          name: 'Al-Buraq Restaurant',
                          location: 'Satellite Town',
                          distanceKm: 1.2,
                          isNew: true,
                          discountLabel: '15%',
                          discountSubtitle: 'off bill',
                          isFeatured: true,
                          imageUrl: 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=800',
                        ),
                        BusinessModel(
                          name: 'De Café',
                          location: 'Queen Road',
                          distanceKm: 2.0,
                          rating: 4.3,
                          reviewCount: 12,
                          discountLabel: '10%',
                          discountSubtitle: 'off bill',
                          isFeatured: true,
                          imageUrl: 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=800',
                        ),
                        BusinessModel(
                          name: 'KFC',
                          location: 'Queen Road',
                          distanceKm: 5.0,
                          rating: 4.9,
                          reviewCount: 12,
                          discountLabel: '20%',
                          discountSubtitle: 'off bill',
                          isFeatured: true,
                          imageUrl: 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=800',
                        ),
                      ],
                      onBusinessTap: (business) {
                        // navigate to business details
                      },
                      onMapTap: () {
                        // open map view
                      },
                    ),
                  ],
                ),
              ),
              AppDimensions.verticalSpace24,
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => CustomBottomNavBar(
          currentIndex: bottomNavController.currentIndex,
          onTap: bottomNavController.changeIndex,
          onCenterTap: () => Get.toNamed(AppRoutes.qrEntryScreen),
        ),
      ),
    );
  }
}
