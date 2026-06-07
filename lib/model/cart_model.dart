
class CartItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageAsset;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageAsset,
    this.quantity = 1,
  });

  // السعر الكلي لهذا الصنف (السعر × الكمية)
  double get totalPrice => price * quantity;
}