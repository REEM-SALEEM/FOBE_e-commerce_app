class ProductModel {
  String id;
  String name;
  int price;
  dynamic discountPrice;
  int offer;
  List<String> size;
  List<String> image;
  String category;
  String rating;

  ProductModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.discountPrice,
      required this.offer,
      required this.size,
      required this.image,
      required this.category,
      required this.rating});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      name: json['name'],
      price: json['price'],
      discountPrice: json['discountPrice'],
      offer: json['offer'],
      size: List<String>.from(json["size"].map((e) => e)),
      image: List<String>.from(json["image"].map((e) => e)),
      category: json['category'],
      rating: json['rating'],
    );
  }
}