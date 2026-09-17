import 'package:bachaoo/features/deals/controllers.dart/deals_controllers.dart';
import 'package:get/get.dart';

class DealBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DealsController());
  }
}
