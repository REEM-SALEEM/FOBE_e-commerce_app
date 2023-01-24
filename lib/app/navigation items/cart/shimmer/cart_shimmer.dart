import 'package:finalproject/app/navigation%20items/cart/provider/cart_prov.dart';
import 'package:finalproject/app/navigation%20items/home/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartShimmer extends StatelessWidget {
  const CartShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider>(context, listen: false);

    return ListView.separated(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Row(children: [
                const ShimmerWidget.rectangle(height: 100, width: 100),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ShimmerWidget.rectangle(height: 10, width: 200),
                      const SizedBox(height: 5),
                      const ShimmerWidget.rectangle(height: 10, width: 90),
                      const SizedBox(height: 5),
                      const ShimmerWidget.rectangle(height: 10, width: 30),
                      const SizedBox(height: 5),
                      Row(children: const [
                        ShimmerWidget.rectangle(height: 10, width: 30),
                        SizedBox(width: 5),
                        ShimmerWidget.rectangle(height: 10, width: 30),
                        SizedBox(width: 5),
                        ShimmerWidget.rectangle(height: 10, width: 30),
                      ]),
                      const SizedBox(height: 15),
                      Row(children: [
                        const ShimmerWidget.rectangle(height: 30, width: 80),
                        const SizedBox(width: 20),
                        ShimmerWidget.rectangle(
                          height: 20,
                          width: 25,
                          radius: BorderRadius.circular(5),
                        ),
                        const SizedBox(width: 5),
                        ShimmerWidget.rectangle(
                          height: 20,
                          width: 40,
                          radius: BorderRadius.circular(5),
                        ),
                        const SizedBox(width: 5),
                        ShimmerWidget.rectangle(
                          height: 20,
                          width: 25,
                          radius: BorderRadius.circular(5),
                        ),
                      ]),
                    ],
                  ),
                ),
              ]),
            ]),
          ),
        );
      },
      itemCount: provider.cartList?.products.length ?? 10,
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
