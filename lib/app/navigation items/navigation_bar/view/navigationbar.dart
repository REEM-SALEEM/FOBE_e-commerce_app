import 'dart:developer';

import 'package:badges/badges.dart' as badges;
import 'package:finalproject/app/core/const.dart';
import 'package:finalproject/app/navigation%20items/cart/provider/cart_prov.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CartProvider>(context, listen: false).getCart(context);
    });
    return Consumer<NavigationIndex>(
      builder: (BuildContext context, data, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: data.pages[data.currentIndex],
          bottomNavigationBar: SizedBox(
            height: 70,
            child: Container(
              decoration: const BoxDecoration(
                  color: kBlackcolor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: BottomNavigationBar(
                items: [
                  const BottomNavigationBarItem(
                      backgroundColor: kBlackcolor,
                      icon: Icon(
                        Icons.home,
                        size: 25,
                      ),
                      label: 'Home'),
                  BottomNavigationBarItem(
                    icon: Consumer<CartProvider>(
                      builder: (BuildContext context, value, Widget? child) {
                        log('dfsdf${value.totalproductCount.toString()}');
                        return value.totalproductCount == 0
                            ? const Icon(
                                Icons.shopping_cart,
                              )
                            : badges.Badge(
                                badgeContent: Text(
                                  value.totalproductCount.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.shopping_cart,
                                ),
                              );
                      },
                    ),
                    label: 'Cart',
                  ),
                  const BottomNavigationBarItem(
                      icon: Icon(
                        Icons.favorite,
                        size: 25,
                      ),
                      label: 'Wishlist'),
                  const BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person,
                        size: 25,
                      ),
                      label: 'Account'),
                ],
                unselectedItemColor: const Color.fromARGB(255, 139, 138, 138),
                selectedItemColor: const Color.fromARGB(255, 49, 47, 47),
              // showSelectedLabels: false,
              // showUnselectedLabels: false,
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
