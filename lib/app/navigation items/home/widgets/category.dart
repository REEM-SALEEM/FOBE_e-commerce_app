import 'dart:developer';

import 'package:finalproject/app/core/const.dart';
import 'package:finalproject/app/navigation%20items/category/view/category_screen.dart';
import 'package:finalproject/app/navigation%20items/home/provider/home_prov.dart';
import 'package:finalproject/app/navigation%20items/home/shimmer/category_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetCategoryListview extends StatelessWidget {
  const WidgetCategoryListview({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProv>(
      builder: (BuildContext context, value, Widget? child) {
        return value.isLoading == true
            ? const CategoryShimmer()
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: SizedBox(
                      height: 110,
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CategoryScreen(
                                  id: value.categoryList[index].id,
                                ),
                              ));
                              log("argument passing: ${value.categoryList[index].id}");
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      const Color.fromARGB(255, 233, 230, 230),
                                  radius: 41,
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                        "http://172.16.7.235:5000/category/${value.categoryList[index].image}"),
                                    // "http://192.168.1.5:5000/category/${value.categoryList[index].image}"),
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
                  ),
                ],
              );
      },
    );
  }
}
  //  Navigator.of(context).pushNamed(
                              //     CategoryScreen.routeName,
                              //     arguments: value.categoryList[index].id);
