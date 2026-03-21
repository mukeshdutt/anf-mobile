class WishlistEntity {
  final String id;
  final String productId;
  final String productName;
  final String productImage;
  final double price;
  final DateTime addedAt;

  WishlistEntity({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.addedAt,
  });
}
