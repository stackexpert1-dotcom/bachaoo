import 'package:get/get.dart';
import 'package:bachaoo/features/deals/models/deal_model.dart';
import 'package:bachaoo/features/deals/views/widgets/my_deals/deal_business_code_bottom_sheet.dart';

class DealsController extends GetxController {
  final RxInt selectedTab = 0.obs; // 0 = Active, 1 = History

  final RxList<DealModel> activeDeals = <DealModel>[].obs;
  final RxList<DealModel> historyDeals = <DealModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDeals();
  }

  // TODO: replace with a real repository/API call.
  void _loadDeals() {
    activeDeals.value = [
      const DealModel(
        id: '1',
        title: 'Bachaoo Deal 1 x 1',
        subtitle: 'Dhuaan N Dhukan',
        amountSaved: 333,
        imageUrl:
            'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=400',
      ),
    ];

    historyDeals.value = [
      DealModel(
        id: '2',
        subtitle: 'Nawaab Royal Restaurant',
        title: '10% discount',
        status: DealStatus.redeemed,
        date: DateTime(2026, 9, 9),
        amountSaved: 100,
        imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400',
      ),
      DealModel(
        id: '3',
        subtitle: 'Chobara Restaurant',
        title: '12% discount',
        status: DealStatus.redeemed,
        date: DateTime(2026, 9, 4),
        amountSaved: 384,
        imageUrl: 'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=400',
      ),
      DealModel(
        id: '4',
        subtitle: 'Dhuaan N Dhukan',
        title: 'Deal 2',
        status: DealStatus.redeemed,
        date: DateTime(2026, 8, 28),
        amountSaved: 300,
        imageUrl:
            'https://images.unsplash.com/photo-1547592180-85f173990554?w=400',
      ),
      DealModel(
        id: '5',
        subtitle: 'Suzuki Falcon Motors',
        title: '20% labour',
        status: DealStatus.redeemed,
        date: DateTime(2026, 8, 19),
        amountSaved: 1200,
        imageUrl: 'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=400',
      ),
    ];
  }

  void selectTab(int index) => selectedTab.value = index;

  /// Groups history deals by month, in the order they were added
  /// (i.e. newest-first if your source data is already sorted that way).
  Map<String, List<DealModel>> get groupedHistory {
    final Map<String, List<DealModel>> grouped = {};
    for (final deal in historyDeals) {
      if (deal.date == null) continue;
      final key = _monthLabel(deal.date!);
      grouped.putIfAbsent(key, () => []).add(deal);
    }
    return grouped;
  }

  String _monthLabel(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[date.month - 1];
  }

  void onEnterBusinessCode(DealModel deal) {
    if (Get.context != null) {
      DealBusinessCodeBottomSheet.show(
        Get.context!,
        deal: deal,
        onConfirm: (code) {
          Get.snackbar('Success', 'Business code $code entered successfully');
        },
      );
    }
  }

  void onBrowseDeals() {
    // Adjust to wherever "browse deals" actually lives.
    Get.back();
  }
}
