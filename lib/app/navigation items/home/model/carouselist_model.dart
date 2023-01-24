class CarouselModel {
  final String image;
  final String id;
  final String offer;

  CarouselModel({required this.image, required this.id, required this.offer});

  factory CarouselModel.fromJson(Map<String, dynamic> json) {
    return CarouselModel(
      image: json['image'],
      id: json['_id'],
      offer: json['offer'] ?? "",
    );
  }
}
