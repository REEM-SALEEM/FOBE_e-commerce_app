import 'package:finalproject/app/core/const.dart';
import 'package:finalproject/app/navigation%20items/navigation_bar/provider/index_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationIndex>(
      builder: (BuildContext context, data, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: data
              .pages[data.currentIndex], //content to be displayed inside body.
          bottomNavigationBar: SizedBox(
            height: 70,
            child: Container(
              decoration: const BoxDecoration(
                  color: kBlackcolor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                      backgroundColor: kBlackcolor,
                      icon: Icon(
                        Icons.home,
                        size: 25,
                      ),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.shopping_cart,
                        size: 25,
                      ),
                      label: 'Cart'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.local_offer,
                        size: 25,
                      ),
                      label: 'Wishlist'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person,
                        size: 25,
                      ),
                      label: 'Account'),
                ],
                unselectedItemColor: const Color.fromARGB(255, 106, 104, 104),
                selectedItemColor: const Color.fromARGB(255, 49, 47, 47),
                // showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                currentIndex: data.currentIndex,
                onTap: (index) {
                  Provider.of<NavigationIndex>(context, listen: false)
                      .bottomNav(index);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
