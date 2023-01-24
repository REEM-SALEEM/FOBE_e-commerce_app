import 'package:finalproject/app/navigation%20items/home/model/productlist_model.dart';

class CartGetModel {
  CartGetModel({
    required this.id,
    required this.userid,
    required this.products,
    required this.totalPrice,
    required this.totalDiscount,
  });

  String id;
  String userid;
  List<ProductElement> products;
  int totalPrice;
  dynamic totalDiscount;

  factory CartGetModel.fromJson(Map<String, dynamic> json) => CartGetModel(
        id: json["_id"],
        userid: json["userid"],
        products: json["products"] == null
            ? []
            : List<ProductElement>.from(
                json["products"]!.map((x) => ProductElement.fromJson(x))),
        totalPrice: json["totalPrice"],
        totalDiscount: json["totalDiscount"],
      );
}

//--------------------------*ID
class ProductElement {
  ProductElement({
    required this.product,
    required this.size,
    required this.qty,
    required this.price,
    required this.discountPrice,
    required this.id,
  });

  ProductModel product;
  String? size;
  int qty;
  int price;
  int? discountPrice;
  String? id;

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        product: ProductModel.fromJson(json["product"]),
        size: json["size"],
        qty: json["qty"],
        price: json["price"],
        discountPrice: json["discountPrice"],
        id: json["_id"],
      );
}
