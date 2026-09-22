import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/common_widgets/custom_text_feild.dart';

import 'package:bachaoo/core/constants/bachaoo_assets.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/businesses/models/nearby_business_model.dart';
import 'package:bachaoo/features/category/models/category_model.dart';
import 'package:bachaoo/features/deals/models/deal_model.dart';
import 'package:bachaoo/features/home/models/partner_model.dart';
import 'package:bachaoo/features/home/models/promo_model.dart';
import 'package:bachaoo/features/home/views/widgets/bottom_nav_bar.dart';
import 'package:bachaoo/features/home/views/widgets/category_list.dart';
// import 'package:bachaoo/features/home/views/widgets/custom_app_bar.dart';
import 'package:bachaoo/features/home/views/widgets/featured_partner_section.dart';
import 'package:bachaoo/features/home/views/widgets/home_hero_header.dart';
import 'package:bachaoo/features/home/views/widgets/home_promo_subscription_card.dart';
import 'package:bachaoo/features/home/views/widgets/nearyou_businesses_section.dart';
import 'package:bachaoo/features/home/views/widgets/popular_discounts_section.dart';
import 'package:bachaoo/features/home/views/widgets/promo_carosel.dart';
import 'package:bachaoo/features/home/controllers/bottom_nav_controller.dart';
import 'package:bachaoo/features/home/views/widgets/trending_deals_section.dart';
import 'package:bachaoo/routes/bachaoo_routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearchOpen = false;

  // Photo-led business identity cards. These use actual storefronts, showrooms,
  // and retail spaces rather than standalone products or brand-logo graphics.
  static const List<PromoModel> _demoPromos = [
    PromoModel(
      imageUrl: 'https://www.narcity.com/media-library/the-exterior-of-a-mcdonald-s.jpg?coordinates=0%2C353%2C0%2C0&height=600&id=51173894&width=1200',
      badgeText: 'Members Only',
      brandName: "McDonald's",
      subtitle: "McDonald's Drive-Thru · Sargodha",
      offerTitle: '15% off burgers & value meals',
      category: 'Fast food',
      rating: 4.8,
      distanceLabel: '1.2 km away',
    ),
    PromoModel(
      imageUrl: 'https://www.retail4growth.com/public/uploads/editor/2021-03-31/1617167390.jpg',
      badgeText: 'Exclusive',
      brandName: 'KFC',
      subtitle: 'KFC · Club Road, Sargodha',
      offerTitle: 'Buy 1 Get 1 Free on Zinger Buckets',
      category: 'Fried chicken',
      rating: 4.7,
      distanceLabel: '2.1 km away',
    ),
    PromoModel(
      imageUrl: 'https://img.tamindir.com/resize/1200x675/2024/01/476760/tesla-turkiyedeki-ilk-showroom-acti-2.jpg',
      badgeText: 'Hot Deal',
      brandName: 'Tesla',
      subtitle: 'Tesla Experience Centre · Lahore',
      offerTitle: 'Complimentary test-drive booking',
      category: 'Electric cars',
      rating: 4.9,
      distanceLabel: '3.8 km away',
    ),
    PromoModel(
      imageUrl: 'https://images1.loopnet.com/i2/nVZ516YM1Ea2KKRD2ECV5JU5rISye5Uo_UHKNqDaK4I/110/1355-Kingston-Rd-Pickering-ON-EBT_0199_Final-2-Large.jpg',
      badgeText: 'Trending',
      brandName: "Starbucks",
      subtitle: 'Starbucks Coffee · Sargodha',
      offerTitle: '20% off handcrafted drinks',
      category: 'Coffee',
      rating: 4.6,
      distanceLabel: '0.9 km away',
    ),
    PromoModel(
      imageUrl: 'https://cdn.gobankingrates.com/wp-content/uploads/2021/09/iStock-502301639-e1630502167659.jpg?quality=75&w=675&webp=1',
      badgeText: 'Special Offer',
      brandName: 'Nike',
      subtitle: 'Nike Store · Mall Road, Sargodha',
      offerTitle: 'Up to 25% off activewear',
      category: 'Sportswear',
      rating: 4.7,
      distanceLabel: '1.7 km away',
    ),
    PromoModel(
      imageUrl: 'https://www.islamabadscene.com/wp-content/uploads/2022/04/Carrefour-Pakistan.jpeg',
      badgeText: 'Everyday value',
      brandName: 'Carrefour',
      subtitle: 'Carrefour · Sargodha Mall',
      offerTitle: 'Save 10% on grocery essentials',
      category: 'Supermarket',
      rating: 4.5,
      distanceLabel: '2.4 km away',
    ),
    PromoModel(
      imageUrl: 'https://primelandproperties.pk/wp-content/uploads/2025/10/lahore-top-malls-by-prime-land-properties-1024x666.webp',
      badgeText: 'Weekend pick',
      brandName: 'Cinepax',
      subtitle: 'Cinepax · Sargodha',
      offerTitle: '15% off weekday movie tickets',
      category: 'Cinema',
      rating: 4.6,
      distanceLabel: '1.5 km away',
    ),
    PromoModel(
      imageUrl: 'https://cdn.shopify.com/s/files/1/1592/0041/files/1_2bb9308c-2663-4910-93b0-7bcf7ba61fd2.jpg?v=1701169889',
      badgeText: 'New in store',
      brandName: 'Sapphire',
      subtitle: 'Sapphire · University Road',
      offerTitle: '20% off selected new arrivals',
      category: 'Fashion',
      rating: 4.8,
      distanceLabel: '2.0 km away',
    ),
  ];

  static const String _mcdonaldsLogoUrl =
      'https://www.google.com/s2/favicons?sz=128&domain=mcdonalds.com';
  static const String _pizzaHutLogoUrl =
      'https://www.google.com/s2/favicons?sz=128&domain=pizzahut.com';
  static const String _kfcLogoUrl =
      'https://www.google.com/s2/favicons?sz=128&domain=kfc.com';
  static const String _tehzeebLogoUrl =
      'https://www.google.com/s2/favicons?sz=128&domain=tehzeeb.com';
  static const String _gloriaJeansLogoUrl =
      'https://www.google.com/s2/favicons?sz=128&domain=gloriajeanscoffees.com';

  static final List<CategoryModel> _demoCategories = [
    CategoryModel(
      title: 'Food',
      offersCount: 46,
      icon: Icons.lunch_dining_rounded,
      iconAsset: AppAssets.categoryFood,
      iconColor: Color(0xFFB33A2E),
      iconBackgroundColor: Color(0xFFFBE2DE),
      isFeatured: true,
    ),
    CategoryModel(
      title: 'Supermarket',
      offersCount: 12,
      icon: Icons.shopping_cart_rounded,
      iconAsset: AppAssets.categorySupermarket,
      iconColor: Color(0xFF9A6A12),
      iconBackgroundColor: Color(0xFFFAF2DE),
      isFeatured: true,
    ),
    CategoryModel(
      title: 'Beauty & care',
      offersCount: 9,
      faIcon: FaIcon(FontAwesomeIcons.paintbrush),
      iconAsset: AppAssets.categoryBeauty,
      iconColor: Color(0xFF6B4FA0),
      iconBackgroundColor: Color(0xFFE9E2F7),
      isFeatured: true,
    ),
    CategoryModel(
      title: 'Health',
      offersCount: 14,
      faIcon: FaIcon(FontAwesomeIcons.heartPulse),
      iconAsset: AppAssets.categoryHealth,
      iconColor: Color(0xFF247A45),
      iconBackgroundColor: Color(0xFFE5F1E8),
      isFeatured: true,
    ),
    CategoryModel(
      title: 'Hospitals',
      offersCount: 10,
      icon: Icons.local_hospital_rounded,
      iconAsset: AppAssets.categoryHospital,
      iconColor: Color(0xFFB33A2E),
      iconBackgroundColor: Color(0xFFFBE2DE),
      isFeatured: true,
    ),
    CategoryModel(
      title: 'Labs',
      offersCount: 8,
      icon: Icons.science_rounded,
      // Reuse the Health artwork so medical categories stay visually unified.
      iconAsset: AppAssets.categoryHealth,
      iconColor: Color(0xFF247A45),
      iconBackgroundColor: Color(0xFFE5F1E8),
      isFeatured: true,
    ),
    CategoryModel(
      title: 'Automobiles',
      offersCount: 7,
      icon: Icons.directions_car_rounded,
      iconAsset: AppAssets.categoryAutomobiles,
      iconColor: Color(0xFF3578A8),
      iconBackgroundColor: Color(0xFFE8F1F7),
      isFeatured: true,
    ),
    CategoryModel(
      title: 'Fashion',
      offersCount: 18,
      icon: Icons.checkroom_rounded,
      iconAsset: AppAssets.categoryFashion,
      iconColor: Color(0xFFB0632B),
      iconBackgroundColor: Color(0xFFFBE9DD),
      isFeatured: true,
    ),
    CategoryModel(
      title: 'Education',
      offersCount: 18,
      icon: Icons.school_rounded,
      iconAsset: AppAssets.categoryEducation,
      iconColor: Color(0xFF1C4777),
      iconBackgroundColor: Color(0xFFD6E7F5),
      isFeatured: true,
    ),
    CategoryModel(
      title: 'Cinema',
      offersCount: 6,
      icon: Icons.movie_rounded,
      iconAsset: AppAssets.categoryCinema,
      iconColor: Color(0xFF96265A),
      iconBackgroundColor: Color(0xFFF7DDEA),
      isFeatured: true,
    ),
    CategoryModel(
      title: 'Entertainment',
      offersCount: 18,
      icon: Icons.movie_outlined,
      iconAsset: AppAssets.categoryEntertainment,
      iconColor: Color(0xFF96265A),
      iconBackgroundColor: Color(0xFFF7DDEA),
      isFeatured: true,
    ),
    CategoryModel(
      title: 'Services',
      offersCount: 18,
      icon: Icons.build_outlined,
      iconAsset: AppAssets.categoryServices,
      iconColor: Color(0xFF4F702E),
      iconBackgroundColor: Color(0xFFE4EFD9),
      isFeatured: true,
    ),
  ];

  void _toggleSearch() => setState(() => _isSearchOpen = !_isSearchOpen);

  @override
  Widget build(BuildContext context) {
    final bottomNavController = Get.find<BottomNavController>();

    return Scaffold(
      backgroundColor: AppColors.appBackroundColor,
      // The floating navigation is an overlay, so the page continues behind
      // it instead of stopping above a solid bottom-navigation background.
      extendBody: true,
      // The hero and page content share one scroll view. This keeps the
      // greeting, brand message, and mascot together while scrolling instead
      // of collapsing the header beneath the content.
      body: SingleChildScrollView(
        // Do not allow a pull-down bounce to reveal the scaffold background
        // above the hero header.
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            HomeHeroHeader(
              userName: 'Shafqat',
              profileImageUrl: 'https://i.pravatar.cc/150?img=12',
              date: DateTime.now(),
              isSearchOpen: _isSearchOpen,
              onSearchTap: _toggleSearch,
              onNotificationTap: () =>
                  Get.toNamed(AppRoutes.notificationScreen),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.pagePaddingSmall,
              ),
              child: Column(
                children: [
                  // --- Search field (only visible after tapping header icon) ---
                  AnimatedSize(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    alignment: Alignment.topCenter,
                    child: _isSearchOpen
                        ? Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppDimensions.spacingXLarge,
                            ),
                            child: CustomTextFormField(
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
                          )
                        : const SizedBox(width: double.infinity),
                  ),

                  // --- Promo carousel ---
                  PromoCarousel(
                    promos: _demoPromos,
                    onPromoTap: (promo) {
                      // navigate to deal details screen
                    },
                  ),
                  AppDimensions.verticalSpace40,

                  // --- Categories header ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText.headlineXSmall('Categories'),
                      InkWell(
                        child: AppText.bodySmall(
                          'See All',
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                        onTap: () {
                          Get.toNamed('/categoryScreen');
                        },
                      ),
                    ],
                  ),
                  AppDimensions.verticalSpace16,

                  // --- Categories grid ---
                  CategoriesGrid(
                    categories: _demoCategories,
                    // featuredOnly: true,
                    maxItems: 6,
                    onCategoryTap: (index, category) {
                      Get.toNamed('/categoryScreen', arguments: category.title);
                    },
                  ),
                  AppDimensions.verticalSpace24,

                  // --- Featured partners ---
                  FeaturedPartnersSection(
                    partners: const [
                      PartnerModel(
                        title: 'Suzuki Falcon Motors',
                        subtitle: 'Save on labour, lubricants & spare parts',
                        videoUrl: 'https://progtips.ru/wp-content/uploads/2020/09/car.mp4',
                        isFeatured: true,
                        coverImageUrl: 'https://images.unsplash.com/photo-1517524008697-84bbe3c3fd98?w=1200',
                        imageUrl: 'https://images.unsplash.com/photo-1517524008697-84bbe3c3fd98?w=800',
                        logoUrl: 'https://images.unsplash.com/photo-1517524008697-84bbe3c3fd98?w=400',
                        rating: 4.8,
                        reviewCount: 145,
                        address: 'Main University Road, Sargodha',
                        phoneNumber: '0300 8645000',
                        discountLabel: 'Up to 20% off',
                      ),
                      PartnerModel(
                        title: 'Service Tyres',
                        subtitle: 'jb tyre service jaisi to fiker kaisi',
                        videoUrl: 'https://amplifymtrs.com/wp-content/uploads/2024/01/car_driving_720p.mp4',
                        isFeatured: true,
                        coverImageUrl: 'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=1200',
                        imageUrl: 'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=800',
                        logoUrl: 'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=400',
                        rating: 4.7,
                        reviewCount: 98,
                        address:
                            'Bypass Road, Near General Bus Stand, Sargodha',
                        phoneNumber: '0301 7654321',
                        discountLabel: '15% off tyres & alignment',
                      ),
                    ],
                    onArrowTap: (partner) {
                      // e.g. analytics event: partner impression
                    },
                    onPartnerTap: (partner) {
                      Get.toNamed(
                        AppRoutes.discountExploreScreen,
                        arguments: BusinessModel.fromPartner(partner),
                      );
                    },
                  ),
                  AppDimensions.verticalSpace24,

                  // --- Popular discounts ---
                  PopularDiscountsSection(
                    discounts: [
                      BusinessModel(
                        name: "McDonald's",
                        location: 'Mall Road, Sargodha',
                        distanceKm: 1.2,
                        discountLabel: '15% off',
                        discountSubtitle: 'Burgers & Value Meals',
                        isOpenNow: true,
                        rating: 4.8,
                        reviewCount: 320,
                        coverImageUrl: 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=1200',
                        imageUrl: 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=800',
                        logoUrl: _mcdonaldsLogoUrl,
                        address: 'Mall Road, Sargodha',
                        phoneNumber: '0300 1116236',
                        dealsCount: 4,
                      ),
                      BusinessModel(
                        name: 'KFC',
                        location: 'Club Road, Sargodha',
                        distanceKm: 2.1,
                        discountLabel: '25% off',
                        discountSubtitle: 'Fried Chicken & Buckets',
                        isOpenNow: true,
                        rating: 4.7,
                        reviewCount: 280,
                        coverImageUrl: 'https://images.unsplash.com/photo-1513185158878-8d8c2a2a3da3?w=1200',
                        imageUrl: 'https://images.unsplash.com/photo-1513185158878-8d8c2a2a3da3?w=800',
                        logoUrl: _kfcLogoUrl,
                        address: 'Club Road, Sargodha',
                        phoneNumber: '0300 1115321',
                        dealsCount: 3,
                      ),
                      BusinessModel(
                        name: 'Pizza Hut',
                        location: 'Mall of Sargodha',
                        distanceKm: 1.8,
                        discountLabel: '20% off',
                        discountSubtitle: 'Pizzas & Garlic Bread',
                        isOpenNow: true,
                        rating: 4.6,
                        reviewCount: 195,
                        coverImageUrl: 'https://images.unsplash.com/photo-1579684947550-22e945225d9a?w=1200',
                        imageUrl: 'https://images.unsplash.com/photo-1579684947550-22e945225d9a?w=800',
                        logoUrl: _pizzaHutLogoUrl,
                        address: 'Mall of Sargodha, Sargodha',
                        phoneNumber: '0300 9998877',
                        dealsCount: 3,
                      ),
                      BusinessModel(
                        name: 'Tehzeeb Bakery',
                        location: 'University Road, Sargodha',
                        distanceKm: 2.5,
                        discountLabel: '15% off',
                        discountSubtitle: 'Cakes & Bakery Items',
                        isOpenNow: true,
                        rating: 4.9,
                        reviewCount: 340,
                        coverImageUrl: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=1200',
                        imageUrl: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800',
                        logoUrl: _tehzeebLogoUrl,
                        address: 'University Road, Sargodha',
                        phoneNumber: '0302 4443322',
                        dealsCount: 3,
                      ),
                      BusinessModel(
                        name: "Gloria Jean's Coffees",
                        location: 'Stadium Road, Sargodha',
                        distanceKm: 0.9,
                        discountLabel: '20% off',
                        discountSubtitle: 'Cold Brews & Desserts',
                        isOpenNow: true,
                        rating: 4.8,
                        reviewCount: 165,
                        coverImageUrl: 'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=1200',
                        imageUrl: 'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=800',
                        logoUrl: _gloriaJeansLogoUrl,
                        address: 'Stadium Road, Sargodha',
                        phoneNumber: '0304 5556677',
                        dealsCount: 3,
                      ),
                    ],
                    onDiscountTap: (business) {
                      Get.toNamed(
                        AppRoutes.discountExploreScreen,
                        arguments: business,
                      );
                    },
                    onSeeAllTap: () {
                      Get.toNamed(AppRoutes.allDiscountsScreen);
                    },
                  ),
                  // Keep the section separation consistent with Featured
                  // Partners → Popular Discounts.
                  AppDimensions.verticalSpace24,

                  // --- Trending deals ---
                  TrendingDealsSection(
                    deals: const [
                      DealModel(
                        imageUrl: 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=800',
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
                        imageUrl: 'https://images.unsplash.com/photo-1513185158878-8d8c2a2a3da3?w=800',
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
                        imageUrl: 'https://images.unsplash.com/photo-1579684947550-22e945225d9a?w=800',
                        badgeLabel: '20% off',
                        title: 'Pizza Hut',
                        subtitle: 'All pizzas & combos',
                        brandTag: 'PH',
                        currentPrice: '899',
                        originalPrice: '1200',
                        currency: 'Rs.',
                        showOnHome: true,
                        homePriority: 3,
                        brandColor: Colors.yellow,
                      ),
                      DealModel(
                        imageUrl: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800',
                        badgeLabel: '15% off',
                        title: 'Tehzeeb Bakery',
                        subtitle: 'Cakes & Pastries',
                        brandTag: 'Tehzeeb',
                        currentPrice: '499',
                        originalPrice: '600',
                        currency: 'Rs.',
                        showOnHome: true,
                        homePriority: 4,
                        brandColor: Colors.amber,
                      ),
                    ],
                    onDealTap: (deal) {
                      Get.toNamed(
                        AppRoutes.discountExploreScreen,
                        arguments: BusinessModel.fromDeal(deal),
                      );
                    },
                    onSeeAllTap: () {
                      Get.toNamed(AppRoutes.allDealsScreen);
                    },
                  ),
                  // AppDimensions.verticalSpace8,

                  // --- Subscribe ---
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppText.headlineXSmall('Subscribe Now'),
                  ),
                  AppDimensions.verticalSpace8,
                  SubscriptionPromoCard(
                    onExploreTap: () =>
                        Get.toNamed(AppRoutes.subscriptionScreen),
                  ),
                  AppDimensions.verticalSpace24,

                  // --- Near you ---
                  NearYouSection(
                    businesses: const [
                      BusinessModel(
                        name: "McDonald's Drive-Thru",
                        location: 'Mall Road, Sargodha',
                        distanceKm: 0.8,
                        rating: 4.8,
                        reviewCount: 320,
                        discountLabel: '15%',
                        discountSubtitle: 'off bill',
                        isFeatured: true,
                        coverImageUrl: 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=1200',
                        imageUrl: 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=800',
                        logoUrl: 'https://www.google.com/s2/favicons?sz=128&domain=mcdonalds.com',
                      ),
                      BusinessModel(
                        name: 'KFC Club Road',
                        location: 'Club Road, Sargodha',
                        distanceKm: 1.2,
                        rating: 4.7,
                        reviewCount: 280,
                        discountLabel: '20%',
                        discountSubtitle: 'off buckets',
                        isFeatured: true,
                        coverImageUrl: 'https://images.unsplash.com/photo-1513185158878-8d8c2a2a3da3?w=1200',
                        imageUrl: 'https://images.unsplash.com/photo-1513185158878-8d8c2a2a3da3?w=800',
                        logoUrl: 'https://www.google.com/s2/favicons?sz=128&domain=kfc.com',
                      ),
                      BusinessModel(
                        name: 'Pizza Hut Express',
                        location: 'Mall of Sargodha',
                        distanceKm: 1.5,
                        rating: 4.6,
                        reviewCount: 195,
                        discountLabel: '20%',
                        discountSubtitle: 'off total',
                        isFeatured: true,
                        coverImageUrl: 'https://images.unsplash.com/photo-1579684947550-22e945225d9a?w=1200',
                        imageUrl: 'https://images.unsplash.com/photo-1579684947550-22e945225d9a?w=800',
                        logoUrl: 'https://www.google.com/s2/favicons?sz=128&domain=pizzahut.com',
                      ),
                      BusinessModel(
                        name: 'Tehzeeb Bakery & Café',
                        location: 'University Road',
                        distanceKm: 2.1,
                        rating: 4.9,
                        reviewCount: 340,
                        discountLabel: '15%',
                        discountSubtitle: 'off bakery',
                        isFeatured: true,
                        coverImageUrl: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=1200',
                        imageUrl: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800',
                        logoUrl: 'https://www.google.com/s2/favicons?sz=128&domain=tehzeeb.com',
                      ),
                      BusinessModel(
                        name: "Gloria Jean's Coffees",
                        location: 'Stadium Road',
                        distanceKm: 2.8,
                        rating: 4.8,
                        reviewCount: 165,
                        discountLabel: '20%',
                        discountSubtitle: 'off coffee',
                        isFeatured: true,
                        coverImageUrl: 'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=1200',
                        imageUrl: 'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=800',
                        logoUrl: 'https://www.google.com/s2/favicons?sz=128&domain=gloriajeanscoffees.com',
                      ),
                    ],
                    onBusinessTap: (business) {
                      // navigate to business details
                    },
                    onMapTap: () {
                      // open map view
                    },
                  ),
                  AppDimensions.verticalSpace24,
                ],
              ),
            ),

            const SizedBox(height: 150),
          ],
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
