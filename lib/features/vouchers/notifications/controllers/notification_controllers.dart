import 'package:bachaoo/features/vouchers/notifications/models/notification_model.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  final RxInt selectedFilterIndex = 0.obs; // 0 = All, 1 = Promo, 2 = Bachaoo

  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  static const filters = ['All', 'Promo', 'Bachaoo'];

  @override
  void onInit() {
    super.onInit();
    _loadNotifications();
  }

  // TODO: replace with a real repository/API call.

  void _loadNotifications() {
    final now = DateTime.now();

    notifications.value = [
      NotificationModel(
        id: '1',
        title: 'Almost gone',
        description:
            'Limited-time offer! Enjoy up to 40% off at selected '
            "partner restaurants. Don't miss out — claim before it expires!",
        time: now.subtract(const Duration(hours: 2)),
        category: NotificationCategory.promo,
        type: NotificationType.dealExpiring,
        imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800',
      ),

      NotificationModel(
        id: '2',
        title: 'Claim your Rs 500 voucher',
        description:
            'Sign up now and enjoy a Rs 500 voucher on your first '
            "redemption! Don't miss out.",
        time: now.subtract(const Duration(hours: 2)),
        category: NotificationCategory.promo,
        type: NotificationType.voucher,
        imageUrl:
            'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=800',
      ),

      NotificationModel(
        id: '3',
        title: 'Unlock your exclusive gift',
        description:
            'Refer a friend and unlock a surprise reward once '
            'they redeem their first deal.',
        time: now.subtract(const Duration(hours: 2)),
        category: NotificationCategory.promo,
        type: NotificationType.exclusiveGift,
        imageUrl:
            'https://images.unsplash.com/photo-1549465220-1a8b9238cd48?w=800',
      ),

      NotificationModel(
        id: '4',
        title: 'Deal redeemed',
        description:
            'Your discount at Dhuaan N Dhukan was confirmed. '
            'Check "My deals" to see how much you saved.',
        time: now.subtract(const Duration(hours: 2)),
        category: NotificationCategory.bachaoo,
        type: NotificationType.dealRedeemed,
        imageUrl: 'https://images.unsplash.com/photo-1515003197210-e0cd71810b5f?w=800',
      ),

      NotificationModel(
        id: '5',
        title: 'Points earned',
        description:
            "You've earned 150 points from your last redemption. "
            'Keep saving to unlock better rewards.',
        time: now.subtract(const Duration(hours: 2)),
        category: NotificationCategory.bachaoo,
        type: NotificationType.pointsEarned,
        imageUrl:
            'https://images.unsplash.com/photo-1559526324-593bc073d938?w=800',
      ),

      NotificationModel(
        id: '6',
        title: 'Your card tier went up',
        description:
            "You've been upgraded to Gold membership. Enjoy "
            'better discounts at partner businesses from now on.',
        time: now.subtract(const Duration(hours: 2)),
        category: NotificationCategory.bachaoo,
        type: NotificationType.cardUpgrade,
        imageUrl:
            'https://images.unsplash.com/photo-1556740749-887f6717d7e4?w=800',
      ),
    ];
  }

  void selectFilter(int index) => selectedFilterIndex.value = index;

  List<NotificationModel> get filteredNotifications {
    switch (selectedFilterIndex.value) {
      case 1:
        return notifications
            .where((n) => n.category == NotificationCategory.promo)
            .toList();
      case 2:
        return notifications
            .where((n) => n.category == NotificationCategory.bachaoo)
            .toList();
      default:
        return notifications;
    }
  }
}
