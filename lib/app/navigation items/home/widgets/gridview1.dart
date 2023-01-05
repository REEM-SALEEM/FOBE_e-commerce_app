import 'package:finalproject/app/navigation%20items/home/provider/home_prov.dart';
import 'package:finalproject/app/navigation%20items/home/shimmer/product_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetGridView extends StatelessWidget {
  const WidgetGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProv>(
      builder: (BuildContext context, value, Widget? child) {
        return  value.productList.isEmpty
                    ?  const ProductShimmer()
                    : Card(
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20), topLeft: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 5 / 5,
              ),
              itemBuilder: (context, index) {
                return Container(
                        height: 200,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image(
                          image: NetworkImage(
                              'http://172.16.3.3:5005/products/${value.productList[index].image}'),
                        ),
                      );
              },
              itemCount: value.productList.length,
            ),
          ),
        );
      },
    );
  }
}
