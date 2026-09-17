import 'package:bachaoo/common_widgets/primary_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/cart/views/widgets/business_code_card.dart';
import 'package:bachaoo/features/cart/views/widgets/cart_header_widget.dart';
import 'package:bachaoo/features/cart/views/widgets/cart_item_card.dart';
import 'package:bachaoo/features/cart/views/widgets/cart_summary_card.dart';
import 'package:bachaoo/features/deals/models/deal_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bachaoo/routes/bachaoo_routes.dart';

class CartItem {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String currentPrice;
  final String originalPrice;
  int quantity;

  CartItem({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.currentPrice,
    required this.originalPrice,
    this.quantity = 1,
  });
}

class CartScreen extends StatefulWidget {
  final String vendorName;
  final String vendorLocation;
  final DealDetailModel? deal;
  final int initialQuantity;

  const CartScreen({
    super.key,
    required this.vendorName,
    required this.vendorLocation,
    this.deal,
    this.initialQuantity = 1,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final List<CartItem> _items;

  @override
  void initState() {
    super.initState();
    final deal = widget.deal;
    if (deal == null) {
      // Fallback demo item used when the cart is opened without a deal
      // (e.g. directly from the tab bar / deep link).
      _items = [
        CartItem(
          imageUrl: 'https://example.com/deal1.jpg',
          title: 'Bachaoo Deal 1',
          subtitle: 'Rice, 2 tikka, drink',
          currentPrice: '333',
          originalPrice: '483',
        ),
      ];
    } else {
      // The deal tapped "Add to cart" on — e.g. "Bachaoo Deal 1" — with the
      // quantity that was selected on the deal screen.
      _items = [
        CartItem(
          imageUrl: deal.imageUrl ?? 'https://example.com/deal1.jpg',
          title: deal.title,
          subtitle: deal.includedItems.take(3).join(', '),
          currentPrice: deal.price.toStringAsFixed(0),
          originalPrice: deal.originalPrice.toStringAsFixed(0),
          quantity: widget.initialQuantity,
        ),
      ];
    }
  }

  int get _subtotal => _items.fold(
    0,
    (sum, item) => sum + (int.parse(item.originalPrice) * item.quantity),
  );

  int get _total => _items.fold(
    0,
    (sum, item) => sum + (int.parse(item.currentPrice) * item.quantity),
  );

  int get _savings => _subtotal - _total;

  void _clearCart() {
    setState(() => _items.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.pagePadding,
                AppDimensions.spacingSmall,
                AppDimensions.pagePadding,
                0,
              ),
              child: CartHeaderWidget(
                onBack: () => Navigator.of(context).maybePop(),
                onClear: _clearCart,
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppDimensions.pagePadding,
                  AppDimensions.spacingLarge,
                  AppDimensions.pagePadding,
                  AppDimensions.spacingXLarge,
                ),
                children: [
                  Text(
                    '${widget.vendorName} \u00b7 ${widget.vendorLocation}',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: AppDimensions.fontSizeBodyMedium,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacingMedium),
                  ..._items.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index == _items.length - 1
                            ? 0
                            : AppDimensions.spacingXXSmall,
                      ),
                      child: CartItemCard(
                        imageUrl: item.imageUrl,
                        title: item.title,
                        subtitle: item.subtitle,
                        currentPrice: item.currentPrice,
                        originalPrice: item.originalPrice,
                        quantity: item.quantity,
                        onQuantityChanged: (v) {
                          setState(() => item.quantity = v);
                        },
                      ),
                    );
                  }),
                  const SizedBox(height: AppDimensions.spacingMedium),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Get.toNamed(AppRoutes.discountExploreScreen);
                      },
                      icon: const Icon(Icons.add_circle_outline_rounded, size: 20),
                      label: const Text(
                        'Add more deals',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryColor,
                        side: const BorderSide(color: AppColors.primaryColor),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacingLarge),
                  CartSummaryCard(
                    dealCount: _items.length,
                    subtotal: _subtotal.toString(),
                    savings: _savings.toString(),
                    total: _total.toString(),
                  ),
                  const SizedBox(height: AppDimensions.spacingLarge),
                  BusinessCodeCard(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.pagePadding,
                AppDimensions.spacingSmall,
                AppDimensions.pagePadding,
                AppDimensions.spacingMedium,
              ),
              child: PrimaryButton(
                label: 'Confirm and pay Rs $_total',
                backgroundColor: AppColors.secondaryColor,
                textColor: AppColors.primaryColor,
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
