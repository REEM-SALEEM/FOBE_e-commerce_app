import 'package:finalproject/app/navigation%20items/cart/provider/cart_prov.dart';
import 'package:finalproject/app/navigation%20items/cart/widgets/cartlist.dart';
import 'package:finalproject/app/navigation%20items/order/model/order_argument.dart';
import 'package:finalproject/app/navigation%20items/order/provider/orders_prov.dart';
import 'package:finalproject/app/navigation%20items/order/view/buynow.dart';
import 'package:finalproject/app/navigation%20items/profile/address/provider/address_prov.dart';
import 'package:finalproject/app/navigation%20items/profile/address/view/address_add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CartProvider>(context, listen: false).getCart(context);
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'CART',
          style: TextStyle(
              color: Color.fromARGB(255, 54, 52, 52),
              letterSpacing: 1,
              fontFamily: 'Teko-Medium',
              fontWeight: FontWeight.normal,
              fontSize: 25),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: const [
              CartListviewWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Consumer3<CartProvider, AddressProvider,OrdersProvider>(
        builder: (context, value, address,order, child) {
          return value.cartList == null || value.cartList!.products.isEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: const Center(
                    child: Text(
                      'CART IS EMPTY',
                      style: TextStyle(
                          color: Colors.grey,
                          letterSpacing: 1,
                          fontFamily: 'Teko-Medium',
                          fontWeight: FontWeight.normal,
                          fontSize: 15),
                    ),
                  ),
                )
              : Row(
                  children: [
                    Material(
                      elevation: 10,
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width / 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Total Price',
                                style: TextStyle(
                                  letterSpacing: 1,
                                  fontFamily: "PTSerif-Regular",
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${value.totalSave}',
                                style: const TextStyle(
                                  fontFamily: "PTSerif-Italic",
                                  color: Color.fromARGB(255, 239, 83, 72),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width / 2,
                      child: ElevatedButton(
                        onPressed: () {
                          address.addressList.isEmpty
                              ? Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (context) => const AddressViewnAdd(),
                                ))
                              : Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (context) {
                                    return const OrderScreen(
                                      screenCheck: OrderSummaryScreenEnum
                                          .normalOrderSummaryScreen,
                                      cartId: '',
                                      productId: '',
                                    );
                                  },
                                ));
                          order.isLoading = false;
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            elevation: 1,
                            shape: const RoundedRectangleBorder()),
                        child: const Text(
                          'Place Order',
                          style: TextStyle(
                            fontFamily: "PTSerif-Regular",
                            color: Colors.white,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
