import 'package:finalproject/app/core/const.dart';
import 'package:finalproject/app/navigation%20items/home/provider/home_prov.dart';
import 'package:finalproject/app/navigation%20items/home/shimmer/category_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetCategoryListview extends StatelessWidget {
  const WidgetCategoryListview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
      child: Consumer<HomeProv>(
        builder: (BuildContext context, value, Widget? child) {
          return value.categoryList.isEmpty
              ? const CategoryShimmer()
              : Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 110,
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {},
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: const Color.fromARGB(
                                        255, 233, 230, 230),
                                    radius: 41,
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(
                                          "http://172.16.3.3:5000/category/${value.categoryList[index].image}"),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        value.categoryList[index].name,
                                        style: const TextStyle(
                                            color: kBlackcolor, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: value.categoryList.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return kWidth10;
                          },
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
