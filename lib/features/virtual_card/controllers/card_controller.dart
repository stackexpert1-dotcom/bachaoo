import 'package:bachaoo/features/virtual_card/models/virtuall_card_model.dart';
import 'package:bachaoo/routes/bachaoo_routes.dart';
import 'package:get/get.dart';

import '../../activity/models/activity_item_model.dart';

class CardController extends GetxController {
  final Rx<MemberCardModel?> card = Rx<MemberCardModel?>(null);
  final RxList<ActivityItemModel> activities = <ActivityItemModel>[].obs;

  final RxBool isLoadingCard = true.obs;
  final RxBool isLoadingActivity = true.obs;
  final RxString errorMessage = ''.obs;

  /// How many rows to show on THIS screen before "All" is tapped.
  static const int previewActivityCount = 3;

  @override
  void onInit() {
    super.onInit();
    loadCard();
    loadActivity();
  }

  Future<void> loadCard() async {
    isLoadingCard.value = true;
    errorMessage.value = '';
    try {
      // TODO: replace with your real API call, e.g.
      // final json = await MemberRepository.fetchCard();
      // card.value = MemberCardModel.fromJson(json);
      await Future.delayed(const Duration(milliseconds: 500));
      card.value = MemberCardModel(
        holderName: 'Shafqat Ullah',
        tierLabel: 'Standard',
        referralCode: 'O2JR3EWS38',
        validTill: DateTime(2027, 9, 2),
        points: 2000,
        pointsTarget: 5000,
        referralsCompleted: 2,
        referralsRequiredForNextTier: 5,
        pointsPerReferral: 1000,
        nextTierLabel: 'Pro mode',
      );
    } catch (e) {
      errorMessage.value = 'Could not load your card. Pull to retry.';
    } finally {
      isLoadingCard.value = false;
    }
  }

  Future<void> loadActivity() async {
    isLoadingActivity.value = true;
    try {
      // TODO: replace with your real API call, e.g.
      // final list = await MemberRepository.fetchActivity();
      await Future.delayed(const Duration(milliseconds: 500));
      activities.assignAll([
        ActivityItemModel(
          id: '1',
          type: ActivityType.discountClaimed,
          title: 'Discount claimed',
          subtitle: 'Nawaab Royal · today',
          amountLabel: '- Rs 100',
          isPositive: false,
          date: DateTime.now(),
          imageUrl: null,
        ),
        ActivityItemModel(
          id: '2',
          type: ActivityType.referralJoined,
          title: 'Referral joined',
          subtitle: 'Ahmed K. · 3 Sep',
          amountLabel: '+1,000 pts',
          isPositive: true,
          date: DateTime(2026, 9, 3),
          imageUrl: null,
        ),
        ActivityItemModel(
          id: '3',
          type: ActivityType.dealRedeemed,
          title: 'Deal redeemed',
          subtitle: 'Dhuaan N Dhukan · 28 Aug',
          amountLabel: '- Rs 300',
          isPositive: false,
          date: DateTime(2026, 8, 28),
          imageUrl: null,
        ),
      ]);
    } finally {
      isLoadingActivity.value = false;
    }
  }

  Future<void> refreshAll() async {
    await Future.wait([loadCard(), loadActivity()]);
  }

  /// Rows shown on the card screen itself — capped, newest first.
  List<ActivityItemModel> get previewActivities =>
      activities.take(previewActivityCount).toList();

  void goToScanPartner() => Get.toNamed('/scan-partner');

  void goToFullActivity() => Get.toNamed(AppRoutes.activityHistoryScreen);

  Future<void> addToWallet() async {
    // TODO: hook up google_wallet / passkit here.
    Get.snackbar(
      'Add to wallet',
      'Wallet integration coming soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> shareReferralCode() async {
    final code = card.value?.referralCode;
    if (code == null) return;
    // TODO: hook up share_plus, e.g. Share.share('Use my code $code on Bachaoo!');
    Get.snackbar(
      'Refer a friend',
      'Share your code: $code',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
