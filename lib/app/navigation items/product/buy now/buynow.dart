import 'dart:developer';

import 'package:finalproject/app/core/api/api_baseurl.dart';
import 'package:finalproject/app/navigation%20items/cart/provider/cart_prov.dart';
import 'package:finalproject/app/navigation%20items/home/provider/home_prov.dart';
import 'package:finalproject/app/navigation%20items/profile/address/provider/address_prov.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});
  static const routeName = "/orders_page";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as String;
    final provider =
        Provider.of<HomeProv>(context, listen: false).findById(args);
    final data = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      body: Consumer<AddressProvider>(
        builder: (BuildContext context, value, Widget? child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              ListView.separated(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      color: const Color.fromARGB(255, 233, 230, 230),
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Deliver to,",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    value.addressList[index].fullName,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    height: 20,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Center(
                                      child: Text(
                                        value.addressType,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                value.addressList[index].address,
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                "PIN: ${value.addressList[index].pin}",
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                value.addressList[index].state,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                value.addressList[index].phone,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                            ]),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(),
                  itemCount: 1),
              //----------------------------------------------------
              ListView.separated(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    '${ApiBaseUrl().baseUrl}/products/${provider.image[0]}',
                                  ),
                                )),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(children: [
                                      Text(
                                        provider.name,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                                    const SizedBox(height: 5),
                                    RatingBar.builder(
                                      initialRating:
                                          double.parse(provider.rating),
                                      itemSize: 15,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      ignoreGestures: true,
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (startRating) {
                                        log(startRating.toString());
                                      },
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text(
                                          "₹${provider.price}",
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 108, 107, 107),
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "₹${provider.discountPrice}",
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "(${provider.offer}%)",
                                          style: const TextStyle(
                                            fontSize: 17,
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold,
                                          ),
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
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: 1,
              ),
            ]),
          );
        },
      ),
    );
  }
}
// Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     fixedSize: const Size(300, 30),
//                                   ),
//                                   onPressed: () {
//                                     Navigator.of(context).push(
//                                       MaterialPageRoute(
//                                         builder: (context) {
//                                           return AdressForm(
//                                             addressScreenCheck:
//                                                 AddressScreen.editAddressScreen,
//                                             addressId:
//                                                 value.addressList[index].id,
//                                           );
//                                         },
//                                       ),
//                                     );
//                                   },
//                                   child: const Text(
//                                     'Change Address',
//                                     style: TextStyle(color: Colors.black),
//                                   ),
//                                 ),
//                               ],
//                             )