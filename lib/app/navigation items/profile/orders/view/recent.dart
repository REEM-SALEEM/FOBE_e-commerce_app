import 'package:finalproject/app/core/api/api_baseurl.dart';
import 'package:finalproject/app/navigation%20items/navigation_bar/provider/index_navbar.dart';
import 'package:finalproject/app/navigation%20items/navigation_bar/view/navigationbar.dart';
import 'package:finalproject/app/navigation%20items/order/provider/orders_prov.dart';
import 'package:finalproject/app/navigation%20items/profile/orders/widgets/recent_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecentScreen extends StatelessWidget {
  const RecentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<OrdersProvider>(context, listen: false).getAllOrders();
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'MY ORDERS',
          style: TextStyle(
              color: Color.fromARGB(255, 54, 52, 52),
              letterSpacing: 1,
              fontFamily: 'Teko-Medium',
              fontWeight: FontWeight.normal,
              fontSize: 25),
        ),
        actions: [
          Consumer<NavigationIndex>(
            builder: (context, value, child) {
              return IconButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(
                        builder: (context) => const BottomNavigationScreen(),
                      ),
                      (route) => false);
                  value.currentIndex = 2;
                },
                icon: const Icon(
                  Icons.shopping_bag_outlined,
                ),
              );
            },
          )
        ],
      ),
      body: Consumer<OrdersProvider>(
        builder: (context, value, child) {
          return value.ordersList!.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Your Orders is empty!",
                        style: TextStyle(
                          fontFamily: 'Teko-Medium',
                          fontSize: 24,
                          color: Colors.black54,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          elevation: 0,
                        ),
                        onPressed: () {
                          Navigator.pop(context);

                          Provider.of<NavigationIndex>(context, listen: false)
                              .toHomescreen();
                        },
                        child: const Text(
                          'Order Now',
                          style: TextStyle(
                            fontFamily: 'Teko-Medium',
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : value.isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(8),
                      child: ListView.separated(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final deliveryDate = value.formatDate(
                              value.ordersList![index].deliveryDate.toString());
                          final canceledDate = value.formatCancelDate(
                              value.ordersList![index].cancelDate.toString());
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: value.ordersList![index].products.length,
                            itemBuilder: (context, index1) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (context) {
                                      return OrderDetialsView(
                                        orderId: value.ordersList![index].id,
                                        index1: index1,
                                      );
                                    },
                                  ));
                                },
                                child: Row(
                                  children: [
                                    Image(
                                      height: 70,
                                      width: 70,
                                      image: NetworkImage(
                                        "${ApiBaseUrl().baseUrl}/products/${value.ordersList![index].products[index1].product.image[0]}",
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .7,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            value.ordersList![index]
                                                .products[index1].product.name,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            value.ordersList![index1]
                                                        .orderStatus ==
                                                    'CANCELED'
                                                ? 'Delivery Canceled on $canceledDate'
                                                : value.ordersList![index1]
                                                            .orderStatus ==
                                                        'delivered'
                                                    ? 'Delivered on $deliveryDate'
                                                    : 'Delivery on $deliveryDate',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey.shade400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider();
                            },
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: value.ordersList?.length ?? 0,
                      ),
                    );
        },
      ),
    );
  }
}
