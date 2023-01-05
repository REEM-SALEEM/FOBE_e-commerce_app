import 'package:finalproject/app/navigation%20items/home/widgets/shimmer.dart';
import 'package:flutter/material.dart';

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 5 / 5,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return ShimmerWidget.rectangle(
            height: 20,
            width: 20,
            radius: BorderRadius.circular(20),
          );
        },
        itemCount: 4,
      ),
    );
  }
}
