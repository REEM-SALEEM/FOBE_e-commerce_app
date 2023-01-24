import 'dart:developer';
import 'package:finalproject/app/navigation%20items/category/view/category_view.dart';
import 'package:finalproject/app/navigation%20items/home/provider/home_prov.dart';
import 'package:finalproject/app/navigation%20items/home/shimmer/product_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  final String id;
  const CategoryScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final productId = id;

    final provider = Provider.of<HomeProv>(context, listen: false)
        .findByCategoryId(productId);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: Consumer<HomeProv>(
          builder: (BuildContext context, value, Widget? child) {
            return value.isLoading == true
                ? const ProductShimmer()
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 5.4 / 8,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            // value.toProductScreen(context, index);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  CatView(ids: provider[index].id),
                            ));
                            log("argument passing: ${provider[index].id}");
                            //--------------------------------------------------
                            //  value.fromCategoryToProductView(context, index);
                          },
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image(
                                  height: 150,
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      'http://172.16.8.138:5000/products/${provider[index].image[index]}'),
                                  // 'http://192.168.1.11:5000/products/${provider[index].image[index]}'),
                                ),
                                Text(
                                  provider[index].name.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(children: [
                                  Text("₹${provider[index].price.toString()}")
                                ])
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: provider.length,
                    ),
                  );
          },
        ),
      ),
    );
  }
}
