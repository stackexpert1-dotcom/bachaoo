import 'package:bachaoo/features/home/controllers/bottom_nav_controller.dart';
import 'package:get/get.dart';

class BottomBavBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavController());
  }
}
