import 'dart:developer';
import 'package:finalproject/app/core/const.dart';
import 'package:finalproject/app/navigation%20items/home/provider/connectivity_prov.dart';
import 'package:finalproject/app/navigation%20items/home/provider/home_prov.dart';
import 'package:finalproject/app/navigation%20items/home/widgets/carousel.dart';
import 'package:finalproject/app/navigation%20items/home/widgets/category.dart';
import 'package:finalproject/app/navigation%20items/home/widgets/gridview1.dart';
import 'package:finalproject/app/navigation%20items/home/widgets/ontapscrn_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // Provider.of<HomeProv>(context, listen: false).isVisible = true;
    Provider.of<ProvConnectivity>(context, listen: false)
        .getConnectivity(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer2<ProvConnectivity, HomeProv>(
        builder: (context, value, home, child) {
          value.getConnectivity(context);
          return Scaffold(
              backgroundColor: kWhitecolor,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                //-----------------------------------------------*Search
                actions: [
                  InkWell(
                    onTap: () {
                      home.isVisible = !home.isVisible;
                      home.searchData.clear();
                      log(home.isVisible.toString());
                      // Navigator.of(context).push(
                      // MaterialPageRoute(builder: (context) => const ScreenSearch()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: !home.isVisible
                          ? const Icon(
                              Icons.search,
                              size: 30,
                            )
                          : const Icon(
                              Icons.close,
                              size: 30,
                            ),
                    ),
                  )
                ],
                backgroundColor: Colors.white,
                elevation: 0,
                toolbarHeight: 70,
                title: Visibility(
                    child: !home.isVisible
                        ? SizedBox(
                            height: 90,
                            width: 90,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Image.asset("assets/fobehome.png"),
                            ))
                        : SizedBox(
                            // height: 50,
                            // width: 90,
                            child: AnimatedContainer(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            duration: const Duration(seconds: 10),
                            curve: Curves.slowMiddle,
                            child: TextFormField(
                              onChanged: (value) {
                                home.getSearchResult(value);
                              },
                              controller: home.searchController,
                              decoration: const InputDecoration(
                                // prefixIcon: Icon(
                                //   Icons.search,
                                //   color: Colors.grey,
                                // ),
                                hintText: 'Search...',
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.0),
                                  ),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                            ),
                          ))),
              ),
              body: !home.isVisible
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(08.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            //------------------------------------------------*Carousel
                            WidgetCarousel(),
                            iHeight18,
                            Text('Category',
                                style: TextStyle(
                                    fontSize: 15,
                                    wordSpacing: 1,
                                    fontWeight: FontWeight.w900)),
                            iHeight8,
                            //------------------------------------------------*Category
                            WidgetCategoryListview(),
                            SizedBox(height: 15),
                            Text('Newly Launched',
                                style: TextStyle(
                                    fontSize: 15,
                                    wordSpacing: 1,
                                    fontWeight: FontWeight.w900)),

                            SizedBox(height: 10),
                            //------------------------------------------------*Products
                            WidgetGridView(),
                          ],
                        ),
                      ),
                    )
                  : Scaffold(
                      backgroundColor: const Color.fromARGB(255, 209, 204, 203),
                      body: Consumer<HomeProv>(
                        builder:
                            (BuildContext context, homeprov, Widget? child) {
                          return ListView.separated(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var data = homeprov.searchData[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ScreenOntap(productModel: data)));
                          //                  Provider.of<HomeProv>(context, listen: false)
                          // .toProductScreen(context, index);
                                },
                                child: Card(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 140,
                                              width: 110,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    'http://172.16.7.235:5000/products/${data.image[0]}'),
                                              )),
                                            ),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Wrap(children: [
                                                    Text(
                                                      data.name,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              "PTSerif-Regular",
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ]),
                                                  const SizedBox(height: 5),
                                                  RatingBar.builder(
                                                    initialRating: double.parse(
                                                        data.rating),
                                                    itemSize: 15,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    ignoreGestures: true,
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate:
                                                        (startRating) {
                                                      log(startRating
                                                          .toString());
                                                    },
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        '₹',
                                                        style: TextStyle(
                                                          fontSize: 19,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${data.discountPrice}",
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              "PTSerif-Regular",
                                                          fontSize: 19,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const Text(
                                                        '₹',
                                                        style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          color: Color.fromARGB(
                                                              255,
                                                              108,
                                                              107,
                                                              107),
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${data.price}",
                                                        style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              108,
                                                              107,
                                                              107),
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          fontSize: 15,
                                                          fontFamily:
                                                              "PTSerif-Regular",
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Text(
                                                        "(${data.offer}%)",
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              "PTSerif-Regular",
                                                          fontSize: 15,
                                                          color: Colors.orange,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 30),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox();
                            },
                            itemCount: home.searchData.length,
                          );
                        },
                      ),
                    ));
        },
      ),
    );
  }
}
