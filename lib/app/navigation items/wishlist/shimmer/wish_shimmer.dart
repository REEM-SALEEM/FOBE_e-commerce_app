import 'package:finalproject/app/navigation%20items/home/widgets/shimmer.dart';
import 'package:flutter/cupertino.dart';

class WishShimmer extends StatelessWidget {
  const WishShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            height: 200,
            width: 350,
            child: ShimmerWidget.rectangle(
              height: 100,
              width: 100,
              radius: BorderRadius.circular(20),
            )));
  }
}
