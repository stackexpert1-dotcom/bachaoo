import 'package:get/get.dart';

import '../controllers/card_controller.dart';

class CardBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CardController());
  }
}
