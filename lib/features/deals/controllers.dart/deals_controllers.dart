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
      ),
    ];

    historyDeals.value = [
      DealModel(
        id: '2',
        subtitle: 'Nawaab Royal Restaurant',
        title: '10% discount',
        date: DateTime(2026, 9, 9),
        amountSaved: 100,
      ),
      DealModel(
        id: '3',
        subtitle: 'Chobara Restaurant',
        title: '12% discount',
        date: DateTime(2026, 9, 4),
        amountSaved: 384,
      ),
      DealModel(
        id: '4',
        subtitle: 'Dhuaan N Dhukan',
        title: 'Deal 2',
        date: DateTime(2026, 8, 28),
        amountSaved: 300,
      ),
      DealModel(
        id: '5',
        subtitle: 'Suzuki Falcon Motors',
        title: '20% labour',
        date: DateTime(2026, 8, 19),
        amountSaved: 1200,
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
