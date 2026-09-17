import 'package:get/get.dart';
import 'package:bachaoo/features/vouchers/notifications/controllers/notification_controllers.dart';

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(NotificationsController());
  }
}
