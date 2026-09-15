import 'package:bachaoo/features/refer_and_earn/controllers/referral_controller.dart';
import 'package:get/get.dart';

class ReferralBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReferralController());
  }
}
