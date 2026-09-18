import 'package:bachaoo/features/catelog/models/sort_option.dart';
import 'package:get/get.dart';

class CatalogController<T> extends GetxController {
  final List<T> allItems;
  final double Function(T item) ratingOf;
  final String Function(T item) categoryOf;
  final String Function(T item) titleOf;
  final DateTime Function(T item) createdAtOf;
  final int Function(T item) popularityOf;

  CatalogController({
    required this.allItems,
    required this.ratingOf,
    required this.categoryOf,
    required this.titleOf,
    required this.createdAtOf,
    required this.popularityOf,
  });

  final RxString searchQuery = ''.obs;
  final Rxn<int> minRating = Rxn<int>();
  final RxSet<String> selectedCategories = <String>{}.obs;
  final Rx<SortOption> sortOption = SortOption.defaultOrder.obs;

  bool get hasActiveFilters =>
      minRating.value != null || selectedCategories.isNotEmpty;

  void setSearchQuery(String query) => searchQuery.value = query;

  void clearFilters() {
    minRating.value = null;
    selectedCategories.clear();
  }

  void applyFilters({required int? rating, required Set<String> categories}) {
    minRating.value = rating;
    selectedCategories.value = categories;
  }

  void setSortOption(SortOption option) => sortOption.value = option;

  List<T> get filteredItems {
    var items = allItems.where((item) {
      final matchesSearch =
          searchQuery.value.trim().isEmpty ||
          titleOf(item)
              .toLowerCase()
              .contains(searchQuery.value.trim().toLowerCase());

      final matchesRating =
          minRating.value == null || ratingOf(item) >= minRating.value!;

      final matchesCategory =
          selectedCategories.isEmpty ||
          selectedCategories.contains(categoryOf(item));

      return matchesSearch && matchesRating && matchesCategory;
    }).toList();

    switch (sortOption.value) {
      case SortOption.defaultOrder:
      case SortOption.recommended: // TODO: no personalization signal yet — falls back to default.
        break;
      case SortOption.aToZ:
        items.sort(
          (a, b) =>
              titleOf(a).toLowerCase().compareTo(titleOf(b).toLowerCase()),
        );
        break;
      case SortOption.zToA:
        items.sort(
          (a, b) =>
              titleOf(b).toLowerCase().compareTo(titleOf(a).toLowerCase()),
        );
        break;
      case SortOption.newest:
        items.sort((a, b) => createdAtOf(b).compareTo(createdAtOf(a)));
        break;
      case SortOption.trending:
      case SortOption.popular: // TODO: same metric as trending until a distinct signal exists.
        items.sort((a, b) => popularityOf(b).compareTo(popularityOf(a)));
        break;
    }

    return items;
  }
}
