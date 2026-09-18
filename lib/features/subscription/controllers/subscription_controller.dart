import 'package:bachaoo/features/subscription/models/subscription_model.dart';
import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  // TODO: pull the user's actual current tier from wherever profile/auth
  // state lives — hardcoded here since that wasn't part of this task.
  final String currentTierName = 'Standard';

  final RxList<SubscriptionPlanModel> plans = <SubscriptionPlanModel>[].obs;
  final RxString selectedPlanId = ''.obs;
  final RxBool isProcessing = false.obs;

  @override
  void onInit() {
    super.onInit();
    plans.value = [
      const SubscriptionPlanModel(
        id: 'standard',
        name: 'Standard Plan',
        currencyUnit: 'PTS', // NOTE: matches the reference image's unit —
        // double-check with design whether this should actually be "Rs",
        // since every other screen in the app prices things in Rs.
        pricePerYear: 0,
        benefits: ['Basic deals access', 'Standard support'],
      ),
      const SubscriptionPlanModel(
        id: 'gold',
        name: 'Gold Plan',
        currencyUnit: 'PTS',
        pricePerYear: 7500,
        originalPricePerYear: 11500,
        benefits: [
          'Exclusive Discounts',
          'Cashback Rewards',
          'Priority Access',
        ],
      ),
    ];
    // Default to the upgrade plan being selected, matching the reference.
    selectedPlanId.value = 'gold';
  }

  SubscriptionPlanModel get selectedPlan => plans.firstWhere(
    (p) => p.id == selectedPlanId.value,
    orElse: () => plans.last,
  );

  void selectPlan(String id) => selectedPlanId.value = id;

  Future<void> completeCheckout() async {
    isProcessing.value = true;
    // TODO: replace with real payment/subscription API call.
    await Future.delayed(const Duration(seconds: 2));
    isProcessing.value = false;
    Get.snackbar(
      'Subscription updated',
      'Welcome to the ${selectedPlan.name}!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
