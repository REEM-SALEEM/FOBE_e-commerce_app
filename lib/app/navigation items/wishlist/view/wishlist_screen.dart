import 'dart:developer';
import 'package:favorite_button/favorite_button.dart';
import 'package:finalproject/app/core/api/api_baseurl.dart';
import 'package:finalproject/app/navigation%20items/home/provider/home_prov.dart';
import 'package:finalproject/app/navigation%20items/wishlist/provider/wishlist_prov.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'WISHLIST',
          style: TextStyle(
              color: Color.fromARGB(255, 54, 52, 52),
              letterSpacing: 1,
              fontFamily: 'Teko-Medium',
              fontWeight: FontWeight.normal,
              fontSize: 25),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer2<HomeProv, WishlistProv>(
            builder: (context, home, wish, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    wish.model == null || wish.model!.products.isEmpty
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height / 1.5,
                            child: const Center(
                              child: Text(
                                'WISHLIST IS EMPTY',
                                style: TextStyle(
                                    color: Colors.grey,
                                    letterSpacing: 1,
                                    fontFamily: 'Teko-Medium',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                              ),
                            ),
                          )
                        : ListView.separated(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  wish.toProductScreen(context, index);
                                },
                                child: Card(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 140,
                                              width: 110,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                  '${ApiBaseUrl().baseUrl}/products/${wish.model!.products[index].product.image[0]}',
                                                ),
                                              )),
                                            ),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Wrap(children: [
                                                    Text(
                                                      wish
                                                          .model!
                                                          .products[index]
                                                          .product
                                                          .name,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              "PTSerif-Regular",
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ]),
                                                  const SizedBox(height: 5),
                                                  RatingBar.builder(
                                                    initialRating: double.parse(
                                                        wish
                                                            .model!
                                                            .products[index]
                                                            .product
                                                            .rating),
                                                    itemSize: 15,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    ignoreGestures: true,
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate:
                                                        (startRating) {
                                                      log(startRating
                                                          .toString());
                                                    },
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        '???',
                                                        style: TextStyle(
                                                          fontSize: 19,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${wish.model!.products[index].product.discountPrice}",
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              "PTSerif-Regular",
                                                          fontSize: 19,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const Text(
                                                        '???',
                                                        style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          color: Color.fromARGB(
                                                              255,
                                                              108,
                                                              107,
                                                              107),
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${wish.model!.products[index].product.price}",
                                                        style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              108,
                                                              107,
                                                              107),
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          fontSize: 15,
                                                          fontFamily:
                                                              "PTSerif-Regular",
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Text(
                                                        "(${wish.model!.products[index].product.offer}%)",
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              "PTSerif-Regular",
                                                          fontSize: 15,
                                                          color: Colors.orange,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 30),
                                                      Consumer<WishlistProv>(
                                                        builder: (BuildContext
                                                                context,
                                                            value,
                                                            Widget? child) {
                                                          return FavoriteButton(
                                                            iconColor:
                                                                Colors.red,
                                                            iconDisabledColor:
                                                                Colors.red,
                                                            iconSize: 45,
                                                            isFavorite: true,
                                                            valueChanged:
                                                                (isFavorite) {
                                                              value.isFavorite =
                                                                  true;
                                                              value.addOrRemoveFromWishlist(
                                                                  context,
                                                                  wish
                                                                      .model!
                                                                      .products[
                                                                          index]
                                                                      .product
                                                                      .id);

                                                              log('Is Favorite : $isFavorite');
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox();
                            },
                            itemCount: wish.model?.products.length ?? 0,
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
        // Text(
                                                  //   "???${(wish.model!.products[index].product.price - wish.model!.products[index].product.discountPrice).round()}",
                                                  //   style: const TextStyle(
                                                  //     color: kBlackcolor,
                                                  //     fontSize: 20,
                                                  //     fontWeight:
                                                  //         FontWeight.bold,
                                                  //     fontFamily: "Manrope",
                                                  //   ),
                                                  // ),
                                                      // Text(
                                                  //   "${wish.model!.products[index].product.offer}%Off",
                                                  //   style: const TextStyle(
                                                  //     color: Colors.green,
                                                  //     fontWeight:
                                                  //         FontWeight.bold,
                                                  //     fontSize: 16,
                                                  //     fontFamily: "Manrope",
                                                  //   ),
                                                  // ),
                                                  //------------
                                                  // final productId = ModalRoute.of(context)!.settings.arguments as String;
    // final provider = Provider.of<WishlistProvider>(context,listen: false).findById(productId);