import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/home_prov.dart';

class WidgetCarousel extends StatelessWidget {
  const WidgetCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProv>(
      builder: (BuildContext context, value, Widget? child) {
        return CarouselSlider.builder(
            itemCount: value.caritems.length,
            itemBuilder: (context, index, realIndex) {
              return Container(
                height: 200,
                width: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: value.caritems[index].image,
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
