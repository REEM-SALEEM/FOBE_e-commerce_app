import 'dart:developer';

import 'package:finalproject/app/core/api/api_baseurl.dart';
import 'package:finalproject/app/navigation%20items/cart/provider/cart_prov.dart';
import 'package:finalproject/app/navigation%20items/order/model/order_argument.dart';
import 'package:finalproject/app/navigation%20items/order/provider/orders_prov.dart';
import 'package:finalproject/app/navigation%20items/order/provider/payment_prov.dart';
import 'package:finalproject/app/navigation%20items/order/widgets/addresslist.dart';
import 'package:finalproject/app/navigation%20items/profile/address/provider/address_prov.dart';
import 'package:finalproject/app/navigation%20items/profile/address/view/address_add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen(
      {super.key,
      required this.screenCheck,
      required this.cartId,
      required this.productId});

  final OrderSummaryScreenEnum screenCheck;

  final String cartId;
  final String productId;
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  PaymentProvider paymentProvider = PaymentProvider();

  @override
  void initState() {
    // final paymentProviderr =
    //     Provider.of<PaymentProvider>(context, listen: false);
    final razorpay = paymentProvider.razorpay;
    log('looo');
    razorpay.on(
        Razorpay.EVENT_PAYMENT_SUCCESS, paymentProvider.handlePaymentSuccess);
    razorpay.on(
        Razorpay.EVENT_PAYMENT_ERROR, paymentProvider.handlePaymentError);
    razorpay.on(
        Razorpay.EVENT_EXTERNAL_WALLET, paymentProvider.handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    paymentProvider.razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paymentProvier = Provider.of<PaymentProvider>(context, listen: false);
    final cartprovider = Provider.of<CartProvider>(context, listen: false);
    final addressProvider =
        Provider.of<AddressProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrdersProvider>(context, listen: false)
          .getSingleCart(context, widget.productId, widget.cartId);

      paymentProvier.setAddressId(
          addressProvider.addressList[addressProvider.selectIndex].id);
      Provider.of<OrdersProvider>(context, listen: false).productIds.insert(0,
          cartprovider.cartitemsPayId[cartprovider.cartitemsPayId.length - 1]);
      log("cxvxcv${Provider.of<OrdersProvider>(context, listen: false).productIds.toString()}");
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Order summary'),
      ),
      body: Consumer3<AddressProvider, OrdersProvider, CartProvider>(
        builder: (context, value, order, cart, child) {
          return order.isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      value.addressList.isEmpty
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : AddressWidget(
                              name:
                                  value.addressList[value.selectIndex].fullName,
                              title: value.addressList[value.selectIndex].title,
                              address:
                                  '''${value.addressList[value.selectIndex].address},
${value.addressList[value.selectIndex].state} - ${value.addressList[value.selectIndex].pin}
Land Mark - ${value.addressList[value.selectIndex].landMark}
''',
                              number:
                                  value.addressList[value.selectIndex].phone,
                              onPreesed: () {
                                Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (context) {
                                    return const AddressViewnAdd();
                                  },
                                ));
                              },
                            ),
                      //-----------------------*Product details
                      const SizedBox(height: 10),
                      ListView.separated(
                        itemCount: widget.screenCheck ==
                                OrderSummaryScreenEnum.normalOrderSummaryScreen
                            ? cart.cartList!.products.length
                            : 1,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    // provider.cartList.length - 1
                                    image: NetworkImage(
                                      widget.screenCheck ==
                                              OrderSummaryScreenEnum
                                                  .normalOrderSummaryScreen
                                          ? '${ApiBaseUrl().baseUrl}/products/${cart.cartList!.products[index].product.image[0]}'
                                          : '${ApiBaseUrl().baseUrl}/products/${order.cartModel[0].product.image[0]}',
                                    ),
                                  )),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .7,
                                      child: Text(
                                        widget.screenCheck ==
                                                OrderSummaryScreenEnum
                                                    .normalOrderSummaryScreen
                                            ? cart.cartList!.products[index]
                                                .product.name
                                            : order.cartModel[0].product.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    RatingBar.builder(
                                      ignoreGestures: true,
                                      allowHalfRating: true,
                                      onRatingUpdate: (value) {},
                                      itemBuilder: (context, hello) {
                                        return const Icon(
                                          Icons.star,
                                          color:
                                              Color.fromARGB(255, 24, 110, 29),
                                        );
                                      },
                                      itemSize: 16,
                                      initialRating: double.parse(
                                        widget.screenCheck ==
                                                OrderSummaryScreenEnum
                                                    .normalOrderSummaryScreen
                                            ? cart.cartList!.products[index]
                                                .product.rating
                                            : order.cartModel[0].product.rating,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          widget.screenCheck ==
                                                  OrderSummaryScreenEnum
                                                      .normalOrderSummaryScreen
                                              ? "${cart.cartList!.products[index].product.offer}%off"
                                              : "${order.cartModel[0].product.offer}%off",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          widget.screenCheck ==
                                                  OrderSummaryScreenEnum
                                                      .normalOrderSummaryScreen
                                              ? "₹${cart.cartList!.products[index].product.price}"
                                              : "${order.cartModel[0].product.price}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          widget.screenCheck ==
                                                  OrderSummaryScreenEnum
                                                      .normalOrderSummaryScreen
                                              ? "₹${(cart.cartList!.products[index].product.price - cart.cartList!.products[index].product.discountPrice).round()}"
                                              : "₹${(order.cartModel[0].product.price - order.cartModel[0].product.discountPrice).round()}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    widget.screenCheck ==
                                            OrderSummaryScreenEnum
                                                .normalOrderSummaryScreen
                                        ? Text(
                                            '${cart.cartList!.products[index].qty} Item',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                            ),
                                          )
                                        : const SizedBox()
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 20);
                        },
                      ),
                      const SizedBox(height: 10),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Price Details",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Price',
                                ),
                                Text(
                                  widget.screenCheck ==
                                          OrderSummaryScreenEnum
                                              .normalOrderSummaryScreen
                                      ? "₹${cart.cartList!.totalPrice}"
                                      : "₹${order.cartModel[0].product.price}",
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Discount Price',
                                ),
                                Text(
                                  widget.screenCheck ==
                                          OrderSummaryScreenEnum
                                              .normalOrderSummaryScreen
                                      ? "₹${cart.cartList!.totalDiscount.toStringAsFixed(0)}"
                                      : "₹${order.cartModel[0].product.discountPrice.toStringAsFixed(0)}",
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: .6,
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total Amout',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.screenCheck ==
                                          OrderSummaryScreenEnum
                                              .normalOrderSummaryScreen
                                      ? "₹${(cart.cartList!.totalPrice - cart.cartList!.totalDiscount).round()}"
                                      : "₹${(order.cartModel[0].product.price - order.cartModel[0].product.discountPrice).round()}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              height: 20,
                              thickness: .6,
                            ),
                            Text(
                              widget.screenCheck ==
                                      OrderSummaryScreenEnum
                                          .normalOrderSummaryScreen
                                  ? 'You will save ₹${cart.cartList!.totalDiscount.toStringAsFixed(0)} on this order'
                                  : 'You will save ₹${order.cartModel[0].product.discountPrice.toStringAsFixed(0)} on this order',
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.verified_user,
                            size: 30,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            '''Safe and secure payment. Easy returns.
           100% Authentic products.''',
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
        },
      ),
      bottomNavigationBar:
          Consumer3<PaymentProvider, OrdersProvider, CartProvider>(
        builder: (context, value, order, cart, child) {
          return order.isLoading == true 
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  height: 70,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      widget.screenCheck ==
                              OrderSummaryScreenEnum.normalOrderSummaryScreen
                          ? "₹${cart.cartList!.totalPrice}"
                          : "₹${order.cartModel[0].price}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    subtitle: Text(
                      widget.screenCheck ==
                              OrderSummaryScreenEnum.normalOrderSummaryScreen
                          ? "₹${(cart.cartList!.totalPrice - cart.cartList!.totalDiscount).round()}"
                          : "₹${(order.cartModel[0].product.price - order.cartModel[0].product.discountPrice).round()}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        // color: Colors.grey,
                      ),
                    ),
                    trailing: SizedBox(
                      width: 200,
                      child: Consumer<AddressProvider>(
                        builder: (context, address, child) {
                          return address.addressList.isEmpty
                              ? OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.orange,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(CupertinoPageRoute(
                                      builder: (context) {
                                        return const AddressViewnAdd();
                                      },
                                    ));
                                  },
                                  child: const Text(
                                    'Add address',
                                  ),
                                )
                              : Consumer2<PaymentProvider, OrdersProvider>(
                                  builder: (BuildContext context, vals, orders,
                                      Widget? child) {
                                    return ListView.builder(
                                      itemCount: 1,
                                      itemBuilder: (context, index) {
                                        return ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black,
                                          ),
                                          onPressed: () async {
                                            log(cart.cartList!.totalPrice
                                                .toString());
                                            log(cart.cartList!.totalDiscount
                                                .toString());
                                            log(cart.cartitemsPayId.toString());
                                            log(orders.productIds.toString());
                                            log(address
                                                .addressList[
                                                    address.selectIndex]
                                                .id);
                                            paymentProvier.setTotalAmount(
                                              widget.screenCheck ==
                                                      OrderSummaryScreenEnum
                                                          .normalOrderSummaryScreen
                                                  ? int.parse((cart.cartList!
                                                              .totalPrice -
                                                          cart.cartList!
                                                              .totalDiscount)
                                                      .round()
                                                      .toString())
                                                  : int.parse((orders
                                                              .cartModel[0]
                                                              .price -
                                                          orders.cartModel[0]
                                                              .discountPrice)
                                                      .round()
                                                      .toString()),
                                              widget.screenCheck ==
                                                      OrderSummaryScreenEnum
                                                          .normalOrderSummaryScreen
                                                  ? cart.cartitemsPayId
                                                  : orders.productIds,
                                              address
                                                  .addressList[
                                                      address.selectIndex]
                                                  .id,
                                            );
                                            // paymentProvider.openCheckout(
                                            //   id: cart.cartList!.products[index].id,
                                            //   name: cart.cartList!.products[index]
                                            //       .product.name,
                                            //   price: cart.cartList!.products[index]
                                            //       .product.discountPrice,
                                            //   offer: cart.cartList!.products[index]
                                            //       .product.offer,
                                            //   size: cart.cartList!.products[index]
                                            //       .product.size,
                                            //   img: cart.cartList!.products[index]
                                            //       .product.image[index],
                                            //   cat: cart.cartList!.products[index]
                                            //       .product.category,
                                            //   rate: cart.cartList!.products[index]
                                            //       .product.rating,
                                            //   desc: cart.cartList!.products[index]
                                            //       .product.description,
                                            //   int.parse(
                                            //     ((order.cartModel[0].discountPrice))
                                            //         .toString(),
                                            //   ),
                                            //   context,
                                            // );
                                          },
                                          child: const Text(
                                            'CONTINUE',
                                            style: TextStyle(
                                                color: Colors.white),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                        },
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
