import 'package:finalproject/app/navigation%20items/home/widgets/shimmer.dart';
import 'package:flutter/material.dart';

class EmailShimmer extends StatelessWidget {
  const EmailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ShimmerWidget.circle(height: 110, width: 110),
        const SizedBox(width: 17),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            ShimmerWidget.rectangle(height: 14, width: 80),
            SizedBox(height: 20),
            ShimmerWidget.rectangle(height: 13, width: 170),
          ],
        )
      ],
    );
  }
}
