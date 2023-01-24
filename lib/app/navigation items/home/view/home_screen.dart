import 'package:finalproject/app/core/const.dart';
import 'package:finalproject/app/navigation%20items/home/provider/connectivity_prov.dart';
import 'package:finalproject/app/navigation%20items/home/widgets/carousel.dart';
import 'package:finalproject/app/navigation%20items/home/widgets/category.dart';
import 'package:finalproject/app/navigation%20items/home/widgets/gridview1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<ProvConnectivity>(context, listen: false)
        .getConnectivity(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<ProvConnectivity>(
        builder: (context, value, child) {
          value.getConnectivity(context);
          return Scaffold(
            backgroundColor: kWhitecolor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.search,
                    size: 30,
                  ),
                )
              ],
              backgroundColor: Colors.white,
              elevation: 0,
              title: SizedBox(
                  height: 90,
                  width: 90,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Image.asset("assets/fobehome.png"),
                  )),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
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
            ),
          );
        },
      ),
    );
  }
}
