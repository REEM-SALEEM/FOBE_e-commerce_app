import 'package:finalproject/app/core/const.dart';
import 'package:finalproject/app/navigation%20items/home/widgets/carousel.dart';
import 'package:finalproject/app/navigation%20items/home/widgets/category.dart';
import 'package:finalproject/app/navigation%20items/home/widgets/gridview1.dart';
import 'package:finalproject/app/navigation%20items/home/widgets/gridview2.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhitecolor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(
                    Icons.sort,
                    size: 35,
                    color: kBlackcolor,
                  ),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: TextFormField(
                      // controller: value.search,
                      decoration: InputDecoration(
                        hintText: " Search",
                        suffixIcon: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.search)),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.favorite_border_outlined,
                    size: 32,
                    color: kGrey,
                  ),
                ],
              ),
              iHeight18,
              const WidgetCarousel(),
              iHeight18,
              const Text('   Category', style: textstyle1),
              iHeight8,
              const WidgetCategoryListview(),
              const SizedBox(height: 20),
              const Text('   Newly Launched', style: textstyle1),
              const WidgetGridView(),
              iHeight10,
              const Text('   New Item', style: textstyle1),
              iHeight8,
              WidgetGridView2(),
            ],
          ),
        ),
      ),
    );
  }
}
