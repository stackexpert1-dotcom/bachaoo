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

    if (subCat.contains('restaurant')) {
      return const [
        BusinessModel(
          name: 'Royal Dine Restaurant',
          location: 'Sargodha · Club Road',
          distanceKm: 1.2,
          imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800',
          rating: 4.8,
          reviewCount: 124,
          discountLabel: '20%',
          discountSubtitle: 'off total bill',
        ),
        BusinessModel(
          name: 'Khabay Lounge & Grill',
          location: 'Sargodha · University Road',
          distanceKm: 2.5,
          imageUrl:
              'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800',
          rating: 4.6,
          reviewCount: 89,
          discountLabel: '15%',
          discountSubtitle: 'off food bill',
        ),
        BusinessModel(
          name: 'Spice Garden Fine Dining',
          location: 'Sargodha · Satellite Town',
          distanceKm: 3.1,
          imageUrl:
              'https://images.unsplash.com/photo-1544025162-d76694265947?w=800',
          rating: 4.9,
          reviewCount: 210,
          discountLabel: '25%',
          discountSubtitle: 'off buffet',
        ),
        BusinessModel(
          name: 'Al-Haaj Boti & BBQ',
          location: 'Sargodha · Fatima Jinnah Road',
          distanceKm: 0.8,
          imageUrl: 'https://images.unsplash.com/photo-1529193591184-b1d58069ecdd?w=800',
          rating: 4.5,
          reviewCount: 64,
          discountLabel: '10%',
          discountSubtitle: 'off total bill',
        ),
      ];
    } else if (subCat.contains('café') ||
        subCat.contains('cafe') ||
        subCat.contains('coffee')) {
      return const [
        BusinessModel(
          name: "Gloria Jean's Coffees",
          location: 'Sargodha · Mall of Sargodha',
          distanceKm: 0.5,
          imageUrl: 'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=800',
          rating: 4.7,
          reviewCount: 156,
          discountLabel: '15%',
          discountSubtitle: 'off coffee & snacks',
        ),
        BusinessModel(
          name: 'Espresso Bar & Bakery',
          location: 'Sargodha · Stadium Road',
          distanceKm: 1.8,
          imageUrl: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800',
          rating: 4.6,
          reviewCount: 92,
          discountLabel: '20%',
          discountSubtitle: 'off bakery items',
        ),
        BusinessModel(
          name: 'Tehzeeb Café & Lounge',
          location: 'Sargodha · University Road',
          distanceKm: 2.2,
          imageUrl: 'https://images.unsplash.com/photo-1442512595331-e89e73853f31?w=800',
          rating: 4.5,
          reviewCount: 48,
          discountLabel: '10%',
          discountSubtitle: 'off beverages',
        ),
        BusinessModel(
          name: 'The Coffee Bean & Tea Leaf',
          location: 'Sargodha · Model Town',
          distanceKm: 3.0,
          imageUrl: 'https://images.unsplash.com/photo-1497636577773-f1231844b336?w=800',
          rating: 4.8,
          reviewCount: 180,
          discountLabel: '15%',
          discountSubtitle: 'off hot drinks',
        ),
      ];
    } else if (subCat.contains('fast food') || subCat.contains('burger')) {
      return const [
        BusinessModel(
          name: "McDonald's",
          location: 'Sargodha · Mall Road',
          distanceKm: 0.4,
          imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800',
          rating: 4.7,
          reviewCount: 320,
          discountLabel: '15%',
          discountSubtitle: 'off every meal',
        ),
        BusinessModel(
          name: 'KFC',
          location: 'Sargodha · Club Road',
          distanceKm: 1.1,
          imageUrl: 'https://images.unsplash.com/photo-1513185158878-8d8c2a2a3da3?w=800',
          rating: 4.6,
          reviewCount: 240,
          discountLabel: 'BOGO',
          discountSubtitle: 'Buy 1 Get 1 Free',
        ),
        BusinessModel(
          name: 'Cheezious',
          location: 'Sargodha · Satellite Town',
          distanceKm: 1.5,
          imageUrl: 'https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?w=800',
          rating: 4.9,
          reviewCount: 410,
          discountLabel: '20%',
          discountSubtitle: 'off large pizza',
        ),
      ];
    } else if (subCat.contains('ice cream') || subCat.contains('shake')) {
      return const [
        BusinessModel(
          name: 'Baskin Robbins',
          location: 'Sargodha · Mall of Sargodha',
          distanceKm: 1.0,
          imageUrl:
              'https://images.unsplash.com/photo-1563805042-7684c019e11b?w=800',
          rating: 4.8,
          reviewCount: 140,
          discountLabel: '15%',
          discountSubtitle: 'off scoops',
        ),
        BusinessModel(
          name: 'Soft Swirl & Shakes',
          location: 'Sargodha · University Road',
          distanceKm: 1.6,
          imageUrl: 'https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=800',
          rating: 4.6,
          reviewCount: 85,
          discountLabel: '20%',
          discountSubtitle: 'off thickshakes',
        ),
      ];
    } else if (subCat.contains('grocer') ||
        subCat.contains('supermarket') ||
        subCat.contains('produce')) {
      return const [
        BusinessModel(
          name: 'Imtiaz Super Market',
          location: 'Sargodha · Bypass Road',
          distanceKm: 1.4,
          imageUrl:
              'https://images.unsplash.com/photo-1542838132-92c53300491e?w=800',
          rating: 4.8,
          reviewCount: 520,
          discountLabel: '15%',
          discountSubtitle: 'off fresh items',
        ),
        BusinessModel(
          name: 'Metro Cash & Carry',
          location: 'Sargodha · Main Highway',
          distanceKm: 2.1,
          imageUrl: 'https://images.unsplash.com/photo-1610832958506-aa56368176cf?w=800',
          rating: 4.7,
          reviewCount: 310,
          discountLabel: '10%',
          discountSubtitle: 'off total bill',
        ),
      ];
    } else {
      return [
        BusinessModel(
          name: '${widget.subCategoryName} Hub',
          location: 'Sargodha · Central Market',
          distanceKm: 1.0,
          imageUrl: 'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=800',
          rating: 4.7,
          reviewCount: 95,
          discountLabel: '15%',
          discountSubtitle: 'exclusive deal',
        ),
        BusinessModel(
          name: 'Elite ${widget.subCategoryName}',
          location: 'Sargodha · Model Town',
          distanceKm: 2.3,
          imageUrl: 'https://images.unsplash.com/photo-1497366216548-37526070297c?w=800',
          rating: 4.5,
          reviewCount: 42,
          discountLabel: '20%',
          discountSubtitle: 'off services',
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
