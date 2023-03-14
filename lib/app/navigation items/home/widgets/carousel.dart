import 'package:carousel_slider/carousel_slider.dart';
import 'package:finalproject/app/navigation%20items/home/shimmer/carousal_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/home_prov.dart';

class WidgetCarousel extends StatelessWidget {
  const WidgetCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProv>(
      builder: (BuildContext context, value, Widget? child) {
        return value.isLoading == true || value.carousalList.isEmpty
            ? Stack(children: const [
                CarousalShimmer(),
                // Center(child: CircularProgressIndicator()),
              ])
            : CarouselSlider.builder(
                itemCount: value.carousalList.length,
                itemBuilder: (context, index, realIndex) {
                  return Container(
                    height: 200,
                    width: 400,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'http://172.16.7.235:5000/carousals/${value.carousalList[index].image}'),
                              //  'http://192.168.1.5:5000/carousals/${value.carousalList[index].image}'),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(40)),
                  );
                },
                options: CarouselOptions(
                  height: 200.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.9,
                ));
      },
    );
  }
}
