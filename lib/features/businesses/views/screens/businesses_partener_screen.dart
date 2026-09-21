import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/common_widgets/filter_chip_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/businesses/models/nearby_business_model.dart';
import 'package:bachaoo/features/businesses/views/widgets/business_card.dart';
import 'package:bachaoo/routes/bachaoo_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessPartenerScreen extends StatefulWidget {
  final String subCategoryName;
  const BusinessPartenerScreen({super.key, required this.subCategoryName});

  @override
  State<BusinessPartenerScreen> createState() => _BusinessPartenerScreenState();
}

class _BusinessPartenerScreenState extends State<BusinessPartenerScreen> {
  String _selectedFilter = 'All';
  final List<String> _filterOptions = const [
    'All',
    'Nearest',
    'Top Rated',
    'Biggest Savings',
  ];

  List<BusinessModel> _getBusinessesForSubCategory() {
    // The list cards only carry the compact fields, so fill in the
    // detail-screen fields (cover, logo, phone, deals, open status) before
    // they are pushed to the explore screen.
    return _getBaseBusinessesForSubCategory()
        .map(BusinessModel.forDetailDemo)
        .toList();
  }

  List<BusinessModel> _getBaseBusinessesForSubCategory() {
    final subCat = widget.subCategoryName.toLowerCase();

    if (subCat.contains('restaurant') || subCat.contains('food')) {
      return const [
        BusinessModel(
          name: "McDonald's Drive-Thru",
          location: 'Sargodha · Mall Road',
          address: 'Mall Road, Near Club Chowk, Sargodha',
          distanceKm: 0.4,
          imageUrl: 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=800',
          coverImageUrl: 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=1200',
          logoUrl: 'https://www.google.com/s2/favicons?sz=128&domain=mcdonalds.com',
          rating: 4.8,
          reviewCount: 320,
          discountLabel: '15%',
          discountSubtitle: 'off every meal',
          phoneNumber: '0300 1116236',
          isOpenNow: true,
        ),
        BusinessModel(
          name: 'KFC',
          location: 'Sargodha · Club Road',
          address: 'Main Club Road, Sargodha',
          distanceKm: 1.1,
          imageUrl: 'https://images.unsplash.com/photo-1513185158878-8d8c2a2a3da3?w=800',
          coverImageUrl: 'https://images.unsplash.com/photo-1513185158878-8d8c2a2a3da3?w=1200',
          logoUrl: 'https://www.google.com/s2/favicons?sz=128&domain=kfc.com',
          rating: 4.7,
          reviewCount: 280,
          discountLabel: '25%',
          discountSubtitle: 'off buckets & deals',
          phoneNumber: '0300 1115321',
          isOpenNow: true,
        ),
        BusinessModel(
          name: 'Pizza Hut',
          location: 'Sargodha · Mall of Sargodha',
          address: 'Food Court, Mall of Sargodha',
          distanceKm: 1.8,
          imageUrl: 'https://images.unsplash.com/photo-1579684947550-22e945225d9a?w=800',
          coverImageUrl: 'https://images.unsplash.com/photo-1579684947550-22e945225d9a?w=1200',
          logoUrl: 'https://www.google.com/s2/favicons?sz=128&domain=pizzahut.com',
          rating: 4.6,
          reviewCount: 195,
          discountLabel: '20%',
          discountSubtitle: 'off all pizzas',
          phoneNumber: '0300 9998877',
          isOpenNow: true,
        ),
        BusinessModel(
          name: 'Royal Dine Restaurant',
          location: 'Sargodha · Club Road',
          address: 'Opposite Officers Club, Sargodha',
          distanceKm: 1.2,
          imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800',
          coverImageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=1200',
          logoUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400',
          rating: 4.8,
          reviewCount: 124,
          discountLabel: '20%',
          discountSubtitle: 'off total bill',
          phoneNumber: '0300 5544332',
          isOpenNow: true,
        ),
        BusinessModel(
          name: 'Khabay Lounge & Grill',
          location: 'Sargodha · University Road',
          address: 'University Road, Sargodha',
          distanceKm: 2.5,
          imageUrl: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800',
          coverImageUrl: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=1200',
          logoUrl: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=400',
          rating: 4.6,
          reviewCount: 89,
          discountLabel: '15%',
          discountSubtitle: 'off food bill',
          phoneNumber: '0302 7788990',
          isOpenNow: true,
        ),
      ];
    } else if (subCat.contains('café') ||
        subCat.contains('cafe') ||
        subCat.contains('coffee')) {
      return const [
        BusinessModel(
          name: "Gloria Jean's Coffees",
          location: 'Sargodha · Mall of Sargodha',
          address: 'Ground Floor, Mall of Sargodha',
          distanceKm: 0.5,
          imageUrl: 'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=800',
          coverImageUrl: 'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=1200',
          logoUrl: 'https://www.google.com/s2/favicons?sz=128&domain=gloriajeanscoffees.com',
          rating: 4.8,
          reviewCount: 165,
          discountLabel: '20%',
          discountSubtitle: 'off cold brews',
          phoneNumber: '0304 5556677',
          isOpenNow: true,
        ),
        BusinessModel(
          name: 'Tehzeeb Bakery & Café',
          location: 'Sargodha · University Road',
          address: 'University Road, Sargodha',
          distanceKm: 2.2,
          imageUrl: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800',
          coverImageUrl: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=1200',
          logoUrl: 'https://www.google.com/s2/favicons?sz=128&domain=tehzeeb.com',
          rating: 4.9,
          reviewCount: 340,
          discountLabel: '15%',
          discountSubtitle: 'off bakery & beverages',
          phoneNumber: '0302 4443322',
          isOpenNow: true,
        ),
        BusinessModel(
          name: 'Espresso Bar & Bakery',
          location: 'Sargodha · Stadium Road',
          address: 'Stadium Road, Sargodha',
          distanceKm: 1.8,
          imageUrl: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800',
          coverImageUrl: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=1200',
          logoUrl: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400',
          rating: 4.6,
          reviewCount: 92,
          discountLabel: '20%',
          discountSubtitle: 'off bakery items',
          phoneNumber: '0301 3344556',
          isOpenNow: true,
        ),
        BusinessModel(
          name: 'The Coffee Bean & Tea Leaf',
          location: 'Sargodha · Model Town',
          address: 'Main Commercial Area, Model Town',
          distanceKm: 3.0,
          imageUrl: 'https://images.unsplash.com/photo-1497636577773-f1231844b336?w=800',
          coverImageUrl: 'https://images.unsplash.com/photo-1497636577773-f1231844b336?w=1200',
          logoUrl: 'https://images.unsplash.com/photo-1497636577773-f1231844b336?w=400',
          rating: 4.8,
          reviewCount: 180,
          discountLabel: '15%',
          discountSubtitle: 'off hot drinks',
          phoneNumber: '0303 6677889',
          isOpenNow: true,
        ),
        BusinessModel(
          name: 'Roasters Coffee House',
          location: 'Sargodha · Satellite Town',
          address: 'Block B, Satellite Town, Sargodha',
          distanceKm: 2.1,
          imageUrl: 'https://images.unsplash.com/photo-1442512595331-e89e73853f31?w=800',
          coverImageUrl: 'https://images.unsplash.com/photo-1442512595331-e89e73853f31?w=1200',
          logoUrl: 'https://images.unsplash.com/photo-1442512595331-e89e73853f31?w=400',
          rating: 4.7,
          reviewCount: 110,
          discountLabel: '10%',
          discountSubtitle: 'off total bill',
          phoneNumber: '0305 1122334',
          isOpenNow: true,
        ),
      ];
    } else {
      return const [
        BusinessModel(
          name: "McDonald's Drive-Thru",
          location: 'Sargodha · Mall Road',
          address: 'Mall Road, Sargodha',
          distanceKm: 0.4,
          imageUrl: 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=800',
          coverImageUrl: 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=1200',
          logoUrl: 'https://www.google.com/s2/favicons?sz=128&domain=mcdonalds.com',
          rating: 4.8,
          reviewCount: 320,
          discountLabel: '15%',
          discountSubtitle: 'off bill',
          phoneNumber: '0300 1116236',
          isOpenNow: true,
        ),
        BusinessModel(
          name: 'KFC',
          location: 'Sargodha · Club Road',
          address: 'Club Road, Sargodha',
          distanceKm: 1.1,
          imageUrl: 'https://images.unsplash.com/photo-1513185158878-8d8c2a2a3da3?w=800',
          coverImageUrl: 'https://images.unsplash.com/photo-1513185158878-8d8c2a2a3da3?w=1200',
          logoUrl: 'https://www.google.com/s2/favicons?sz=128&domain=kfc.com',
          rating: 4.7,
          reviewCount: 280,
          discountLabel: '20%',
          discountSubtitle: 'off buckets',
          phoneNumber: '0300 1115321',
          isOpenNow: true,
        ),
        BusinessModel(
          name: 'Pizza Hut',
          location: 'Sargodha · Mall of Sargodha',
          address: 'Mall of Sargodha',
          distanceKm: 1.8,
          imageUrl: 'https://images.unsplash.com/photo-1579684947550-22e945225d9a?w=800',
          coverImageUrl: 'https://images.unsplash.com/photo-1579684947550-22e945225d9a?w=1200',
          logoUrl: 'https://www.google.com/s2/favicons?sz=128&domain=pizzahut.com',
          rating: 4.6,
          reviewCount: 195,
          discountLabel: '20%',
          discountSubtitle: 'off pizzas',
          phoneNumber: '0300 9998877',
          isOpenNow: true,
        ),
        BusinessModel(
          name: 'Suzuki Falcon Motors',
          location: 'Sargodha · University Road',
          address: 'Main University Road, Sargodha',
          distanceKm: 2.2,
          imageUrl: 'https://images.unsplash.com/photo-1517524008697-84bbe3c3fd98?w=800',
          coverImageUrl: 'https://images.unsplash.com/photo-1517524008697-84bbe3c3fd98?w=1200',
          logoUrl: 'https://images.unsplash.com/photo-1517524008697-84bbe3c3fd98?w=400',
          rating: 4.8,
          reviewCount: 145,
          discountLabel: '20%',
          discountSubtitle: 'off service',
          phoneNumber: '0300 8645000',
          isOpenNow: true,
        ),
        BusinessModel(
          name: 'Service Tyres',
          location: 'Sargodha · Bypass Road',
          address: 'Bypass Road, Sargodha',
          distanceKm: 2.8,
          imageUrl: 'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=800',
          coverImageUrl: 'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=1200',
          logoUrl: 'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=400',
          rating: 4.7,
          reviewCount: 98,
          discountLabel: '15%',
          discountSubtitle: 'off tyres',
          phoneNumber: '0301 7654321',
          isOpenNow: true,
        ),
      ];
    }
  }

  List<BusinessModel> _getFilteredBusinesses(List<BusinessModel> list) {
    final copy = List<BusinessModel>.from(list);
    switch (_selectedFilter) {
      case 'Nearest':
        copy.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
        return copy;
      case 'Top Rated':
        copy.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
        return copy;
      case 'Biggest Savings':
        copy.sort((a, b) {
          final int aDisc =
              int.tryParse(a.discountLabel.replaceAll(RegExp(r'[^0-9]'), '')) ??
              0;
          final int bDisc =
              int.tryParse(b.discountLabel.replaceAll(RegExp(r'[^0-9]'), '')) ??
              0;
          return bDisc.compareTo(aDisc);
        });
        return copy;
      default:
        return copy;
    }
  }

  @override
  Widget build(BuildContext context) {
    final rawBusinesses = _getBusinessesForSubCategory();
    final displayedBusinesses = _getFilteredBusinesses(rawBusinesses);

    return Scaffold(
      backgroundColor: AppColors.appBackroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.pagePaddingSmall,
            vertical: AppDimensions.pagePaddingSmall,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CustomBackButton(),
                  const SizedBox(width: AppDimensions.spacingMedium),
                  AppText.headlineSmall(widget.subCategoryName),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingXSmall,
                      vertical: AppDimensions.paddingXXSmall,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusXXSmall,
                      ),
                    ),
                    child: AppText.bodyXSmall(
                      '${displayedBusinesses.length} Partners',
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              AppDimensions.verticalSpace16,
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filterOptions.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final filter = _filterOptions[index];
                    return FilterChipButton(
                      label: filter,
                      isSelected: _selectedFilter == filter,
                      onTap: () => setState(() => _selectedFilter = filter),
                    );
                  },
                ),
              ),
              AppDimensions.verticalSpace20,
              Expanded(
                child: ListView.separated(
                  itemCount: displayedBusinesses.length,
                  separatorBuilder: (context, index) =>
                      AppDimensions.verticalSpace12,
                  itemBuilder: (context, index) {
                    final business = displayedBusinesses[index];
                    return NearbyBusinessCard(
                      business: business,
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.discountExploreScreen,
                          arguments: business,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
