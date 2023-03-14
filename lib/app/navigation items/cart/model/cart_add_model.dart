class CartModel {
  final String size;
  final int quantity;
  final String productId;

  CartModel({
    required this.size,
    required this.quantity,
    required this.productId,
  });

  Map<String, dynamic> toJson() {
    return {
      'product': productId,
      'size': size,
      'qty': quantity,
    };
  }
}
