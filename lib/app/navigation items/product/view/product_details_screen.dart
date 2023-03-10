import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:finalproject/app/core/const.dart';
import 'package:finalproject/app/navigation%20items/cart/provider/cart_prov.dart';
import 'package:finalproject/app/navigation%20items/home/provider/home_prov.dart';
import 'package:finalproject/app/navigation%20items/navigation_bar/provider/index_navbar.dart';
import 'package:finalproject/app/navigation%20items/navigation_bar/view/navigationbar.dart';
import 'package:finalproject/app/navigation%20items/order/view/buynow.dart';
import 'package:finalproject/app/navigation%20items/product/provider/product_prov.dart';
import 'package:finalproject/app/navigation%20items/product/shimmer/product_view_shimmer.dart';
import 'package:finalproject/app/navigation%20items/product/widgets/product_detail.dart';
import 'package:finalproject/app/navigation%20items/product/widgets/product_preview.dart';
import 'package:finalproject/app/navigation%20items/wishlist/provider/wishlist_prov.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProvDetails extends StatelessWidget {
  const ProvDetails({
    super.key,
  });

  static const routeName = '/product_view.dart';
  @override
  Widget build(BuildContext context) {
    /*-------------------------------After passing that particular product ID in Navigator pushNamed as 
    arguments, we can get that with the help of ModalRoute.--------------------------------------------*/
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final provider =
        Provider.of<HomeProv>(context, listen: false).findById(productId);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: Consumer2<HomeProv, ProductProvider>(
          builder: (BuildContext context, value, value2, Widget? child) {
            return value.isLoading == true
                ? const Productviewshimmer()
                : SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          CarouselSlider.builder(
                            itemCount: provider.image.length,
                            itemBuilder: (context, index, realIndex) {
                              return SizedBox(
                                width: 300,
                                height: 350,
                                child: Image(
                                  height: 150,
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    // 'http://172.16.8.138:5000/products/${provider.image[index]}',
                                    'http://172.16.7.235:5000/products/${provider.image[index]}',
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
                          //-------------------------------------------------*Carousel Dots
                          Padding(
                            padding: const EdgeInsets.fromLTRB(170, 15, 0, 0),
                            child: AnimatedSmoothIndicator(
                              activeIndex: value2.activeIndex,
                              count: provider.image.length,
                              effect: const WormEffect(
                                dotHeight: 10,
                                dotWidth: 10,
                                dotColor: Colors.grey,
                                activeDotColor: Colors.black,
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          //-------------------------------------------------*Image Preview
                          PreviewProductWidget(image: provider.image),
                          //-------------------------------------------------*Productt Details(name,price...)
                          ProductDetailsWidget(
                            name: provider.name,
                            price: provider.price,
                            rating: provider.rating,
                            discountPrice: provider.discountPrice,
                            offer: provider.offer,
                          ),

                          const Divider(
                            thickness: 12,
                            color: Color.fromARGB(255, 238, 236, 236),
                          ),

                          const SizedBox(height: 10),

                          Consumer2<CartProvider, WishlistProv>(
                            builder: (BuildContext context, value, wishh,
                                Widget? child) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      wishh.wishList.contains(provider.id)
                                      //------------------------------------------------*Favourites / Wishlist
                                          ? ElevatedButton(
                                              onPressed: () {
                                                Provider.of<NavigationIndex>(
                                                        context,
                                                        listen: false)
                                                    .currentIndex = 2;
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      const BottomNavigationScreen(),
                                                ));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                fixedSize: const Size(180, 40),
                                              ),
                                              child: const Text(
                                                'GO TO WISHLIST',
                                                style: TextStyle(
                                                    color: kWhitecolor),
                                              ),
                                            )
                                          : ElevatedButton(
                                              onPressed: () {
                                                wishh.addOrRemoveFromWishlist(
                                                    context, provider.id);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                fixedSize: const Size(180, 40),
                                              ),
                                              child: const Text(
                                                'WISHLIST',
                                                style: TextStyle(
                                                    color: kWhitecolor),
                                              ),
                                            ),
                                      //-------------------------------------------------*Elevated Button (ADD TO CART)
                                      SizedBox(
                                        height: 40,
                                        child: value.cartItemsId
                                                .contains(productId)
                                            ? ElevatedButton.icon(
                                                onPressed: () {
                                                  Provider.of<NavigationIndex>(
                                                          context,
                                                          listen: false)
                                                      .currentIndex = 1;
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        const BottomNavigationScreen(),
                                                  ));
                                                },
                                                icon: const Icon(
                                                  Icons.shopping_cart,
                                                  color: kWhitecolor,
                                                ),
                                                label: const Text(
                                                  'GO TO CART',
                                                  style: TextStyle(
                                                      color: kWhitecolor),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: kBlackcolor,
                                                  fixedSize: const Size(180, 0),
                                                ),
                                              )
                                            : ElevatedButton.icon(
                                                onPressed: () {
                                                  value.addToCart(
                                                      provider.id,
                                                      context,
                                                      provider.size.toString());
                                                  log(provider.id);
                                                  log(provider.size.toString());
                                                },
                                                icon: const Icon(
                                                  Icons.shopping_cart,
                                                  color: kWhitecolor,
                                                ),
                                                label: const Text(
                                                  'ADD TO CART',
                                                  style: TextStyle(
                                                      color: kWhitecolor),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: kBlackcolor,
                                                  fixedSize: const Size(180, 0),
                                                ),
                                              ),
                                      ),
                                    ]),
                              );
                            },
                          ),

                          const SizedBox(height: 10),

                          const Divider(
                            thickness: 12,
                            color: Color.fromARGB(255, 238, 236, 236),
                          ),

                          //-------------------------------------------------*Product description
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '  PRODUCT DETAILS',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: 500,
                                    child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        //--
                                        child: Text(
                                          provider.description,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 94, 92, 92)),
                                        )),
                                  ),
                                ]),
                          ),

                          const Divider(
                            thickness: 12,
                            color: Color.fromARGB(255, 238, 236, 236),
                          ),

                          const SizedBox(height: 20),
                        ]),
                  );
          },
        ),
      ),
    );
  }
}
//---------------------------------------------------------------------*ReadMoreText
  // Card(
                                  //   color:
                                  //       const Color.fromARGB(255, 240, 245, 248),
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(8.0),
                                  //     child: ReadMoreText(
                                  //       provider.description,
                                  //       trimLines: 3,
                                  //       textAlign: TextAlign.justify,
                                  //       trimMode: TrimMode.Line,
                                  //       trimCollapsedText: "Show more",
                                  //       trimExpandedText: "\nShow less",
                                  //       lessStyle: const TextStyle(
                                  //           fontWeight: FontWeight.bold,
                                  //           color: Colors.black),
                                  //       moreStyle: const TextStyle(
                                  //           fontWeight: FontWeight.bold,
                                  //           color: Colors.black),
                                  //     ),
                                  //   ),
                                  // ),
//--------------------------------------------------------------------*Gaurantee
  // Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //       children: <Widget>[
                    //         Expanded(
                    //           child: SizedBox(
                    //             width: 90,
                    //             height: 90,
                    //             // color: Colors.red,
                    //             child: Image.asset(
                    //                 'assets/Black and White Minimal Monogram Logo.png'),
                    //           ),
                    //         ),
                    //         const VerticalDivider(
                    //           color: Colors.green,
                    //         ),
                    //         Expanded(
                    //           child: SizedBox(
                    //             width: 100,
                    //             height: 100,
                    //             // color: Colors.red,
                    //             child: Column(children: [
                    //               Image.asset('assets/quality.png'),
                    //               Text('Genuine Product'),
                    //             ]),
                    //           ),
                    //         ),
                    //       ]),
                    // ),