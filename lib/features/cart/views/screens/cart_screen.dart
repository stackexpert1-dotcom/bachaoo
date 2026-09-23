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

import 'package:bachaoo/features/cart/controllers/cart_controller.dart';
import 'package:bachaoo/features/cart/models/cart_item_model.dart';

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
  late final CartController _cartController;

  @override
  void initState() {
    super.initState();
    _cartController = Get.find<CartController>();

    // Only initialize with a deal if the cart is empty and a deal was passed.
    final deal = widget.deal;
    if (deal != null && _cartController.items.isEmpty) {
      _cartController.addItem(
        CartItemModel(
          imageUrl: deal.imageUrl ?? 'https://example.com/deal1.jpg',
          title: deal.title,
          subtitle: deal.includedItems.take(3).join(', '),
          currentPrice: deal.price.toStringAsFixed(0),
          originalPrice: deal.originalPrice.toStringAsFixed(0),
          quantity: widget.initialQuantity,
        ),
      );
    } else if (_cartController.items.isEmpty) {
      // Fallback demo item used when the cart is opened without a deal
      // (e.g. directly from the tab bar / deep link).
      _cartController.addItem(
        CartItemModel(
          imageUrl: 'https://example.com/deal1.jpg',
          title: 'Bachaoo Deal 1',
          subtitle: 'Rice, 2 tikka, drink',
          currentPrice: '333',
          originalPrice: '483',
        ),
      );
    }
  }

  void _clearCart() {
    _cartController.clearCart();
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
                  Obx(
                    () => Column(
                      children: [
                        ..._cartController.items.asMap().entries.map((entry) {
                          final index = entry.key;
                          final item = entry.value;
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: index == _cartController.items.length - 1
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
                                _cartController.updateQuantity(item, v);
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  // Multi-deal cart addition is now managed from the
                  // discount explore screen (see DiscountExploreScreen).
                  const SizedBox(height: AppDimensions.spacingLarge),
                  Obx(
                    () => CartSummaryCard(
                      dealCount: _cartController.items.length,
                      subtotal: _cartController.subtotal.toString(),
                      savings: _cartController.savings.toString(),
                      total: _cartController.total.toString(),
                    ),
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
              child: Obx(
                () => PrimaryButton(
                  label: 'Confirm and pay Rs ${_cartController.total}',
                  backgroundColor: AppColors.secondaryColor,
                  textColor: AppColors.primaryColor,
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
