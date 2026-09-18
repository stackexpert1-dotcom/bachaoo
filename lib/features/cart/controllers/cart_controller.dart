import 'package:get/get.dart';
import 'package:bachaoo/features/cart/models/cart_item_model.dart';

class CartController extends GetxController {
  final RxList<CartItemModel> items = <CartItemModel>[].obs;

  int get subtotal => items.fold(
      0,
      (sum, item) => sum + ((int.tryParse(item.originalPrice) ?? 0) * item.quantity),
    );

  int get total => items.fold(
      0,
      (sum, item) => sum + ((int.tryParse(item.currentPrice) ?? 0) * item.quantity),
    );

  int get savings => subtotal - total;

  void addItem(CartItemModel item) {
    final existingIndex = items.indexWhere((i) => i.title == item.title);
    if (existingIndex >= 0) {
      items[existingIndex].quantity += item.quantity;
      items.refresh();
    } else {
      items.add(item);
    }
  }

  void addItems(List<CartItemModel> newItems) {
    for (var item in newItems) {
      addItem(item);
    }
  }

  void updateQuantity(CartItemModel item, int newQuantity) {
    if (newQuantity <= 0) {
      items.remove(item);
    } else {
      item.quantity = newQuantity;
      items.refresh();
    }
  }

  void clearCart() {
    items.clear();
  }
}
