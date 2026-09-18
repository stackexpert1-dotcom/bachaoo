import 'package:get/get.dart';

import '../controllers/subscription_controller.dart';

class SubscriptionBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SubscriptionController());
  }
}
