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
        return value.isLoading == true
            ? const ProductShimmer()
            :
            //paddng
            GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 5.4 / 8,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Provider.of<HomeProv>(context, listen: false)
                          .toProductScreen(context, index);
                    },
                    child: Container(
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Card(
                        elevation: 0,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image(
                                height: 150,
                                fit: BoxFit.contain,
                                image: NetworkImage(
                                    'http://172.16.8.138:5000/products/${value.productList[index].image[0]}'),
                                // 'http://192.168.1.11:5000/products/${value.productList[index].image[0]}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  Text(
                                    value.productList[index].name.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(children: [
                                    Text(
                                      "₹${value.productList[index].price.toString()}",
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 108, 107, 107),
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "₹${value.productList[index].discountPrice.toString()}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      '(${value.productList[index].offer.toString()}% OFF)',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ])
                                ]),
                              ),
                            ]),
                      ),
                    ),
                  );
                },
                itemCount: value.productList.length,
              );
      },
    );
  }
}
