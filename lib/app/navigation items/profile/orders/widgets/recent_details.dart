import 'package:finalproject/app/core/api/api_baseurl.dart';
import 'package:finalproject/app/navigation%20items/order/provider/orders_prov.dart';
import 'package:finalproject/app/navigation%20items/profile/orders/widgets/cancel.dart';
import 'package:finalproject/app/navigation%20items/profile/orders/widgets/success.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetialsView extends StatelessWidget {
  const OrderDetialsView({
    super.key,
    required this.orderId,
    required this.index1,
  });

  final String orderId;
  final int index1;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<OrdersProvider>(context, listen: false)
          .getSingleOrders(orderId);
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'ORDER DETAILS',
          style: TextStyle(
              color: Color.fromARGB(255, 54, 52, 52),
              letterSpacing: 1,
              fontFamily: 'Teko-Medium',
              fontWeight: FontWeight.normal,
              fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<OrdersProvider>(
          builder: (context, value, child) {
            return value.isLoading == true || value.getSingleOrder == null
                ? const CircularProgressIndicator()
                : Column(
                    children: [
                      Card(
                        color: Colors.white,
                        shape: const OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide.none,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Order ID - ${value.getSingleOrder!.id.toUpperCase()}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                              const Divider(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            value.getSingleOrder!
                                                .products[index1].product.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "₹${(value.getSingleOrder!.products[index1].product.price - value.getSingleOrder!.products[index1].product.discountPrice).round()}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ]),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 100),
                                      child: Image(
                                        height: 90,
                                        width: 100,
                                        image: NetworkImage(
                                            '${ApiBaseUrl().baseUrl}/products/${value.getSingleOrder!.products[index1].product.image[0]}'),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const Divider(),
                              value.getSingleOrder!.orderStatus == 'CANCELED'
                                  ? OrderCanceldStatusWidget(index: index1)
                                  : OrderSucssesStatusWidget(index: index1),
                              const Divider(),
                              Consumer<OrdersProvider>(
                                builder: (context, value, child) {
                                  return value.getSingleOrder!.orderStatus ==
                                          'CANCELED'
                                      ? Center(
                                          child: TextButton.icon(
                                            style: TextButton.styleFrom(
                                              foregroundColor:
                                                  Colors.grey.shade600,
                                            ),
                                            onPressed: () {
                                              value.sendOrderDetials(context);
                                            },
                                            icon: const Icon(
                                              Icons.share,
                                              size: 20,
                                            ),
                                            label: const Text(
                                              'Share Order Details',
                                            ),
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                foregroundColor:
                                                    Colors.grey.shade600,
                                              ),
                                              onPressed: () {
                                                value.cancelOrders(orderId);
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            const VerticalDivider(
                                                endIndent: 20),
                                            TextButton.icon(
                                              style: TextButton.styleFrom(
                                                foregroundColor:
                                                    Colors.grey.shade600,
                                              ),
                                              onPressed: () {
                                                value.sendOrderDetials(context);
                                              },
                                              icon: const Icon(
                                                Icons.share,
                                                size: 20,
                                              ),
                                              label: const Text(
                                                'Share Order Details',
                                              ),
                                            )
                                          ],
                                        );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      Consumer<OrdersProvider>(
                        builder: (context, value, child) {
                          return Card(
                            color: Colors.white,
                            shape: const OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide.none,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Shopping Details",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const Divider(),
                                  Text(
                                    value.getSingleOrder!.fullName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                      '${value.getSingleOrder!.address}\n${value.getSingleOrder!.place}\n${value.getSingleOrder!.state} - ${value.getSingleOrder!.pin}\nPhone Number: ${value.getSingleOrder!.phone}')
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
