class CartModel {
  CartModel({
    required this.productId,
    required this.size,
    required this.quantity,
  });

  final String size;
  final int quantity;
  final String productId;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        productId: json["product"],
        size: json["size"],
        quantity: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "product": productId,
        "size": size,
        "qty": quantity,
      };
}
