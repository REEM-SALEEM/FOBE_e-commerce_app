import 'package:finalproject/app/navigation%20items/home/widgets/shimmer.dart';
import 'package:flutter/material.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return Row(
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: const ShimmerWidget.circle(height: 60, width: 60),
                  ),
                  const ShimmerWidget.rectangle(height: 20, width: 60)
                ],
              ),
            ],
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (BuildContext context, int index) {
          return Container();
        },
      ),
    );
  }
}
