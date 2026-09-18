class CatalogCategories {
  static const List<String> all = [
    'Food',
    'Super Market',
    'Beauty & Care',
    'Education',
    'Entertainment',
    'Services',
    'Auto Mobiles',
    'Health',
    'Fashion',
  ];
}

class CatalogRatingOption {
  final int value;
  final String label;
  const CatalogRatingOption(this.value, this.label);
}

class CatalogRatings {
  static const List<CatalogRatingOption> all = [
    CatalogRatingOption(5, 'Only rated 5'),
    CatalogRatingOption(4, '4+ Rating'),
    CatalogRatingOption(3, '3+ Rating'),
    CatalogRatingOption(2, '2+ Rating'),
    CatalogRatingOption(1, '1+ Rating'),
  ];
}
