import 'package:finalproject/app/navigation%20items/home/widgets/shimmer.dart';
import 'package:flutter/material.dart';

class Productviewshimmer extends StatelessWidget {
  const Productviewshimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 10),
          const Center(child: ShimmerWidget.rectangle(height: 340, width: 300)),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              ShimmerWidget.rectangle(height: 55, width: 50),
              SizedBox(width: 7),
              ShimmerWidget.rectangle(height: 55, width: 50),
              SizedBox(width: 7),
              ShimmerWidget.rectangle(height: 55, width: 50),
              SizedBox(width: 7),
              ShimmerWidget.rectangle(height: 55, width: 50),
            ],
          ),
          const SizedBox(height: 30),
          const ShimmerWidget.rectangle(height: 15, width: 350),
          const SizedBox(height: 7),
          const ShimmerWidget.rectangle(height: 15, width: 290),
          const SizedBox(height: 18),
          const ShimmerWidget.rectangle(height: 12, width: 80),
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              ShimmerWidget.rectangle(height: 12, width: 80),
            ],
          ),
          const SizedBox(height: 30),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            ShimmerWidget.rectangle(height: 55, width: 170),
            SizedBox(width: 10),
            ShimmerWidget.rectangle(height: 55, width: 170),
          ]),
          const SizedBox(height: 30),
          const ShimmerWidget.rectangle(height: 10, width: 90),
          const SizedBox(height: 15),
          const ShimmerWidget.rectangle(height: 10, width: 350),
          const SizedBox(height: 5),
          const ShimmerWidget.rectangle(height: 10, width: 350),
          const SizedBox(height: 5),
          const ShimmerWidget.rectangle(height: 10, width: 350),
          const SizedBox(height: 5),
          const ShimmerWidget.rectangle(height: 10, width: 350),
          const SizedBox(height: 5),
          const ShimmerWidget.rectangle(height: 10, width: 350),
        ]),
      ),
    );
  }
}
