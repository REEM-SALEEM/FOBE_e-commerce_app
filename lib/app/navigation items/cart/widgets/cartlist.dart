import 'dart:developer';
import 'package:finalproject/app/core/api/api_baseurl.dart';
import 'package:finalproject/app/navigation%20items/cart/provider/cart_prov.dart';
import 'package:finalproject/app/navigation%20items/cart/shimmer/cart_shimmer.dart';
import 'package:finalproject/app/navigation%20items/cart/widgets/cartalert.dart';
import 'package:finalproject/app/navigation%20items/home/provider/home_prov.dart';
import 'package:finalproject/app/navigation%20items/order/provider/orders_prov.dart';
import 'package:finalproject/app/navigation%20items/profile/address/provider/address_prov.dart';
import 'package:finalproject/app/navigation%20items/profile/address/view/address_add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class CartListviewWidget extends StatelessWidget {
  const CartListviewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider>(context);
    return Consumer3<HomeProv, CartProvider,OrdersProvider>(
      builder: (context, home, cart,order, child) {
        return cart.isLoading == true
            ? const CartShimmer()
            : ListView.separated(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return cart.cartList == null ||
                          cart.cartList!.products.isEmpty
                      ? const SizedBox(
                          child: Center(
                            child: Text('Cart is Empty'),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            cart.toProductScreen(context, index);
                          },
                          child: Card(
                            color: const Color.fromARGB(255, 248, 246, 246)
                                .withOpacity(0.9),
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //------------------------------*Image
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                            image: NetworkImage(
                                              '${ApiBaseUrl().baseUrl}/products/${cart.cartList!.products[index].product.image[0]}',
                                            ),
                                          )),
                                        ),
                                        const SizedBox(width: 15),
                                        //------------------------------*Name , rating
                                        Expanded(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  cart.cartList!.products[index]
                                                      .product.name,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          "PTSerif-Regular",
                                                      color: Color.fromARGB(
                                                          255, 49, 47, 47),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      letterSpacing: .6),
                                                ),
                                                const SizedBox(height: 5),
                                                RatingBar.builder(
                                                  initialRating: double.parse(
                                                      cart
                                                          .cartList!
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
                                                    log(startRating.toString());
                                                  },
                                                ),
                                                const SizedBox(height: 5),
                                                //----------------------*Price, Offer
                                                Row(children: [
                                                  const Text(
                                                    '₹',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                  Text(
                                                    "${(cart.cartList!.products[index].product.price - cart.cartList!.products[index].product.discountPrice).round()}",
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            "PTSerif-Regular",
                                                        color: Color.fromARGB(
                                                            255, 49, 47, 47),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        letterSpacing: .3),
                                                  ),
                                                  const SizedBox(width: 7),
                                                  const Text(
                                                    '₹',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${cart.cartList!.products[index].product.price}",
                                                    style: const TextStyle(
                                                      fontFamily:
                                                          "PTSerif-Regular",
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    "${cart.cartList!.products[index].product.offer}%Off",
                                                    style: const TextStyle(
                                                      fontFamily:
                                                          "PTSerif-Italic",
                                                      letterSpacing: 1,
                                                      color: Colors.orange,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ]),
                                                const SizedBox(height: 5),
                                                //---------------------------------------------------*Button (Buy NOW)
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      SizedBox(
                                                        child: Consumer2<
                                                            OrdersProvider,AddressProvider>(
                                                          builder: (BuildContext
                                                                  context,
                                                              value,address,
                                                              Widget? child) {
                                                            return ElevatedButton(
                                                              onPressed: () {
                                                                  address.addressList.isEmpty
                                                ? Navigator.of(context)
                                                    .push(CupertinoPageRoute(
                                                    builder: (context) =>
                                                        const AddressViewnAdd(),
                                                  ))
                                                :   value
                                                                    .toOrderScreen(
                                                                  context,
                                                                  provider
                                                                      .cartList!
                                                                      .products[
                                                                          index]
                                                                      .product
                                                                      .id,
                                                                  provider
                                                                      .cartList!
                                                                      .id,
                                                                );
                                                                 order.isLoading = false;
                                                              },
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .black,
                                                                elevation: 1,
                                                                shape:
                                                                    const RoundedRectangleBorder(),
                                                              ),
                                                              child: const Text(
                                                                'Buy Now',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "PTSerif-Regular",
                                                                    color: Colors
                                                                        .white,
                                                                    letterSpacing:
                                                                        1,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      //----------------------*Dec & Inc
                                                      Wrap(children: [
                                                        InkWell(
                                                          onTap: () {
                                                            log(cart
                                                                .cartList!
                                                                .products[index]
                                                                .qty
                                                                .toString());
                                                            //--dec
                                                            cart.incrementOrDecrementQuantity(
                                                              -1,
                                                              cart
                                                                  .cartList!
                                                                  .products[
                                                                      index]
                                                                  .product
                                                                  .id,
                                                              cart
                                                                  .cartList!
                                                                  .products[
                                                                      index]
                                                                  .size,
                                                              cart
                                                                  .cartList!
                                                                  .products[
                                                                      index]
                                                                  .qty,
                                                              context,
                                                            );
                                                              log(cart
                                                                .cartList!
                                                                .products[index]
                                                                .qty
                                                                .toString());
                                                          },
                                                          child: Container(
                                                            height: 25,
                                                            width: 25,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.black,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: const Icon(
                                                              Icons.remove,
                                                              size: 20,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        Container(
                                                          height: 25,
                                                          width: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            border:
                                                                Border.all(),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              "${cart.cartList!.products[index].qty.toInt()}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          16),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        InkWell(
                                                          onTap: () {
                                                            cart.incrementOrDecrementQuantity(
                                                              1,
                                                              cart
                                                                  .cartList!
                                                                  .products[
                                                                      index]
                                                                  .product
                                                                  .id,
                                                              cart
                                                                  .cartList!
                                                                  .products[
                                                                      index]
                                                                  .size,
                                                              cart
                                                                  .cartList!
                                                                  .products[
                                                                      index]
                                                                  .qty,
                                                              context,
                                                            );
                                                          },
                                                          child: Container(
                                                            height: 25,
                                                            width: 25,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.black,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: const Icon(
                                                              Icons.add,
                                                              size: 20,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                    ]),
                                              ]),
                                        ),
                                        //--------------------------------------------------------------*Remove
                                        InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return CartAlertWidget(
                                                    cart: cart,
                                                    index: index,
                                                  );
                                                },
                                              );
                                            },
                                            child: const Icon(Icons.close)),
                                      ]),
                                ],
                              ),
                            ),
                          ),
                        );
                },
                itemCount: cart.cartList?.products.length ?? 0,
                separatorBuilder: (context, index) => const SizedBox(),
              );
      },
    );
  }
}
