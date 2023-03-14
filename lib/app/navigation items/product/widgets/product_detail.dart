import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({
    Key? key,
    required this.name,
    required this.price,
    required this.discountPrice,
    required this.rating,
    required this.offer,
  }) : super(key: key);
  final int offer;
  final String name;
  final int price;
  final int discountPrice;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 15, 8, 0),
      margin: const EdgeInsets.fromLTRB(0, 0, 04, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 9),
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              height: 1.2,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Row(children: [
          Text(
            '₹${price.toString()}',
            style: const TextStyle(
              color: Color.fromARGB(255, 185, 180, 180),
              decoration: TextDecoration.lineThrough,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 7),
          Text(
            '₹${discountPrice.toString()}',
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '(${offer.toString()}% OFF)',
            style: const TextStyle(
              color: Colors.orange,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          RichText(
            text: TextSpan(
                text: rating,
                style: const TextStyle(fontSize: 16,color: Colors.black),
                children: [
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: RatingBar.builder(
                        initialRating: double.parse(rating),
                        itemSize: 15,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ignoreGestures: true,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (startRating) {
                          log(startRating.toString());
                        },
                      ),
                    ),
                  )
                ]),
          ),
        ]),
        const SizedBox(height: 10),
      ]),
    );
  }
}
