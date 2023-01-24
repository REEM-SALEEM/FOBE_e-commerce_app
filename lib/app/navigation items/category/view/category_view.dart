import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:finalproject/app/core/const.dart';
import 'package:finalproject/app/navigation%20items/home/provider/home_prov.dart';
import 'package:finalproject/app/navigation%20items/product/provider/product_prov.dart';
import 'package:finalproject/app/navigation%20items/wishlist/provider/wishlist_prov.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CatView extends StatelessWidget {
  final String ids;

  const CatView({super.key, required this.ids});

  @override
  Widget build(BuildContext context) {
    /*After passing that particular product ID in Navigator pushNamed as -----------------------
    arguments, we can get that with the help of ModalRoute.*/
    final productId = ids;
    log("ProductId recieving = $productId");
    final provider =
        Provider.of<HomeProv>(context, listen: false).findByCategoryIdin(ids);

    return SafeArea(
      child: Scaffold(
        body: Consumer2<HomeProv, ProductProvider>(
          builder: (BuildContext context, value, value2, Widget? child) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Stack(children: [
                    CarouselSlider.builder(
                      itemCount: provider.length,
                      itemBuilder: (context, index, realIndex) {
                        return value.isLoading == true
                            ? const CircularProgressIndicator(
                                strokeWidth: 2,
                              )
                            : SizedBox(
                                width: 300,
                                height: 350,
                                child: Image(
                                  height: 150,
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    // 'http://172.16.3.3:5000/products/${provider[index].image[0]}',
                                    'http://172.16.8.138:5000/products/${provider[index].image[0]}',
                                  ),
                                ),
                              );
                      },
                      options: CarouselOptions(
                        height: 350,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          value2.getProductCarousel(index);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(300, 10, 0, 0),
                      child: Consumer<WishlistProv>(
                        builder: (BuildContext context, value, Widget? child) {
                          return value.wishList.contains(ids)
                              ? FavoriteButton(
                                  iconColor: Colors.red,
                                  iconSize: 45,
                                  isFavorite: true,
                                  valueChanged: (isFavorite) {
                                    value.isFavorite = true;
                                    value.addOrRemoveFromWishlist(context, ids);

                                    log('Is Favorite : $isFavorite');
                                  },
                                )
                              : FavoriteButton(
                                  iconSize: 45,
                                  isFavorite: false,
                                  valueChanged: (isFavorite) {
                                    value.isFavorite = false;
                                    value.addOrRemoveFromWishlist(context, ids);

                                    log('Is Favorite : $isFavorite');
                                  },
                                );
                        },
                      ),
                    ),
                  ]),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(170, 15, 0, 0),
                    child: AnimatedSmoothIndicator(
                      activeIndex: value2.activeIndex,
                      count: provider.length,
                      effect: const WormEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                        dotColor: Colors.grey,
                        activeDotColor: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // PreviewCATWidget(image: provider[0].image[index]),
                  // PreviewProductWidget(image: provider.image),
                  // ProductDetailsWidget(
                  //   name: provider[index].name,
                  //   price: provider.price,
                  //   rating: provider.rating,
                  // ),
                  const Divider(thickness: 8),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(180, 0),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'BUY NOW',
                            style: TextStyle(color: kWhitecolor),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.shopping_cart,
                            color: kWhitecolor,
                          ),
                          label: const Text(
                            'ADD TO CART',
                            style: TextStyle(color: kWhitecolor),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kBlackcolor,
                            fixedSize: const Size(180, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    '  PRODUCT DETAILS',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  //   child: Card(
                  //     color: const Color.fromARGB(255, 240, 245, 248),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: ReadMoreText(
                  //         provider.description,
                  //         trimLines: 3,
                  //         textAlign: TextAlign.justify,
                  //         trimMode: TrimMode.Line,
                  //         trimCollapsedText: "Show more",
                  //         trimExpandedText: "\nShow less",
                  //         lessStyle: const TextStyle(
                  //             fontWeight: FontWeight.bold, color: Colors.black),
                  //         moreStyle: const TextStyle(
                  //             fontWeight: FontWeight.bold, color: Colors.black),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 40)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
