class SubscriptionPlanModel {
  final String id;
  final String name; // e.g. "Gold Plan"
  final String currencyUnit; // e.g. "PTS" or "Rs" — see note below
  final int pricePerYear;
  final int? originalPricePerYear;
  final List<String> benefits;

  const SubscriptionPlanModel({
    required this.id,
    required this.name,
    required this.currencyUnit,
    required this.pricePerYear,
    this.originalPricePerYear,
    required this.benefits,
  });

  bool get hasDiscount =>
      originalPricePerYear != null && originalPricePerYear! > pricePerYear;
}
