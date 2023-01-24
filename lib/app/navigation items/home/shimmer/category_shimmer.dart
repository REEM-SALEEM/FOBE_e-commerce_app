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
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(10, 8, 8, 8),
                      child: ShimmerWidget.circle(height: 70, width: 70),
                    ),
                  ),
                  const ShimmerWidget.rectangle(height: 10, width: 60)
                ],
              ),
            ],
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        separatorBuilder: (BuildContext context, int index) {
          return Container();
        },
      ),
    );
  }
}
