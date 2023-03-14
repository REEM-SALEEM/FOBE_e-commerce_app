import 'dart:developer';
import 'package:finalproject/app/core/api/api_baseurl.dart';
import 'package:finalproject/app/navigation%20items/cart/provider/cart_prov.dart';
import 'package:finalproject/app/navigation%20items/order/model/order_argument.dart';
import 'package:finalproject/app/navigation%20items/order/provider/orders_prov.dart';
import 'package:finalproject/app/navigation%20items/order/widgets/addresslist.dart';
import 'package:finalproject/app/navigation%20items/order/widgets/order_address.dart';
import 'package:finalproject/app/navigation%20items/profile/address/provider/address_prov.dart';
import 'package:finalproject/app/navigation%20items/profile/address/view/address_add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class OrderPlacedScreen extends StatelessWidget {
  const OrderPlacedScreen({super.key, this.args});

  final OrderArgumnetsModel? args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: SafeArea(
        child: Consumer3<AddressProvider, OrdersProvider, CartProvider>(
          builder: (context, value, order, cart, child) {
            return order.isLoading == true
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                    children: [
                      AddressWidget(
                        name: value.addressList[value.selectIndex].fullName,
                        title: value.addressList[value.selectIndex].title,
                        address:
                            '''${value.addressList[value.selectIndex].address},
${value.addressList[value.selectIndex].state} - ${value.addressList[value.selectIndex].pin}
Land Mark - ${value.addressList[value.selectIndex].landMark}
''',
                        number: value.addressList[value.selectIndex].phone,
                        onPreesed: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) {
                              return const AddressViewnAdd();
                            },
                          ));
                        },
                      ),
                      // kheight,
                      Expanded(
                        child: ListView.builder(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                  color: Colors.grey,
                                  child: Column(children: [
                                    // kSize,
                                    Row(
                                      children: [
                                        // kWidth,
                                        Image(
                                          height: 100,
                                          width: 100,
                                          image: NetworkImage(
                                            'http://172.16.5.206:5005/products/${order.cartModel[0].product.image[0]}',
                                            // order.cartModel[0].product.image[0],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        ListView.separated(
                                          itemCount:
                                              cart.cartList!.products.length,
                                          shrinkWrap: true,
                                          physics: const ScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Container(
                                              padding: const EdgeInsets.all(10),
                                              color: Colors.white,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 90,
                                                    width: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.2,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                      // provider.cartList.length - 1
                                                      image: NetworkImage(
                                                          '${ApiBaseUrl().baseUrl}/products/${cart.cartList!.products[index].product.image[0]}'),
                                                    )),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                .7,
                                                        child: Text(
                                                          cart
                                                              .cartList!
                                                              .products[index]
                                                              .product
                                                              .name,
                                                          style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 3),
                                                      RatingBar.builder(
                                                        ignoreGestures: true,
                                                        allowHalfRating: true,
                                                        onRatingUpdate:
                                                            (value) {},
                                                        itemBuilder:
                                                            (context, hello) {
                                                          return const Icon(
                                                            Icons.star,
                                                            color: Color.fromARGB(
                                                                255, 24, 110, 29),
                                                          );
                                                        },
                                                        itemSize: 16,
                                                        initialRating:
                                                            double.parse(cart
                                                                .cartList!
                                                                .products[index]
                                                                .product
                                                                .rating),
                                                      ),
                                                      const SizedBox(height: 10),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "${cart.cartList!.products[index].product.offer}%off",
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color:
                                                                  Colors.orange,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 5),
                                                          Text(
                                                            "₹${cart.cartList!.products[index].product.price}",
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              color: Colors.grey,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 5),
                                                          Text(
                                                            "₹${(cart.cartList!.products[index].product.price - cart.cartList!.products[index].product.discountPrice).round()}",
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 10),
                                                      Text(
                                                        '${cart.cartList!.products[index].qty} Item',
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.grey,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context, int index) {
                                            return const SizedBox(height: 20);
                                          },
                                        ),
                                        Text(
                                          'Order Placed Successfully',
                                          style: TextStyle(
                                              color: Colors.green, fontSize: 16),
                                        )
                                      ],
                                    )
                                  ]));
                            },
                            itemCount: 1),
                      ),
                      // kSize,
                    ],
                  ));
          },
        ),
      ),
    );
  }
}
