import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/features/category/models/sub_category_model.dart';
import 'package:bachaoo/features/category/views/widgets/category_detail_header.dart';
import 'package:bachaoo/features/category/views/widgets/sub_category_card.dart';
import 'package:bachaoo/features/home/views/widgets/category_grid.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:bachaoo/features/category/models/category_model.dart';
import 'package:bachaoo/common_widgets/filter_chip_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/routes/bachaoo_routes.dart';
import 'package:bachaoo/common_widgets/app_text.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // Demo categories (same as HomeScreen)
  final List<CategoryModel> _demoCategories = [
    CategoryModel(
      title: 'Food',
      offersCount: 46,
      icon: Icons.lunch_dining_rounded,
      iconColor: const Color(0xFFB33A2E),
      iconBackgroundColor: const Color(0xFFFBE2DE),
      isFeatured: true,
    ),
    CategoryModel(
      title: 'Supermarket',
      offersCount: 12,
      icon: Icons.shopping_cart_rounded,
      iconColor: const Color(0xFF9A6A12),
      iconBackgroundColor: const Color(0xFFFAF2DE),
      isFeatured: true,
    ),
    CategoryModel(
      title: 'Beauty & care',
      offersCount: 9,
      faIcon: const FaIcon(FontAwesomeIcons.paintbrush),
      iconColor: const Color(0xFF6B4FA0),
      iconBackgroundColor: const Color(0xFFE9E2F7),
      isFeatured: true,
    ),
    CategoryModel(
      title: 'Health',
      offersCount: 14,
      faIcon: const FaIcon(FontAwesomeIcons.heartPulse),
      iconColor: const Color(0xFF247A45),
      iconBackgroundColor: const Color(0xFFE5F1E8),
      isFeatured: true,
    ),
    CategoryModel(
      title: 'Automobiles',
      offersCount: 7,
      icon: Icons.directions_car_rounded,
      iconColor: const Color(0xFF3578A8),
      iconBackgroundColor: const Color(0xFFE8F1F7),
      isFeatured: true,
    ),
    CategoryModel(
      title: 'Fashion',
      offersCount: 18,
      icon: Icons.checkroom_rounded,
      iconColor: const Color(0xFFB0632B),
      iconBackgroundColor: const Color(0xFFFBE9DD),
      isFeatured: true,
    ),
    CategoryModel(
      title: 'Education',
      offersCount: 18,
      icon: Icons.school_outlined,
      iconColor: Color(0xFF1C4777),
      iconBackgroundColor: Color(0xFFD6E7F5),
      isFeatured: false,
    ),
    CategoryModel(
      title: 'Entertainment',
      offersCount: 18,
      icon: Icons.movie_outlined,
      iconColor: Color(0xFF96265A),
      iconBackgroundColor: Color(0xFFF7DDEA),
      isFeatured: false,
    ),
    CategoryModel(
      title: 'Services',
      offersCount: 18,
      icon: Icons.build_outlined,
      iconColor: Color(0xFF4F702E),
      iconBackgroundColor: Color(0xFFE4EFD9),
      isFeatured: false,
    ),
  ];

  final ScrollController _chipScrollController = ScrollController();
  late final List<GlobalKey> _chipKeys = List.generate(
    _demoCategories.length,
    (_) => GlobalKey(),
  );
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    final arg = Get.arguments;
    if (arg is int && arg >= 0 && arg < _demoCategories.length) {
      _selectedIndex = arg;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToChip(_selectedIndex);
    });
  }

  @override
  void dispose() {
    _chipScrollController.dispose();
    super.dispose();
  }

  void _scrollToChip(int index) {
    if (index < 0 || index >= _chipKeys.length) return;
    final keyContext = _chipKeys[index].currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.5,
      );
    }
  }

  void _selectCategory(int index) {
    if (index >= 0 && index < _demoCategories.length) {
      setState(() {
        _selectedIndex = index;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToChip(index);
      });
    }
  }

  // Returns subcategories based on selected category
  List<SubCategoryModel> _subCategoriesForSelected() {
    switch (_demoCategories[_selectedIndex].title) {
      case 'Food':
        return [
          SubCategoryModel(
            title: 'Restaurants',
            subtitle: 'Dine-in deals at local restaurants',
            dealsCount: 9,
            imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800',
            onTap: () {
              Get.toNamed('/businessesPartnerScreen', arguments: 'Restaurants');
            },
          ),
          const SubCategoryModel(
            title: 'Fast food',
            subtitle: 'Burgers, fries, pizza and quick meals',
            dealsCount: 28,
            imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800',
          ),
          const SubCategoryModel(
            title: 'Cafés',
            subtitle: 'Coffee and snacks',
            dealsCount: 5,
            imageUrl: 'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=800',
          ),
          const SubCategoryModel(
            title: 'Ice cream & shakes',
            subtitle: 'Desserts and shakes',
            dealsCount: 4,
            imageUrl: 'https://images.unsplash.com/photo-1563805042-7684c019e11b?w=800',
          ),
        ];

      case 'Supermarket':
        return const [
          SubCategoryModel(
            title: 'Groceries',
            subtitle: 'Pantry staples and everyday essentials',
            dealsCount: 5,
            imageUrl: 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=800',
          ),
          SubCategoryModel(
            title: 'Fresh produce',
            subtitle: 'Fruits, vegetables and dairy',
            dealsCount: 3,
            imageUrl: 'https://images.unsplash.com/photo-1610832958506-aa56368176cf?w=800',
          ),
          SubCategoryModel(
            title: 'Household items',
            subtitle: 'Cleaning supplies and home essentials',
            dealsCount: 2,
            imageUrl: 'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?w=800',
          ),
          SubCategoryModel(
            title: 'Beverages',
            subtitle: 'Drinks, juices and soft drinks',
            dealsCount: 2,
            imageUrl: 'https://images.unsplash.com/photo-1544145945-f90425340c7e?w=800',
          ),
        ];

      case 'Beauty & care':
        return const [
          SubCategoryModel(
            title: 'Salons & Parlors',
            subtitle: 'Haircuts, styling and grooming',
            dealsCount: 5,
            imageUrl: 'https://images.unsplash.com/photo-1560066984-138dadb4c035?w=800',
          ),
          SubCategoryModel(
            title: 'Spa & Massage',
            subtitle: 'Relaxation and wellness therapies',
            dealsCount: 4,
            imageUrl: 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=800',
          ),
        ];

      case 'Health':
        return const [
          SubCategoryModel(
            title: 'Clinics & Labs',
            subtitle: 'Doctor consultations & lab tests',
            dealsCount: 8,
            imageUrl: 'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=800',
          ),
          SubCategoryModel(
            title: 'Pharmacies',
            subtitle: 'Medicines and health supplements',
            dealsCount: 6,
            imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=800',
          ),
        ];

      case 'Automobiles':
        return const [
          SubCategoryModel(
            title: 'Auto Parts & Tyres',
            subtitle: 'Spare parts and tyre services',
            dealsCount: 4,
            imageUrl: 'https://images.unsplash.com/photo-1486006920555-c77dce18193b?w=800',
          ),
          SubCategoryModel(
            title: 'Car Wash & Care',
            subtitle: 'Detailing, tuning and oil change',
            dealsCount: 3,
            imageUrl: 'https://images.unsplash.com/photo-1520340356584-f9917d1eea6f?w=800',
          ),
        ];

      case 'Fashion':
        return const [
          SubCategoryModel(
            title: 'Men\'s Fashion',
            subtitle: 'Shirts, trousers and casual wear',
            dealsCount: 10,
            imageUrl: 'https://images.unsplash.com/photo-1490578474895-699cd4e2cf59?w=800',
          ),
          SubCategoryModel(
            title: 'Women\'s Fashion',
            subtitle: 'Dresses, apparel and accessories',
            dealsCount: 8,
            imageUrl: 'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=800',
          ),
        ];

      case 'Education':
        return const [
          SubCategoryModel(
            title: 'Courses & Classes',
            subtitle: 'Online & offline learning courses',
            dealsCount: 6,
            imageUrl: 'https://images.unsplash.com/photo-1523240795612-9a054b0db644?w=800',
          ),
          SubCategoryModel(
            title: 'Tuition & Coaching',
            subtitle: 'Academy & private tutoring discounts',
            dealsCount: 4,
            imageUrl: 'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=800',
          ),
          SubCategoryModel(
            title: 'Books & Supplies',
            subtitle: 'Textbooks, stationery & academic tools',
            dealsCount: 8,
            imageUrl: 'https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?w=800',
          ),
        ];

      case 'Entertainment':
        return const [
          SubCategoryModel(
            title: 'Cinema & Movies',
            subtitle: 'Movie tickets and theatre deals',
            dealsCount: 7,
            imageUrl: 'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=800',
          ),
          SubCategoryModel(
            title: 'Gaming & Arcades',
            subtitle: 'Bowling, VR games and play zones',
            dealsCount: 5,
            imageUrl: 'https://images.unsplash.com/photo-1511512578047-dfb367046420?w=800',
          ),
          SubCategoryModel(
            title: 'Events & Shows',
            subtitle: 'Live concerts, comedy & events',
            dealsCount: 6,
            imageUrl: 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=800',
          ),
        ];

      case 'Services':
        return const [
          SubCategoryModel(
            title: 'Home Maintenance',
            subtitle: 'Plumbing, electrical & carpentry',
            dealsCount: 5,
            imageUrl: 'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=800',
          ),
          SubCategoryModel(
            title: 'Cleaning Services',
            subtitle: 'Home & office deep cleaning',
            dealsCount: 4,
            imageUrl: 'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=800',
          ),
          SubCategoryModel(
            title: 'Vehicle Servicing',
            subtitle: 'Auto repair, wash & maintenance',
            dealsCount: 9,
            imageUrl: 'https://images.unsplash.com/photo-1520340356584-f9917d1eea6f?w=800',
          ),
        ];

      default:
        return const [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
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
                    CustomBackButton(),
                    const SizedBox(width: AppDimensions.spacingMedium),
                    AppText.headlineMedium('Category'),
                  ],
                ),
                AppDimensions.verticalSpace20,
                SizedBox(
                  height: 44,
                  child: ListView.separated(
                    controller: _chipScrollController,
                    // ignore: deprecated_member_use
                    cacheExtent: 2000.0,
                    scrollDirection: Axis.horizontal,
                    itemCount: _demoCategories.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final category = _demoCategories[index];
                      return KeyedSubtree(
                        key: _chipKeys[index],
                        child: FilterChipButton(
                          label: category.title,
                          isSelected: _selectedIndex == index,
                          onTap: () => _selectCategory(index),
                        ),
                      );
                    },
                  ),
                ),
                AppDimensions.verticalSpace20,
                CategoryDetailHeader(
                  categoryTitle: _demoCategories[_selectedIndex].title,
                  totalDeals: _demoCategories[_selectedIndex].offersCount,
                ),
                AppDimensions.verticalSpace16,
                SubCategoriesCard(
                  subCategories: _subCategoriesForSelected(),
                  onSubCategoryTap: (subCategory) {
                    Get.toNamed(
                      AppRoutes.businessesPartnerScreen,
                      arguments: subCategory.title,
                    );
                  },
                ),
                AppDimensions.verticalSpace20,
                AppText.headlineXSmall('More Categories'),
                AppDimensions.verticalSpace16,
                Builder(
                  builder: (context) {
                    final extraCategories = _demoCategories
                        .where((c) => !c.isFeatured)
                        .toList();
                    return CategoriesGrid(
                      categories: extraCategories,
                      featuredOnly: false,
                      onCategoryTap: (idx, category) {
                        final realIndex = _demoCategories.indexOf(category);
                        if (realIndex != -1) {
                          _selectCategory(realIndex);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
