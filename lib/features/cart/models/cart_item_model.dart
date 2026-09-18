class CartItemModel {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String currentPrice;
  final String originalPrice;
  int quantity;

  CartItemModel({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.currentPrice,
    required this.originalPrice,
    this.quantity = 1,
  });

  // For checking equality when adding the same item
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemModel &&
          runtimeType == other.runtimeType &&
          title == other.title;

  @override
  int get hashCode => title.hashCode;
}
