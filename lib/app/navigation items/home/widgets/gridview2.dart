import 'package:finalproject/app/navigation%20items/home/provider/home_prov.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetGridView2 extends StatelessWidget {
  WidgetGridView2({Key? key}) : super(key: key);

  List<String> names = [
    'Womens fashion',
    'Christmas outfits',
    'Iphone 14 pro',
    'Accessories',
    'Shoes',
    'Mens fashion',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<HomeProv>(
      builder: (BuildContext context, value, Widget? child) {
        return GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 5.1 / 6,
          ),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  height: size.height * 0.2,
                  width: size.width * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(value.items1[index]),
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: size.width * 0.4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(names[index]),
                      Text('₹${index * 5000 + index + 200}',
                          style: TextStyle()),
                    ],
                  ),
                ),
              ],
            );
          },
          itemCount: value.items1.length,
        );
      },
    );
  }
}
