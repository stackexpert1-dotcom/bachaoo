import 'package:get/get.dart';
import 'package:bachaoo/features/cart/controllers/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    // `permanent` keeps a single shared cart instance for the whole app
    // session so the cart contents survive route pops. Combined with GetX's
    // `put` semantics (it never clobbers an already-registered instance),
    // attaching this binding to multiple routes is safe.
    Get.put(CartController(), permanent: true);
  }
}
